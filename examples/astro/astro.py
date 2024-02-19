from __future__ import annotations

import os
import meshio
import numpy as np
import pyopencl as cl
import pyopencl.array as cl_array
from rkms.solver import FVSolverCl, FVTimeMode, get_progressbar

def read_astro_file_bin(filename, nx, ny, nz):
    """
    Read a binary file containing 3D data in slabs.

    Parameters:
    - filename (str): The name of the binary file.
    - nx (int): The number of elements in the x-direction.
    - ny (int): The number of elements in the y-direction.
    - nz (int): The number of elements in the z-direction.

    Returns:
    - data (ndarray): 3D numpy array (ravel) containing the read data.
    """
    assert nx >= 0 and ny >= 0 and nz >= 0

    size_t_mapping = {
        4: (np.float32, np.int32),
        8: (np.float64, np.int64),
    }

    nb_elem_slab_nxny = nx * ny

    try:
        with open(filename, "rb") as f:
            # Read header information
            header = np.fromfile(f, dtype=np.int32, count=6)

            # Determine the size of each element in bytes
            size_t = header[0]
            float_t, int_t = size_t_mapping.get(size_t, (None, None))

            # Allocate memory buffer for the 3D data
            data = np.zeros((nx, ny, nz), dtype=float_t)

            # Read the binary data slab by slab
            for k in range(nz):
                # Read the size of the current memory slab
                mem_size = np.fromfile(f, dtype=int_t, count=1)[0]

                # Calculate the number of elements in the slab
                nb_elem = int(mem_size / size_t)
                assert (
                    nb_elem == nb_elem_slab_nxny
                ), "Mismatch in the number of elements in the slab"

                # Read the actual data and reshape it to the desired dimensions
                data[k, :, :] = np.fromfile(f, dtype=float_t, count=nb_elem).reshape(
                    nx, ny
                )

                # Dummy read to move to the next slab
                mem_size = np.fromfile(f, dtype=int_t, count=1)[0]

            # Return the 3D data (ravel) read from the binary file
            return data.ravel()
    except Exception as e:
        print(f"Error opening or reading the file: {e}. Buffer set to None.")
        return None

class AstroFVSolverCL(FVSolverCl):
    def __init__(
        self,
        use_chemistry=False,
        init_buffer_map={},
        *args,
        **kwargs,
    ) -> None:
        super().__init__(*args, **kwargs)

        self.use_chemistry = use_chemistry
        self.init_buffer_map = init_buffer_map

    def _halloc(self) -> None:
        # Solver host buffers are allocated by FVSolverCl class
        super()._halloc()

        # Solution buffer size
        size = self.mesh.nb_cells

        if self.use_chemistry:
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

        if self.use_chemistry:
            # Set device buffer storing hydrogen density values at t_n
            self.nh_d = cl_array.empty(ocl_queue, size, dtype=self.dtype)

            # Set device buffer storing temperature values at t_n
            self.temp_d = cl_array.empty(ocl_queue, size, dtype=self.dtype)

            # Set device buffer storing neutral fraction values at t_n
            self.xi_d = cl_array.empty(ocl_queue, size, dtype=self.dtype)
            
        for key, val in self.init_buffer_map.items():
            device_buff_name = f"{key}_d"
            if hasattr(self, device_buff_name) and val is not None:
                setattr(self, device_buff_name, cl_array.to_device(ocl_queue,  val))

    @property
    def cl_build_opts(self):
        opts = super().cl_build_opts

        if self.use_chemistry:
            opts.append("-D USE_CHEMISTRY")

        return opts

    # TODO: Rewrite _init_sol
    def _init_sol(self, ocl_queue, ocl_prg) -> None:
        super()._init_sol(ocl_queue, ocl_prg)

        # Call CL Kernel initializing chemistry at t_{0}
        if self.use_chemistry:
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

        # Copy buffers from device to host
        cl.enqueue_copy(ocl_queue, self.wn_h, self.wn_d.data).wait()

        # Add chemistry values
        if self.use_chemistry:
            cell_data.update(
                {
                    "n_h": {self.mesh.cell_name: self.nh_h},
                    "tmp": {self.mesh.cell_name: self.temp_h},
                    "x_i": {self.mesh.cell_name: self.xi_h},
                }
            )

            # Copy buffers from device to host
            cl.enqueue_copy(ocl_queue, self.nh_h, self.nh_d.data).wait()
            cl.enqueue_copy(ocl_queue, self.temp_h, self.temp_d.data).wait()
            cl.enqueue_copy(ocl_queue, self.xi_h, self.xi_d.data).wait()

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

                if self.use_chemistry:
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
