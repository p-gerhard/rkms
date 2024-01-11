import os

from rkms.model import PN
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
    dim = 2

    # Order of PN approximation
    order = 11

    # Load mesh file
    if dim == 2:
        filename = "unit_square_nx64_ny64.msh"
    else:
        filename = "unit_cube_nx100_ny100_nz100.msh"

    # Build PN Model
    m = PN(
        order,
        dim,
        cl_src_file="./cl/pn/main.cl",
        cl_include_dirs=["./cl/pn"],
        cl_build_opts=[
            f"-D USE_SPHERICAL_HARMONICS_P{order}",
            "-cl-fast-relaxed-math",
        ],
        cl_replace_map={
            "__SRC_X__": 0.5,
            "__SRC_Y__": 0.5,
            "__SRC_Z__": 0.5,
            "__SRC_R__": 0.0125,
        },
    )

    # Build solver
    s = FVSolverCl(
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
        use_double=False,
    )

    # Run solver
    s.run()
