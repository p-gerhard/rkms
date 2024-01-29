from __future__ import annotations

from __future__ import annotations
import os
import numpy as np

from rkms.model import PN
from rkms.solver import FVTimeMode, FVSolverCl
from rkms.common import pprint_dict
from rkms.mesh import MeshStructured


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
    pn_order = 5
    mesh_file = "unit_cube_nx65_ny65_nz65.msh"

    # Build PN Model
    model = PN(
        pn_order,
        dim,
        cl_src_file="./cl/pn/main_beam.cl",
        cl_include_dirs=["./cl//pn"],
        cl_build_opts=[
            f"-D USE_SPHERICAL_HARMONICS_P{pn_order}",
            "-cl-fast-relaxed-math",
        ],
        cl_replace_map={},
    )

    mesh = MeshStructured(
        filename=None,
        nx=3,
        ny=3,
        nz=3,
        xmin=0.0,
        xmax=1.0,
        ymin=0.0,
        ymax=1.0,
        zmin=0.0,
        zmax=1.0,
        use_periodic_bd=False,
    )

    # Build solver
    s = FVSolverCl(
        mesh=mesh,
        model=model,
        time_mode=FVTimeMode.FORCE_ITERMAX_FROM_CFL,
        tmax=None,
        cfl=0.9,
        dt=None,
        iter_max=400,
        use_muscl=True,
        export_idx=[0, 1, 2],
        export_frq=40,
        use_double=True,
    )


exit()
