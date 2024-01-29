from __future__ import annotations

from enum import Enum
import logging
import inspect
import os
import time

import meshio
import numpy as np
import pyopencl as cl
import pyopencl.array as cl_array

from rkms.mesh import MeshStructured
from rkms.model import Model
from rkms.common import cast_data

from ._solver import (
    JSON_FILE_NAME,
    XDMF_FILE_NAME,
    SolverCl,
    get_mem_size_mb,
    get_progressbar,
)

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

logging.basicConfig(
    format="[%(asctime)s] - %(levelname)s - %(message)s",
    datefmt="%m/%d/%Y %I:%M:%S %p",
)


class FVTimeMode(Enum):
    FORCE_TMAX_FROM_CFL = 0
    FORCE_TMAX_FROM_DT = 1
    FORCE_ITERMAX_FROM_CFL = 2
    FORCE_ITERMAX_FROM_DT = 3
    FORCE_CFL = 4
    FORCE_DT = 5

    def __repr__(self):
        return f"{self.name}"


class FVTimeData:
    def __init__(
        self,
        time_mode,
        hmin,
        tmax,
        dt,
        cfl,
        iter_max,
        c_wave=1.0,
        dtype=np.float32,
    ):
        # Set dtype:
        self.dtype = dtype

        # Set time mode
        assert isinstance(time_mode, FVTimeMode)
        self.time_mode = time_mode

        # Set hmin
        assert hmin >= 0.0
        self.hmin = hmin

        self.tmax = tmax
        self.dt = dt
        self.cfl = cfl
        self.iter_max = iter_max
        self.c_wave = c_wave

        # Set full time data
        self._set_time_data()

        # Check CFL is coherent with dt and hmin
        assert np.abs(self.cfl - self._compute_cfl()) < np.finfo(np.float32).eps

        # Check iter_max is coherent with tmax and dt
        assert (
            np.abs(self.iter_max - self._compute_iter_max()) < np.finfo(self.dtype).eps
        )

    def _compute_cfl(self):
        return self.dtype(self.dt * self.c_wave / self.hmin)

    def _compute_dt(self):
        return self.dtype(self.cfl * self.hmin / self.c_wave)

    def _compute_iter_max(self):
        return np.int64(np.floor((self.tmax + np.finfo(self.dtype).eps) / self.dt))

    def _compute_tmax(self):
        return self.dtype(self.iter_max * self.dt)

    def _force_tmax(self):
        assert self.tmax >= 0.0

        # Compute dt and iter_max
        self.dt = self._compute_dt()
        self.iter_max = self._compute_iter_max()

        # Compute tmax discrepency using current dt
        diff_tmax = self.tmax - self.iter_max * self.dt

        if self.iter_max > 0:
            # Adjust dt to make diff_time vanish
            if diff_tmax > self.dtype(0.0):
                self.dt += diff_tmax / self.iter_max
            else:
                self.dt -= diff_tmax / self.iter_max
        else:
            self.iter_max = np.int64(1)
            self.dt = self.dtype(self.tmax)

        # Ensure that tmax is reach with this dt and iter_max values
        assert abs(self.tmax - self.dt * self.iter_max) < np.finfo(self.dtype).eps

        # Adjust CFL using the final dt
        self.cfl = self._compute_cfl()

    def _force_tmax_from_cfl(self):
        assert self.cfl >= 0.0
        self.dt = self._compute_dt()
        self._force_tmax()

    def _force_tmax_from_dt(self):
        assert self.dt >= 0.0
        self._force_tmax()

    def _force_cfl(self):
        assert self.tmax >= 0.0
        assert self.cfl >= 0.0

        self.dt = self._compute_dt()
        self.iter_max = self._compute_iter_max()
        self.tmax = self._compute_tmax()

    def _force_dt(self):
        assert self.tmax >= 0.0
        assert self.dt >= 0.0

        self.cfl = self._compute_cfl()
        self.iter_max = self._compute_iter_max()
        self.tmax = self._compute_tmax()

    def _force_iter_max_from_cfl(self):
        assert self.iter_max >= 0
        assert self.cfl >= 0.0

        self.dt = self._compute_dt()
        self.tmax = self._compute_tmax()

    def _force_iter_max_from_dt(self):
        assert self.iter_max >= 0
        assert self.dt >= 0.0

        self.cfl = self._compute_cfl()
        self.tmax = self._compute_tmax()

    def _set_time_data(self):
        map = {
            FVTimeMode.FORCE_TMAX_FROM_CFL: self._force_tmax_from_cfl,
            FVTimeMode.FORCE_TMAX_FROM_DT: self._force_tmax_from_dt,
            FVTimeMode.FORCE_ITERMAX_FROM_CFL: self._force_iter_max_from_cfl,
            FVTimeMode.FORCE_ITERMAX_FROM_DT: self._force_iter_max_from_dt,
            FVTimeMode.FORCE_CFL: self._force_cfl,
            FVTimeMode.FORCE_DT: self._force_dt,
        }

        # Call proper function
        time_func = map.get(self.time_mode)
        if time_func is None:
            raise Exception("Error FVTimeMode not supported")
        else:
            time_func()

    def __str__(self):
        return str(self.time_mode)


