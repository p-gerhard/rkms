import os

from rkms.model import M1
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
    # Physical dimension
    dim = 3

    # Load mesh file
    if dim == 2:
        filename = "./meshes/unit_square_nx64_ny64.msh"
    else:
        filename = "./meshes/unit_cube_nx100_ny100_nz100.msh"
        # filename = "./meshes/unit_cube_nx8_ny8_nz8.msh"

    # Build Transport Model
    m = M1(
        dim,
        cl_src_file="./cl/astro/m1/main.cl",
        cl_include_dirs=["./cl/astro/m1"],
        cl_build_opts=["-cl-fast-relaxed-math"],
        cl_replace_map={
            "__SRC_X__": 0.5,
            "__SRC_Y__": 0.5,
            "__SRC_Z__": 0.5,
        },
    )

    # Build solver
    s = FVSolverCl(
        filename=filename,
        model=m,
        time_mode=FVTimeMode.FORCE_TMAX_FROM_CFL,
        tmax=0.5,
        cfl=0.9,
        dt=None,
        iter_max=1,
        use_muscl=False,
        export_frq=40,
        use_double=False,
    )

    # Run solver
    s.run()
