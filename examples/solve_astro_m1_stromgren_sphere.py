from __future__ import annotations

import os
import meshio
import numpy as np
import pyopencl as cl
import pyopencl.array as cl_array

from rkms.model import Model, M1
from rkms.solver import FVSolverCl, FVTimeMode, get_progressbar
from rkms.model import M1

# Configure environment variables for controlling pyopencl and NVIDIA platform
# behaviors

# Disable caching in pyopencl
os.environ["PYOPENCL_NO_CACHE"] = "1"

# Enable compiler output in pyopencl
os.environ["PYOPENCL_COMPILER_OUTPUT"] = "1"

# Disable CUDA caching
os.environ["CUDA_CACHE_DISABLE"] = "1"

# Auto-select OpenCL platform #0
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
        self.nh_h = np.empty(size, dtype=self.dtype)

        # Set host buffer storing temperature values at t_n
        self.temp_h = np.empty(size, dtype=self.dtype)

        # Set host buffer storing neutral fraction values at t_n
        self.xi_h = np.empty(size, dtype=self.dtype)

    def _dalloc(self, ocl_queue):
        # Solver host buffers are allocated by FVSolverCl class
        super()._dalloc(ocl_queue)

        # Set solution buffer size
        size = self.mesh.nb_cells

        # Set device buffer storing hydrogen density values at t_n
        self.nh_d = cl_array.empty(ocl_queue, size, dtype=self.dtype)

        # Set device buffer storing temperature values at t_n
        self.temp_d = cl_array.empty(ocl_queue, size, dtype=self.dtype)

        # Set device buffer storing neutral fraction values at t_n
        self.xi_d = cl_array.empty(ocl_queue, size, dtype=self.dtype)

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
                "n_h": {self.mesh.cell_name: self.nh_h},
                "tmp": {self.mesh.cell_name: self.temp_h},
                "x_i": {self.mesh.cell_name: self.xi_h},
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
        time_step.set_scalar_arg_dtypes([self.dtype, None, None, None, None])

        with meshio.xdmf.TimeSeriesWriter(self.export_data_file) as writer:
            # Export mesh
            writer.write_points_cells(
                self.mesh.points, [(self.mesh.cell_name, self.mesh.cells)]
            )

            # Export solution at t=0
            self._export_data(ocl_queue, writer)

            # w0_tot = [np.float64(cl_array.sum(self.wn_d[0 : self.mesh.nb_cells]).get())]
            # times = [self.t]

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

                # WARNING: use here wnp1
                ocl_prg.chem_step(
                    ocl_queue,
                    (self.mesh.nb_cells,),
                    None,
                    self.nh_d.data,
                    self.wnp1_d.data,
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

                # w0_tot.append(np.float64(cl_array.sum(self.wn_d[0:self.mesh.nb_cells]).get()))
                # times.append(self.t)

                get_progressbar(
                    self.iter,
                    self.time_data.iter_max,
                    self.t,
                    self.time_data.tmax,
                )
        # print(w0_tot)


def get_hmin(dim, dx, dy, dz):
    if dim == 2:
        cell_v = dx * dy
        cell_s = 2.0 * (dx + dy)

    else:
        cell_v = dx * dy * dz
        cell_s = 2.0 * (dx * dy + dy * dz + dz * dx)

    return cell_v / cell_s


if __name__ == "__main__":
    # Physical constants (dim)
    phy_unit_kpc = np.float64(3.086e19)
    phy_cst_c_vaccum = np.float64(3e8)

    # Physical values (dim)
    phy_t = 100e6 * 365 * 24 * 3600
    phy_x = np.float64(6.6 * phy_unit_kpc * 2)
    phy_c = np.float64(phy_cst_c_vaccum / 1000.0)
    phy_w = np.float64(5e48)

    # Mesh values (adim)
    dim = 3
    mesh_nx = 65
    mesh_ny = 65
    mesh_nz = 65
    cfl = np.float64(0.8)
    dx = np.float64(1.0 / mesh_nx)
    dy = np.float64(1.0 / mesh_ny)
    dz = np.float64(1.0 / mesh_nz)
    c = np.float64(1.0)
    dt = cfl * np.float64(get_hmin(dim, dx, dy, dz)) / c

    phy_dx = dx * phy_x
    phy_dy = dy * phy_x
    phy_dz = dz * phy_x
    phy_dt = dt * phy_x / phy_c
    phy_w0 = phy_dt * phy_w / (phy_dx * phy_dx * phy_dx)
    phy_it = int(np.floor(phy_t / phy_dt))

    print(f"phy_c : {phy_c:.6e}")
    print(f"phy_dx: {phy_dx:.6e}")
    print(f"phy_dt: {phy_dt:.6e}")
    print(f"phy_w0: {phy_w0:.6e}")
    print(f"phy_it: {phy_it}")

    # Build M1 Model
    m = M1(
        dim,
        cl_src_file="./cl/astro/m1/main_stromgren_sphere.cl",
        cl_include_dirs=["./cl/astro/m1"],
        cl_build_opts=["-cl-fast-relaxed-math"],
        # Values injected in "./cl/astro/m1/main_stromgren_sphere.cl"
        cl_replace_map={
            "__PHY_C_DIM__": phy_c,
            "__PHY_DT_DIM__": phy_dt,
            "__PHY_W0_DIM__": phy_w0,
        },
    )

    # Build solver
    s = AstroFVSolverCL(
        filename=f"./meshes/unit_cube_nx{mesh_nx}_ny{mesh_ny}_nz{mesh_nz}.msh",
        model=m,
        time_mode=FVTimeMode.FORCE_ITERMAX_FROM_CFL,
        tmax=None,
        cfl=cfl,
        dt=None,
        iter_max=5000,
        use_muscl=False,
        export_frq=100,
        use_double=True,
        use_periodic_bd=False,
    )

    # Run solver
    s.run()
