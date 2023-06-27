#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import logging
import os
import time

import meshio
import numpy as np
import pyopencl as cl
import pyopencl.array as cl_array
from pyopencl import _find_pyopencl_include_path

from rkms.common import *
from rkms.mesh import MeshStructured

from .cl_helpers import *
from .helpers import *
from .model import Model

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

logging.basicConfig(
    format="[%(asctime)s] - %(levelname)s - %(message)s",
    datefmt="%m/%d/%Y %I:%M:%S %p",
)

XDMF_FILE_NAME = "results.xmf"
JSON_FILE_NAME = "parameters.json"
CL_BUILD_DIR_NAME = "build"
CL_PATH_SOLVER_FILE = "cl/solver/muscl_finite_volume.cl"
CL_SOLVER_INCLUDE_DIRS = ["./cl"]

py_simulation_dir = os.path.dirname(os.path.abspath(__file__))


def get_vf_euler_o1_dt(dim, cfl, dx, dy, dz=0.0) -> np.float32:
    if dim == 2:
        dt = cfl * (dx * dy) / (2.0 * dx + 2.0 * dy)

    if dim == 3:
        dt = cfl * (dx * dy * dz) / (2.0 * (dx * dy + dy * dz + dz * dx))

    return np.float32(dt)


class Simulation:
    def __init__(
        self,
        model: Model,
        tmax: np.float32,
        cfl: np.float32,
        filename: str,
        output_dir: str | None = None,
        use_muscl: bool = False,
        overwrite=True,
        **kwargs
    ):
        # Set simulation final time
        assert isinstance(tmax, (int, float)) and tmax >= 0
        self.tmax = np.float32(tmax)

        # Set finite volume Euler scheme CFL value
        assert isinstance(cfl, (int, float)) and cfl >= 0
        self.cfl = np.float32(cfl)

        # Store reduced kinetic model object
        assert isinstance(model, Model)
        self.model = model

        # Toggle on/off finite volume MUSCL slope limiter
        assert isinstance(use_muscl, bool)
        self.use_muscl = use_muscl

        # Read mesh
        self.mesh = MeshStructured(filename)

        # Build OpenCL compilation options
        self.cl_build_opts = [""]
        self.cl_build_opts.extend(self.model.cl_build_opts)

        # Add MUSCL OpenCL compilation options
        if self.use_muscl:
            self.cl_build_opts.append("-D USE_MUSCL")

        # Compute dt for finite volume Euler scheme CFL value
        self.dt = get_vf_euler_o1_dt(
            self.mesh.dim,
            self.cfl,
            self.mesh.dx,
            self.mesh.dy,
            self.mesh.dz,
        )

        # WARNING: If files already exist they will be removed when
        # overwrite==True
        assert isinstance(overwrite, bool)
        self.overwrite = overwrite

        # Setup output directory
        sub_dir = time.strftime("run_%Y%m%d_%H%M%S")
        if output_dir is None:
            base_dir = os.path.abspath(os.getcwd())
        else:
            base_dir = os.path.abspath(output_dir)

        self.output_dir = os.path.join(base_dir, sub_dir)

        if not os.path.exists(self.output_dir):
            os.makedirs(self.output_dir)

        # Create cl build directory
        self.cl_build_dir = os.path.join(
            self.output_dir,
            CL_BUILD_DIR_NAME,
        )
        if not os.path.exists(self.cl_build_dir):
            os.makedirs(self.cl_build_dir)

        # Default cl solver file will be copied in ocl_build
        self.cl_solver_file = os.path.join(
            os.path.dirname(os.path.abspath(__file__)),
            CL_PATH_SOLVER_FILE,
        )

        self.cl_solver_include_dirs = [
            os.path.join(os.path.dirname(os.path.abspath(__file__)), dir)
            for dir in CL_SOLVER_INCLUDE_DIRS
        ]

        # Destination path for cl_solver_filer
        dest = os.path.join(self.cl_build_dir, CL_PATH_SOLVER_FILE)

        if self.overwrite:
            try_remove(dest)

        if not os.path.exists(dest):
            shutil.copy(self.cl_solver_file, self.cl_build_dir)

        # Setup path of solution (.xmf) file
        self.output_xdmf = os.path.join(
            self.output_dir,
            XDMF_FILE_NAME,
        )

        # Setup path for simulation parameters (.json) file
        self.output_json = os.path.join(
            self.output_dir,
            JSON_FILE_NAME,
        )

        if self.overwrite:
            try_remove(self.output_xdmf)
            try_remove(self.output_json)

        # Storing extra user parameters
        self.extra_parameters = kwargs

    def get_params_to_print(self):
        params = {
            "tmax": self.tmax,
            "dt": self.dt,
            "CFL": self.cfl,
            "Use MUSCL": self.use_muscl,
            "CL full compile options": self.cl_build_opts,
            "Folder CL build": self.cl_build_dir,
            "Folder results": self.output_dir,
            "File XMDF": self.output_xdmf,
            "File JSON": self.output_json,
            "Overwrite existing results": self.overwrite,
            "Extra user parameters": self.extra_parameters,
        }
        return params

    def get_cl_solver_inject_vals(self):
        # OpenCL Numerical parameters always needed by the solver
        inject_vals = {
            "__TMAX__": self.tmax,
            "__CFL__": self.cfl,
            "__DIM__": self.mesh.dim,
            "__DT__": self.dt,
            "__DX__": self.mesh.dx,
            "__DY__": self.mesh.dy,
            "__DZ__": self.mesh.dz,
            "__NGRID__": self.mesh.nb_cells,
            "__M__": self.model.m,
        }

        return inject_vals

    def print_infos(self, all=True):
        params = self.get_params_to_print()
        pprint_dict(params, header_msg="SIMULATION INFOS")

        # Print additional block like mesh and model
        if all:
            extra_blocks = [self.mesh, self.model]
            for blk in extra_blocks:
                blk.print_infos()

    def __allocate_devices_buffer(self):
        buf_size = self.model.m * self.mesh.nb_cells

        # Store ALL solution values wn -> w(t)
        self.wn_dev = cl_array.empty(
            self.ocl_queue,
            buf_size,
            dtype=np.float32,
        )

        # Store ALL solution values wnp1 -> w(t + dt)
        self.wnp1_dev = cl_array.empty(
            self.ocl_queue,
            buf_size,
            dtype=np.float32,
        )

        # Store ALL cells center coordinates
        self.cells_center_dev = cl_array.to_device(
            self.ocl_queue,
            self.mesh.cells_center,
        )

        # Store ALL cells neighbours ID
        self.elem2elem_dev = cl_array.to_device(
            self.ocl_queue,
            self.mesh.elem2elem,
        )

        # Memory size estimation of ALL buffers
        gpu_memory = self.wn_dev.nbytes
        gpu_memory += self.wnp1_dev.nbytes
        gpu_memory += self.cells_center_dev.nbytes
        gpu_memory += self.elem2elem_dev.nbytes

        if self.model.nb_macro_to_reconstruct > 0:
            self.wn_macro_dev = cl_array.empty(
                self.ocl_queue,
                self.model.nb_macro_to_reconstruct * self.mesh.nb_cells,
                dtype=np.float32,
            )
            gpu_memory += self.wn_macro_dev.nbytes

        logger.info(
            "Allocated {:>6.8f} MB on devices".format(gpu_memory / 1e6),
        )

    def __allocate_host_buffer(self):
        # Host buffer for memory copies
        if self.model.nb_macro_to_reconstruct > 0:
            buf_size = self.model.nb_macro_to_reconstruct * self.mesh.nb_cells
            self.wn_macro_host = np.empty(
                buf_size,
                dtype=np.float32,
            )

        # Host solution that will be dump
        self.wn_host = np.empty(
            self.model.m * self.mesh.nb_cells,
            dtype=np.float32,
        )

    def __export_data(self, xdmf_writer):
        nc = self.mesh.nb_cells

        if self.model.nb_macro_to_reconstruct > 0:
            self.ocl_prg.sn_compute_macro(
                self.ocl_queue,
                (self.mesh.nb_cells,),
                None,
                self.wn_dev.data,
                self.wn_macro_dev.data,
            ).wait()

            # w = cl_array.sum(self.wn_macro_dev[0:nc]).get()

            cd = {
                "w_macro_{}".format(k): {
                    self.mesh.cell_name: self.wn_macro_host[k * nc : (k + 1) * nc]
                }
                for k in range(np.min(self.model.m, self.model.nb_macro_to_reconstruct))
            }
            cl.enqueue_copy(
                self.ocl_queue, self.wn_macro_host, self.wn_macro_dev.data
            ).wait()
        else:
            # w = cl_array.sum(self.wn_dev[0:nc]).get()

            cd = {
                "w_{}".format(k): {
                    self.mesh.cell_name: self.wn_host[k * nc : (k + 1) * nc]
                }
                for k in range(1)
            }

            cl.enqueue_copy(self.ocl_queue, self.wn_host, self.wn_dev.data).wait()

        xdmf_writer.write_data(self.t, cell_data=cd)

    def solve(self):
        self.ocl_ctx, self.ocl_prg = cl_build_program(
            self.cl_build_dir,
            self.model.cl_src_file,
            self.model.cl_inject_vals,
            self.cl_build_opts,
            self.model.cl_include_dirs,
            self.get_cl_solver_inject_vals(),
            self.cl_solver_include_dirs,
            # self.cl_build_opts,
        )

        self.ocl_prop = cl.command_queue_properties.PROFILING_ENABLE
        self.ocl_queue = cl.CommandQueue(
            self.ocl_ctx,
            properties=self.ocl_prop,
        )

        self.__allocate_devices_buffer()
        self.__allocate_host_buffer()

        self.t = 0
        ite = 0

        logger.info("{:<30}".format("Starting computation..."))

        t1 = time.time()

        # Call CL Kernel initializing solution at t_{n}
        self.ocl_prg.solver_init_sol(
            self.ocl_queue,
            (self.mesh.nb_cells,),
            None,
            self.cells_center_dev.data,
            self.wn_dev.data,
        ).wait()

        # Setup CL Kernel time step
        time_step = self.ocl_prg.solver_time_step
        time_step.set_scalar_arg_dtypes([np.float32, None, None, None, None])

        with meshio.xdmf.TimeSeriesWriter(self.output_xdmf) as xdmf_writer:
            xdmf_writer.write_points_cells(
                self.mesh.nodes, [(self.mesh.cell_name, self.mesh.cells)]
            )
            while self.t <= self.tmax:
                if ite % 40 == 0:
                    self.__export_data(xdmf_writer)

                time_step(
                    self.ocl_queue,
                    (self.mesh.nb_cells,),
                    None,
                    self.t,
                    self.cells_center_dev.data,
                    self.elem2elem_dev.data,
                    self.wn_dev.data,
                    self.wnp1_dev.data,
                ).wait()

                self.wn_dev, self.wnp1_dev = self.wnp1_dev, self.wn_dev
                self.t += self.dt

                print(get_ite_title(ite, self.t, 0), end="\r")
                ite += 1
        t2 = time.time()

        logger.info("Computation done in {:>6.8f} sec".format(t2 - t1))
