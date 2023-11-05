from __future__ import annotations

import os
import meshio
import numpy as np
import pyopencl as cl
import pyopencl.array as cl_array

from rkms.model import Model
from rkms.solver import FVSolverCl, FVTimeMode, get_progressbar

# Set some env. variables to control pyopencl and nvidia platfrom behaviours
os.environ["PYOPENCL_NO_CACHE"] = "1"
os.environ["PYOPENCL_COMPILER_OUTPUT"] = "1"
os.environ["CUDA_CACHE_DISABLE"] = "1"

# Autoselect OpenCL platform #0
os.environ["PYOPENCL_CTX"] = "0"


################################################################################
# Astro - FVSolverCL for chemistry
################################################################################


class AstroFVSolverCL(FVSolverCl):
    def _halloc(self) -> None:
        # Solver host buffers are allocated by FVSolverCl class
        super()._halloc()

        # Solution buffer size
        size = self.mesh.nb_cells

        # Set host buffer storing hydrogen density values at t_n
        self.nh_h = np.empty(size, dtype=np.float32)

        # Set host buffer storing temperature values at t_n
        self.temp_h = np.empty(size, dtype=np.float32)

        # Set host buffer storing neutral fraction values at t_n
        self.xi_h = np.empty(size, dtype=np.float32)

    def _dalloc(self, ocl_queue):
        # Solver host buffers are allocated by FVSolverCl class
        super()._dalloc(ocl_queue)

        # Set solution buffer size
        size = self.mesh.nb_cells

        # Set device buffer storing hydrogen density values at t_n
        self.nh_d = cl_array.empty(ocl_queue, size, dtype=np.float32)

        # Set device buffer storing temperature values at t_n
        self.temp_d = cl_array.empty(ocl_queue, size, dtype=np.float32)

        # Set device buffer storing neutral fraction values at t_n
        self.xi_d = cl_array.empty(ocl_queue, size, dtype=np.float32)

    # TODO: Rewrite _init_sol
    def _init_sol(self, ocl_queue, ocl_prg) -> None:
        super()._init_sol(ocl_queue, ocl_prg)

        # Call CL Kernel initializing chemistry at t_{0}
        ocl_prg.chem_init_sol(
            ocl_queue,
            (self.mesh.nb_cells,),
            None,
            self.nh_d.data,
            self.temp_d.data,
            self.xi_d.data,
        ).wait()

    def _export_data(self, ocl_queue, writer):
        nc = self.mesh.nb_cells

        #  Moments values
        cell_data = {
            "w_{}".format(k): {self.mesh.cell_name: self.wn_h[k * nc : (k + 1) * nc]}
            for k in self.export_idx
        }

        # Add chemistry values
        cell_data.update(
            {
                "Nh": {self.mesh.cell_name: self.nh_h},
                "T": {self.mesh.cell_name: self.temp_h},
                "xi": {self.mesh.cell_name: self.xi_h},
            }
        )

        # Copy buffers from device to host
        cl.enqueue_copy(ocl_queue, self.wn_h, self.wn_d.data).wait()
        cl.enqueue_copy(ocl_queue, self.nh_h, self.nh_d.data).wait()
        cl.enqueue_copy(ocl_queue, self.temp_h, self.temp_d.data).wait()
        cl.enqueue_copy(ocl_queue, self.xi_h, self.xi_d.data).wait()

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

                ocl_prg.chem_step(
                    ocl_queue,
                    (self.mesh.nb_cells,),
                    None,
                    self.nh_d.data,
                    self.wn_d.data,
                    self.temp_d.data,
                    self.xi_d.data,
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
                    self.iter,
                    self.time_data.iter_max,
                    self.t,
                    self.time_data.tmax,
                )


################################################################################
# GENERIC PN MODEL
################################################################################


# Declare generic PN model using inheritance
class PN(Model):
    def __init__(self, order: int, dim: int):
        super().__init__(
            order,
            dim,
            cl_build_opts=[
                "-D IS_SPHERICAL_HARMONICS_MODELS",
                "-D USE_SPHERICAL_HARMONICS_P{order}".format(order=order),
                "-cl-fast-relaxed-math",
            ],
            cl_src_file="./cl/astro/pn/pn.cl",
            cl_include_dirs=["./cl/astro/pn"],
        )

        if dim == 2:
            self.m = int((order * order / 2.0) + (3.0 * order / 2.0) + 1.0)
        else:
            self.m = int((order + 1.0) * (order + 1.0))


################################################################################
# AVAILABLE PN MODELS - DIM 2
################################################################################


# Declare generic PND2 model using inheritance
class PND2(PN):
    def __init__(self, order: int):
        super().__init__(order, dim=2)


# Declare model PN Dim=2, Order=1
class P1D2(PND2):
    def __init__(self) -> None:
        super().__init__(order=1)


# Declare model PN Dim=2, Order=3
class P3D2(PND2):
    def __init__(self) -> None:
        super().__init__(order=3)


# Declare model PN Dim=2, Order=5
class P5D2(PND2):
    def __init__(self) -> None:
        super().__init__(order=5)


# Declare model PN Dim=2, Order=7
class P7D2(PND2):
    def __init__(self) -> None:
        super().__init__(order=7)


# Declare model PN Dim=2, Order=9
class P9D2(PND2):
    def __init__(self) -> None:
        super().__init__(order=9)


# Declare model PN Dim=2, Order=11
class P11D2(PND2):
    def __init__(self) -> None:
        super().__init__(order=11)


################################################################################
# AVAILABLE PN MODELS - DIM 3
################################################################################


# Declare generic PND2 model using inheritance
class PND3(PN):
    def __init__(self, order: int):
        super().__init__(order, dim=3)


# Declare model PN Dim=3, Order=1
class P1D3(PND3):
    def __init__(self) -> None:
        super().__init__(order=1)


# Declare model PN Dim=3, Order=3
class P3D3(PND3):
    def __init__(self) -> None:
        super().__init__(order=3)


# Declare model PN Dim=3, Order=5
class P5D3(PND3):
    def __init__(self) -> None:
        super().__init__(order=5)


# Declare model PN Dim=3, Order=7
class P7D3(PND3):
    def __init__(self) -> None:
        super().__init__(order=7)


# Declare model PN Dim=3, Order=9
class P9D3(PND3):
    def __init__(self) -> None:
        super().__init__(order=9)


# Declare model PN Dim=3, Order=11
class P11D3(PND3):
    def __init__(self) -> None:
        super().__init__(order=11)


if __name__ == "__main__":
    solve_d2 = False

    if solve_d2:
        m = P5D2()
        # filename = "./meshes/q4_unit_square_nx2_ny2.msh"
        # filename = "./meshes/q4_unit_square_nx1024_ny1024.msh"
    else:
        m = P1D3()
        filename = "./meshes/unit_cube_nx100_ny100_nz100.msh"
        # filename = "./meshes/unit_cube_nx8_ny8_nz8.msh"

    s = AstroFVSolverCL(
        filename=filename,
        model=m,
        time_mode=FVTimeMode.FORCE_ITERMAX_FROM_CFL,
        tmax=1,
        cfl=0.9,
        dt=None,
        iter_max=100,
        use_muscl=True,
        export_idx=[0, 1, 2],
        export_frq=40,
    )

    s.run()
