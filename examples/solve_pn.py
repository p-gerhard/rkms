import os
from rkms.simulation import *

# Set some env. variables to controle pyopencl and nvidia platefrom behaviours
os.environ["PYOPENCL_NO_CACHE"] = "1"
os.environ["PYOPENCL_COMPILER_OUTPUT"] = "1"
os.environ["CUDA_CACHE_DISABLE"] = "1"

################################################################################
# GENERIC PN MODEL
################################################################################


# Declare generic PN model using inheritance
class PN(Model):
    def __init__(self, order: int, dim: int):
        super().__init__(
            order,
            dim,
            cl_build_opts=[
                "-D IS_SPHERICAL_HARMONICS_MODELS",
                "-D USE_SPHERICAL_HARMONICS_P{order}".format(order=order),
            ],
            cl_src_file="./cl/pn/pn.cl",
            cl_include_dirs=["./cl/pn"],
        )

        if dim == 2:
            self.m = int((order * order / 2.0) + (3.0 * order / 2.0) + 1.0)
        else:
            self.m = int((order + 1.0) * (order + 1.0))


################################################################################
# AVAILABLE PN MODELS - DIM 2
################################################################################


# Declare generic PND2 model using inheritance
class PND2(PN):
    def __init__(self, order: int):
        super().__init__(order, dim=2)


# Declare model PN Dim=2, Order=1
class P1D2(PND2):
    def __init__(self) -> None:
        super().__init__(order=1)


# Declare model PN Dim=2, Order=3
class P3D2(PND2):
    def __init__(self) -> None:
        super().__init__(order=3)


# Declare model PN Dim=2, Order=5
class P5D2(PND2):
    def __init__(self) -> None:
        super().__init__(order=5)


# Declare model PN Dim=2, Order=7
class P7D2(PND2):
    def __init__(self) -> None:
        super().__init__(order=7)


# Declare model PN Dim=2, Order=9
class P9D2(PND2):
    def __init__(self) -> None:
        super().__init__(order=9)


# Declare model PN Dim=2, Order=11
class P11D2(PND2):
    def __init__(self) -> None:
        super().__init__(order=11)


################################################################################
# AVAILABLE PN MODELS - DIM 3
################################################################################


# Declare generic PND2 model using inheritance
class PND3(PN):
    def __init__(self, order: int):
        super().__init__(order, dim=3)


# Declare model PN Dim=3, Order=1
class P1D3(PND3):
    def __init__(self) -> None:
        super().__init__(order=1)


# Declare model PN Dim=3, Order=3
class P3D3(PND3):
    def __init__(self) -> None:
        super().__init__(order=3)


# Declare model PN Dim=3, Order=5
class P5D3(PND3):
    def __init__(self) -> None:
        super().__init__(order=5)


# Declare model PN Dim=3, Order=7
class P7D3(PND3):
    def __init__(self) -> None:
        super().__init__(order=7)


# Declare model PN Dim=3, Order=9
class P9D3(PND3):
    def __init__(self) -> None:
        super().__init__(order=9)


# Declare model PN Dim=3, Order=11
class P11D3(PND3):
    def __init__(self) -> None:
        super().__init__(order=11)


if __name__ == "__main__":
    cl_model_inject_val = {
        "__SRC_X__": 0.5,
        "__SRC_Y__": 0.5,
        "__SRC_Z__": 0.5,
        "__SRC_R__": 0.0125,
    }

    solve_d2 = False

    if solve_d2:
        m = P5D2()
        m.cl_inject_vals = cl_model_inject_val
        # filename = "./meshes/q4_unit_square_nx2_ny2.msh"
        filename = "./meshes/q4_unit_square_nx1024_ny1024.msh"
    else:
        m = P5D3()
        m.cl_inject_vals = cl_model_inject_val
        filename = "./meshes/h8_unit_cube_nx100_ny100_nz100.msh"

    simu = Simulation(
        model=m,
        tmax=1,
        cfl=0.9,
        filename=filename,
        use_muscl=False,
    )

    simu.print_infos()
    simu.solve()
