from __future__ import annotations

import os

import numpy as np
from astro import AstroFVSolverCL, read_astro_file_bin

from rkms.common import pprint_dict
from rkms.mesh import MeshStructured
from rkms.model import M1, PN
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


def get_hmin(dim, dx, dy, dz):
    if dim == 2:
        cell_v = dx * dy
        cell_s = 2.0 * (dx + dy)

    else:
        cell_v = dx * dy * dz
        cell_s = 2.0 * (dx * dy + dy * dz + dz * dx)

    return cell_v / cell_s


def get_dim_coeff(
    dim, cfl, dx_adim, dy_adim, dz_adim, c_adim, x_phy_value, c_phy_value
):
    dx_adim = np.float64(dx_adim)
    dy_adim = np.float64(dy_adim)
    dz_adim = np.float64(dz_adim)

    x_phy_value = np.float64(x_phy_value)
    c_phy_value = np.float64(c_phy_value)

    dt_adim = (
        np.float64(cfl)
        * np.float64(get_hmin(dim, dx_adim, dy_adim, dz_adim))
        / np.float64(c_adim)
    )

    dx_dim = dx_adim * x_phy_value
    dy_dim = dy_adim * x_phy_value
    dz_dim = dz_adim * x_phy_value
    dt_dim = dt_adim * x_phy_value / c_phy_value

    return dx_dim, dy_dim, dz_dim, dt_dim


if __name__ == "__main__":
    # Model
    use_m1 = False
    use_pn = True
    pn_order = 3

    # CFL
    cfl = 0.8

    # Build Mesh
    dim = 3
    mesh_nx = 128
    mesh_ny = 128
    mesh_nz = 128 if dim == 3 else 0

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

    # Dim values
    x_phy_value = 6.6 * 3.086e19 * 2
    c_phy_value = 3.0e8 / 1000.0
    w_phy_value = 5.0e48

    dx_dim, dy_dim, dz_dim, dt_dim = get_dim_coeff(
        dim,
        cfl,
        dx_adim=1.0 / mesh_nx,
        dy_adim=1.0 / mesh_ny,
        dz_adim=1.0 / mesh_ny,
        c_adim=1.0,
        x_phy_value=x_phy_value,
        c_phy_value=c_phy_value,
    )

    iter = int(np.floor(w_phy_value / dt_dim))
    w0_rescale = dt_dim * w_phy_value / (dx_dim * dy_dim * dz_dim)

    pprint_dict(
        {
            "Speed of light 'c'": c_phy_value,
            "Length 'x": x_phy_value,
            "Photon flux, 'w'": w_phy_value,
        },
        header_msg="PHYSICAL CONSTANTS",
    )

    pprint_dict(
        {
            "Photon density 'w0'": w0_rescale,
        },
        header_msg="RESCALING VALUES",
    )

    # Build M1 Model
    if use_m1:
        m = M1(
            dim,
            cl_src_file="./cl/m1/main_stromgren_sphere.cl",
            cl_include_dirs=["./cl/m1"],
            cl_build_opts=["-cl-fast-relaxed-math"],
            # Values injected in "./cl/m1/main_stromgren_sphere.cl"
            cl_replace_map={
                "__PHY_C_DIM__": c_phy_value,
                "__PHY_DT_DIM__": dt_dim,
                "__PHY_W0_DIM__": w0_rescale,
            },
        )

    if use_pn:
        m = PN(
            pn_order,
            dim,
            cl_src_file="./cl/pn/main_stromgren_sphere.cl",
            cl_include_dirs=["./cl/pn"],
            cl_build_opts=[
                f"-D USE_SPHERICAL_HARMONICS_P{pn_order}",
                "-cl-fast-relaxed-math",
            ],
            # Values injected in "./cl/pn/main_stromgren_sphere.cl"
            cl_replace_map={
                "__PHY_C_DIM__": c_phy_value,
                "__PHY_DT_DIM__": dt_dim,
                "__PHY_W0_DIM__": w0_rescale,
            },
        )

    # Load 'nh' buffer from file
    # WARNING:
    #  - name has to be the same than in _dalloc without suffix _d. eg. for a
    #    buffer named 'nh' the function search for self.nh_d
    #  - The nh filling in kernel chem_init_sol (chemistry.cl) must be commented
    #    out since nh is now filled with file values.

    init_buffer_map = {
        "nh": read_astro_file_bin("density.bin", mesh_nx, mesh_ny, mesh_nz),
    }

    s = AstroFVSolverCL(
        mesh=mesh,
        model=m,
        time_mode=FVTimeMode.FORCE_ITERMAX_FROM_CFL,
        tmax=None,
        cfl=cfl,
        dt=None,
        iter_max=5000,
        use_muscl=False,
        export_idx=[0, 1, 2],
        export_frq=100,
        use_double=False,
        use_chemistry=True,
        init_buffer_map=init_buffer_map,
    )

    # Run solver
    s.run()
