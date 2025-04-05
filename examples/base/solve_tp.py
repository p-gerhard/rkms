import os

from rkms.mesh import MeshStructured
from rkms.model import TP
from rkms.solver import *

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

if __name__ == "__main__":
    # Physical dimension of PN approximation
    dim = 3

    # Build Mesh
    mesh_nx = 65
    mesh_ny = 65
    mesh_nz = 65 if dim == 3 else 0

    mesh = MeshStructured(
        filename=None,
        nx=mesh_nx,
        ny=mesh_ny,
        nz=mesh_nz,
        xmin=0.0,
        xmax=1.0,
        ymin=0.0,
        ymax=1.0,
        zmin=0.0,
        zmax=1.0,
        use_periodic_bd=True,
    )

    nb_neighbors = 6 if dim == 3 else 3

    dx_offset = 0.5 * mesh.dx
    dy_offset = 0.5 * mesh.dy
    dz_offset = 0.5 * mesh.dz if dim == 3 else None

    nbs = mesh.elem2elem.reshape(-1, nb_neighbors)

    # Cells on -X face
    # nbs[mesh.cells_center[:, 0] == mesh.xmin + dx_offset, 1] = -1

    # Cells on +X face
    # nbs[mesh.cells_center[:, 0] == mesh.xmax - dx_offset, 0] = -1

    # Cells on -Y face
    nbs[mesh.cells_center[:, 1] == mesh.ymin + dy_offset, 3] = -1

    # Cells on +Y face
    nbs[mesh.cells_center[:, 1] == mesh.ymax - dy_offset, 2] = -1

    if dim == 3:
        # Cells on -Z face
        nbs[mesh.cells_center[:, 2] == mesh.zmin + dz_offset, 5] = -1

        # Cells on +Z face
        nbs[mesh.cells_center[:, 2] == mesh.zmax - dz_offset, 4] = -1

    mesh.elem2elem = nbs.flatten()

    # Build Transport Model
    m = TP(
        dim,
        cl_src_file="./cl/tp/main.cl",
        cl_include_dirs=["./cl/tp"],
        cl_build_opts=["-cl-fast-relaxed-math"],
        cl_replace_map={
            "__SRC_X__": 0.5,
            "__SRC_Y__": 0.5,
            "__SRC_Z__": 0.5,
            "__VX__": -1.0,
            "__VY__": 0.0,
            "__VZ__": 0.0,
        },
    )

    # Build solver
    s = FVSolverCl(
        mesh=mesh,
        model=m,
        time_mode=FVTimeMode.FORCE_TMAX_FROM_CFL,
        tmax=1.5,
        cfl=0.9,
        dt=None,
        iter_max=100,
        use_muscl=True,
        export_frq=40,
        use_double=True,
    )

    # Run solver
    s.run()
