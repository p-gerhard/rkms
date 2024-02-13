from __future__ import annotations

import os

import numpy as np
from acoustic import *

from rkms.common import pprint_dict
from rkms.mesh import MeshStructured
from rkms.solver import FVTimeMode

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
    # Build Mesh
    dim = 2
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
        use_periodic_bd=False,
    )
    # Build PN Model
    m = S64_2D(
        cl_src_file="./cl/sn/main.cl",
        cl_include_dirs=["./cl"],
        cl_build_opts=[
            "-cl-fast-relaxed-math",
        ],
        cl_replace_map={},
    )

    # Build solver
    s = AcousticFVSolverCL(
        mesh=mesh,
        model=m,
        time_mode=FVTimeMode.FORCE_ITERMAX_FROM_CFL,
        tmax=None,
        cfl=0.9,
        dt=None,
        iter_max=1000,
        use_muscl=False,
        export_idx=[],
        export_frq=40,
        use_double=False,
    )

    # Run solver
    s.run()
