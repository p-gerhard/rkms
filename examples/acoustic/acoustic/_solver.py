from __future__ import annotations

import os
import meshio
import numpy as np
import pyopencl as cl
import pyopencl.array as cl_array
from rkms.solver import FVSolverCl, FVTimeMode, get_progressbar
from rkms.model import SN
import matplotlib.pyplot as plt


class AcousticFVSolverCL(FVSolverCl):
    def __init__(
        self,
        *args,
        **kwargs,
    ) -> None:
        super().__init__(*args, **kwargs)

    def _halloc(self) -> None:
        # Solver host buffers are allocated by FVSolverCl class
        super()._halloc()

        if isinstance(self.model, SN):
            # Host buffer storing eventual reconstructed variables
            self.wn_rec_h = np.empty(
                self.mesh.nb_cells * (self.mesh.dim + 1),
                dtype=self.dtype,
            )

    def _dalloc(self, ocl_queue):
        # Solver host buffers are allocated by FVSolverCl class
        super()._dalloc(ocl_queue)

        if isinstance(self.model, SN):
            self.wn_rec_d = cl_array.empty(
                ocl_queue,
                self.mesh.nb_cells * (self.mesh.dim + 1),
                dtype=self.dtype,
            )

    @property
    def cl_build_opts(self):
        opts = super().cl_build_opts

        return opts

    # TODO: Rewrite _init_sol
    def _init_sol(self, ocl_queue, ocl_prg) -> None:
        super()._init_sol(ocl_queue, ocl_prg)

    def _export_data(self, ocl_queue, writer):
        nc = self.mesh.nb_cells

        # Base values
        cell_data = {
            "w_{}".format(k): {self.mesh.cell_name: self.wn_h[k * nc : (k + 1) * nc]}
            for k in self.export_idx
        }

        cl.enqueue_copy(ocl_queue, self.wn_h, self.wn_d.data).wait()

        if isinstance(self.model, SN):
            cell_data.update(
                {
                    "w_rec_{}".format(k): {
                        self.mesh.cell_name: self.wn_rec_h[k * nc : (k + 1) * nc]
                    }
                    for k in range((self.mesh.dim + 1))
                }
            )

            cl.enqueue_copy(ocl_queue, self.wn_rec_h, self.wn_rec_d.data).wait()

        writer.write_data(self.t, cell_data=cell_data)

    def _solve(self, ocl_queue, ocl_prg) -> None:
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

            if isinstance(self.model, SN):
                self.ocl_prg.sn_reconstruct_macro_field(
                    self.ocl_queue,
                    (self.mesh.nb_cells,),
                    None,
                    self.wn_d.data,
                    self.wn_rec_d.data,
                ).wait()
                w0_tot = [
                    np.float64(
                        cl_array.sum(self.wn_rec_d[0 : self.mesh.nb_cells]).get()
                    ),
                ]

            else:
                w0_tot = [
                    np.float64(cl_array.sum(self.wn_d[0 : self.mesh.nb_cells]).get()),
                ]

            times = [self.t]

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

                if isinstance(self.model, SN):
                    self.ocl_prg.sn_reconstruct_macro_field(
                        self.ocl_queue,
                        (self.mesh.nb_cells,),
                        None,
                        self.wn_d.data,
                        self.wn_rec_d.data,
                    ).wait()

                    w0_tot = [
                        np.float64(
                            cl_array.sum(self.wn_rec_d[0 : self.mesh.nb_cells]).get()
                        ),
                    ]
                else:
                    w0_tot.append(
                        np.float64(
                            cl_array.sum(self.wn_d[0 : self.mesh.nb_cells]).get()
                        )
                    )

                times.append(self.t)

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

        plt.plot(times, w0_tot)
        plt.show()

    # print(w0_tot)
