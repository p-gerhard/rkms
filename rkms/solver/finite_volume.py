from __future__ import annotations

from enum import Enum
import logging
import os
import time

import meshio
import numpy as np
import pyopencl as cl
import pyopencl.array as cl_array

from rkms.mesh import MeshStructured
from rkms.model import Model

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


# Floating poing precision of np.float32
CLOSE_TOL = np.MachAr(float_conv=np.float32).eps


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
        time_mode: FVTimeMode,
        hmin: np.float32 | None,
        tmax: np.float32 | None = None,
        dt: np.float32 | None = None,
        cfl: np.float32 | None = None,
        iter_max: np.int32 | None = None,
    ):
        # Set time mode
        assert isinstance(time_mode, FVTimeMode)
        self.time_mode = time_mode

        # Set hmin
        assert hmin >= 0.0
        self.hmin = np.float32(hmin)

        self.tmax = tmax
        self.dt = dt
        self.cfl = cfl
        self.iter_max = iter_max

        # Set full time data
        self._set_time_data()

        # Check CFL is coherent with dt and hmin
        assert (
            np.abs(self.cfl - FVTimeData._compute_cfl(self.dt, self.hmin)) < CLOSE_TOL
        )

        # Check iter_max is coherent with tmax and dt
        assert (
            np.abs(self.iter_max - FVTimeData._compute_iter_max(self.tmax, self.dt))
            < CLOSE_TOL
        )

    @staticmethod
    def _compute_cfl(dt: np.float32, hmin: np.float32) -> np.float32:
        return np.float32(dt / hmin)

    @staticmethod
    def _compute_dt(cfl: np.float32, hmin: np.float32) -> np.float32:
        return np.float32(cfl * hmin)

    @staticmethod
    def _compute_iter_max(tmax: np.float32, dt: np.float32) -> np.int32:
        return np.int32(np.floor((tmax + CLOSE_TOL) / dt))

    @staticmethod
    def _compute_tmax(iter_max: np.int32, dt: np.float32) -> np.int32:
        return np.float32(iter_max * dt)

    def _force_tmax(self) -> None:
        assert self.tmax >= 0.0

        # Compute dt and iter_max
        self.dt = FVTimeData._compute_dt(self.cfl, self.hmin)
        self.iter_max = FVTimeData._compute_iter_max(self.tmax, self.dt)

        # Compute tmax discrepency using current dt
        diff_tmax = self.tmax - self.iter_max * self.dt

        if self.iter_max > 0:
            # Adjust dt to make diff_time vanish
            if diff_tmax > np.float32(0.0):
                self.dt += diff_tmax / self.iter_max
            else:
                self.dt -= diff_tmax / self.iter_max
        else:
            self.iter_max = np.int32(1)
            self.dt = np.float32(self.tmax)

        # Ensure that tmax is reach with this dt and iter_max values
        assert abs(self.tmax - self.dt * self.iter_max) < CLOSE_TOL

        # Adjust CFL using the final dt
        self.cfl = FVTimeData._compute_cfl(self.dt, self.hmin)

    def _force_tmax_from_cfl(self) -> None:
        assert self.cfl >= 0.0
        self.dt = FVTimeData._compute_dt(self.cfl, self.hmin)
        self._force_tmax()

    def _force_tmax_from_dt(self) -> None:
        assert self.dt >= 0.0
        self._force_tmax()

    def _force_cfl(self) -> None:
        assert self.tmax >= 0.0
        assert self.cfl >= 0.0

        self.dt = FVTimeData._compute_dt(self.cfl, self.hmin)
        self.iter_max = FVTimeData._compute_iter_max(self.tmax, self.dt)
        self.tmax = FVTimeData._compute_tmax(self.iter_max, self.dt)

    def _force_dt(self) -> None:
        assert self.tmax >= 0.0
        assert self.dt >= 0.0

        self.cfl = FVTimeData._compute_cfl(self.dt, self.hmin)
        self.iter_max = FVTimeData._compute_iter_max(self.tmax, self.dt)
        self.tmax = FVTimeData._compute_tmax(self.iter_max, self.dt)

    def _force_iter_max_from_cfl(self) -> None:
        assert self.iter_max >= 0
        assert self.cfl >= 0.0

        self.dt = FVTimeData._compute_dt(self.cfl, self.hmin)
        self.tmax = FVTimeData._compute_tmax(self.iter_max, self.dt)

    def _force_iter_max_from_dt(self) -> None:
        assert self.iter_max >= 0
        assert self.dt >= 0.0

        self.cfl = FVTimeData._compute_cfl(self.dt, self.hmin)
        self.tmax = FVTimeData._compute_tmax(self.iter_max, self.dt)

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
        filename: str,
        model: Model,
        time_mode: FVTimeMode,
        tmax: np.float32 | None = None,
        cfl: np.float32 | None = None,
        dt: np.float32 | None = None,
        iter_max: np.int32 | None = None,
        use_muscl: bool = False,
        export_dir: str | None = None,
        export_idx: list[int] | None = None,
        export_frq: int | None = None,
        **kwargs,
    ) -> None:
        # Set mesh object
        assert isinstance(filename, str)
        self.mesh = MeshStructured(filename)

        # Set mesh hmin
        self.hmin = FVSolverCl._compute_hmin(
            self.mesh.dim,
            self.mesh.dx,
            self.mesh.dy,
            self.mesh.dz,
        )

        # Set time data
        self.time_data = FVTimeData(time_mode, self.hmin, tmax, dt, cfl, iter_max)

        # Set time
        self.t = np.float32(0.0)

        # Set iteration
        self.iter = 0

        # Set model object
        assert isinstance(model, Model)
        self.model = model

        # Set export directory
        if export_dir is None:
            self.export_dir = os.path.abspath(os.getcwd())
        else:
            assert isinstance(export_dir, str)
            self.export_dir = os.path.abspath(export_dir)

        self.export_dir = os.path.join(
            self.export_dir,
            time.strftime("run_%Y%m%d_%H%M%S"),
        )

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

    @staticmethod
    def _compute_hmin(
        dim: np.int32,
        dx: np.float32,
        dy: np.float32,
        dz: np.float32,
    ) -> np.float32:
        if dim == 2:
            cell_v = np.float32(dx * dy)
            cell_s = np.float32(2.0 * dx + 2.0 * dy)

        else:
            cell_v = np.float32(dx * dy * dz)
            cell_s = np.float32(2.0 * (dx * dy + dy * dz + dz * dx))

        return cell_v / cell_s

    def _halloc(self) -> None:
        # Solution buffer size
        size = self.model.m * self.mesh.nb_cells

        # Host buffer storing solution values at t_n
        self.wn_h = np.empty(size, dtype=np.float32)

        # Reconstructed variables buffer size
        size = self.model.nb_macro_to_reconstruct * self.mesh.nb_cells

        # Host buffer storing eventual reconstructed variables
        self.wn_rec_h = np.empty(size, dtype=np.float32)

    @property
    def cl_replace_map(self) -> dict:
        replace_map = self.model.cl_replace_map.copy()
        replace_map.update(
            {
                "__CFL__": self.time_data.cfl,
                "__DIM__": self.mesh.dim,
                "__DT__": self.time_data.dt,
                "__DX__": self.mesh.dx,
                "__DY__": self.mesh.dy,
                "__DZ__": self.mesh.dz,
                "__M__": self.model.m,
                "__NGRID__": self.mesh.nb_cells,
                "__TMAX__": self.time_data.tmax,
            }
        )
        return replace_map

    @property
    def cl_src_file(self) -> str:
        return self.model.cl_src_file

    @property
    def cl_include_dirs(self) -> list[str]:
        return [os.path.join(os.path.dirname(os.path.abspath(__file__)), "cl")]

    @property
    def cl_build_opts(self) -> list[str]:
        # Set solver default build options
        opts = ["-Werror", "-cl-std=CL1.2"]

        # Add solver defines
        if self.use_muscl:
            opts.append("-D USE_MUSCL")

        # Add solver include dirs
        opts += ["-I {}".format(dir) for dir in self.cl_include_dirs]

        # Add model build options
        opts += self.model.cl_build_opts

        # Add model include dirs
        opts += ["-I {}".format(dir) for dir in self.model.cl_include_dirs]

        return list(set(opts))

    def _dalloc(self, ocl_queue) -> None:
        # Set solution buffer size
        size = self.model.m * self.mesh.nb_cells

        # Set device buffer storing solution values at t_n
        self.wn_d = cl_array.empty(ocl_queue, size, dtype=np.float32)

        # Set device buffer storing solution values at t_{n+1}
        self.wnp1_d = cl_array.empty(
            ocl_queue,
            size,
            dtype=np.float32,
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

        # Set reconstructed variables buffer size
        size = self.model.nb_macro_to_reconstruct * self.mesh.nb_cells

        # Set device buffer storing eventual reconstructed variables
        self.wn_rec_d = cl_array.empty(
            ocl_queue,
            size,
            dtype=np.float32,
        )

        # Compute buffer allocated size
        self.dalloc_size = get_mem_size_mb(
            "OpenCL",
            self.wn_d,
            self.wnp1_d,
            self.cells_center_d,
            self.elem2elem_d,
            self.wn_rec_d,
        )

    def _init_sol(self, ocl_queue, ocl_prg) -> None:
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

    def _solve(self, ocl_queue, ocl_prg) -> None:
        # Set OpenCL Kernel scalar arguments
        time_step = ocl_prg.solver_time_step
        time_step.set_scalar_arg_dtypes([np.float32, None, None, None, None])

        with meshio.xdmf.TimeSeriesWriter(self.export_data_file) as writer:
            # Export mesh
            writer.write_points_cells(
                self.mesh.nodes, [(self.mesh.cell_name, self.mesh.cells)]
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