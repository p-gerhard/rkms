from __future__ import annotations
import os
import numpy as np

from rkms.solver import FVTimeMode
from rkms.common import pprint_dict

from acoustic import *

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
    mesh_file = "unit_cube_nx65_ny65_nz65.msh"
    # mesh_file = "unit_square_nx512_ny512.msh"

    # Build PN Model
    m = M1_3D_LEBEDEV(
        cl_src_file="./cl/m1/main.cl",
        cl_include_dirs=["./cl"],
        cl_build_opts=[
            "-cl-fast-relaxed-math",
        ],
        cl_replace_map={},
    )

    # Build solver
    s = AcousticFVSolverCL(
        filename=mesh_file,
        model=m,
        time_mode=FVTimeMode.FORCE_ITERMAX_FROM_CFL,
        tmax=None,
        cfl=0.9,
        dt=None,
        iter_max=1000,
        use_muscl=False,
        export_frq=10,
        use_double=False,
    )

    # Run solver
    s.run()