class FVSolverCl(SolverCl):
    def __init__(
        self,
        mesh: MeshStructured,
        model: Model,
        time_mode: FVTimeMode,
        tmax,
        cfl,
        dt,
        iter_max: np.int64 | None = None,
        c_wave=1.0,
        use_muscl: bool = False,
        export_dir: str | None = None,
        export_idx: list[int] | None = None,
        export_frq: int | None = None,
        use_double: bool = False,
        **kwargs,
    ) -> None:
        self.mesh = mesh

        # Mesh are always constructed in np.float64
        if not use_double:
            cast_data(self.mesh, np.float32)

        # Set float/double dtype
        self.use_double = use_double
        self.dtype = np.float32
        if self.use_double:
            self.dtype = np.float64

        # Set time data
        self.time_data = FVTimeData(
            time_mode, self.mesh.hmin, tmax, dt, cfl, iter_max, c_wave
        )

        # Set time
        self.t = self.dtype(0.0)

        # Set iteration
        self.iter = 0

        # Set model object
        assert isinstance(model, Model)
        self.model = model

        # Set export directory
        if export_dir is None:
            basename = os.path.splitext(
                os.path.basename(inspect.stack()[-1].filename),
            )[0]

            self.export_dir = os.path.join(
                os.getcwd(),
                time.strftime(f"res_{basename}_%Y%m%d_%H%M%S"),
            )
            # self.export_dir = os.path.abspath(os.getcwd())
        else:
            assert isinstance(export_dir, str)
            self.export_dir = os.path.abspath(export_dir)

        if not os.path.exists(self.export_dir):
            os.makedirs(self.export_dir)

        # Set export data filename
        self.export_data_file = XDMF_FILE_NAME

        # Set export config filename
        self.export_config_file = JSON_FILE_NAME

        # Set export indexes
        self.export_idx = []
        if export_idx is None:
            self.export_idx = range(self.model.m)
        else:
            assert isinstance(export_idx, list)
            for idx in export_idx:
                assert isinstance(idx, int)
                if idx <= self.model.m:
                    self.export_idx.append(idx)

        # Set export frequency
        if export_frq is None:
            self.export_frq = self.time_data.iter_max
        else:
            assert isinstance(export_frq, int)
            self.export_frq = min(self.time_data.iter_max, export_frq)

            if self.export_frq <= 0:
                self.export_frq = self.time_data.iter_max

        # Set MUSCL slope limiter
        assert isinstance(use_muscl, bool)
        self.use_muscl = use_muscl

    def _halloc(self) -> None:
        # Solution buffer size
        size = self.model.m * self.mesh.nb_cells

        # Host buffer storing solution values at t_n
        self.wn_h = np.empty(size, dtype=self.dtype)

    @property
    def cl_replace_map(self) -> dict:
        solver_map = {
            "__CFL__": self.time_data.cfl,
            "__DIM__": self.mesh.dim,
            "__DT__": self.time_data.dt,
            "__DX__": self.mesh.dx,
            "__DY__": self.mesh.dy,
            "__DZ__": self.mesh.dz,
            "__M__": self.model.m,
            "__NGRID__": self.mesh.nb_cells,
            "__TMAX__": self.time_data.tmax,
            "__C_WAVE__": self.time_data.c_wave,
        }
        solver_map.update(self.model.cl_replace_map)
        return solver_map

    @property
    def cl_src_file(self):
        return self.model.cl_src_file

    @property
    def cl_include_dirs(self):
        return [os.path.join(os.path.dirname(os.path.abspath(__file__)), "cl")]

    @property
    def cl_build_opts(self):
        # Set solver default build options
        opts = ["-Werror", "-cl-std=CL1.2"]

        # Add solver defines
        if self.use_muscl:
            opts.append("-D USE_MUSCL")

        if self.use_double:
            opts.append("-D USE_DOUBLE")

        # Add solver include dirs
        opts += ["-I {}".format(dir) for dir in self.cl_include_dirs]

        # Add model build options
        opts += self.model.cl_build_opts

        # Add model include dirs
        opts += ["-I {}".format(dir) for dir in self.model.cl_include_dirs]

        return list(set(opts))

    def _dalloc(self, ocl_queue):
        # Set solution buffer size
        size = self.model.m * self.mesh.nb_cells

        # Set device buffer storing solution values at t_n
        self.wn_d = cl_array.empty(ocl_queue, size, dtype=self.dtype)

        # Set device buffer storing solution values at t_{n+1}
        self.wnp1_d = cl_array.empty(
            ocl_queue,
            size,
            dtype=self.dtype,
        )

        # Set device buffer storing cells center coordinates
        self.cells_center_d = cl_array.to_device(
            ocl_queue,
            self.mesh.cells_center,
        )

        # Set device buffer storing connectivity element to element
        self.elem2elem_d = cl_array.to_device(
            ocl_queue,
            self.mesh.elem2elem,
        )

    def _init_sol(self, ocl_queue, ocl_prg):
        # Call CL Kernel initializing solution at t_{n}
        ocl_prg.solver_init_sol(
            ocl_queue,
            (self.mesh.nb_cells,),
            None,
            self.cells_center_d.data,
            self.wn_d.data,
        ).wait()

    def _export_data(self, ocl_queue, writer):
        nc = self.mesh.nb_cells
        cell_data = {
            "w_{}".format(k): {self.mesh.cell_name: self.wn_h[k * nc : (k + 1) * nc]}
            for k in self.export_idx
        }

        cl.enqueue_copy(ocl_queue, self.wn_h, self.wn_d.data).wait()
        writer.write_data(self.t, cell_data=cell_data)

    def _solve(self, ocl_queue, ocl_prg):
        # Change dir now for exporter
        os.chdir(self.export_dir)

        # Set OpenCL Kernel scalar arguments
        time_step = ocl_prg.solver_time_step
        time_step.set_scalar_arg_dtypes([self.dtype, None, None, None, None])

        with meshio.xdmf.TimeSeriesWriter(self.export_data_file) as writer:
            # Export mesh
            writer.write_points_cells(
                self.mesh.points, [(self.mesh.cell_name, self.mesh.cells)]
            )

            # Export solution at t=0
            self._export_data(ocl_queue, writer)

            # Loop over time
            while self.iter < self.time_data.iter_max:
                time_step(
                    ocl_queue,
                    (self.mesh.nb_cells,),
                    None,
                    self.t,
                    self.cells_center_d.data,
                    self.elem2elem_d.data,
                    self.wn_d.data,
                    self.wnp1_d.data,
                ).wait()

                # Switching w_{n} and w_{n+1} using references
                self.wn_d, self.wnp1_d = self.wnp1_d, self.wn_d

                # Update time
                self.t += self.time_data.dt
                self.iter += 1

                # Export solution
                if (
                    self.iter % self.export_frq == 0
                    or self.iter == self.time_data.iter_max
                ):
                    self._export_data(ocl_queue, writer)

                get_progressbar(
                    self.iter, self.time_data.iter_max, self.t, self.time_data.tmax
                )
