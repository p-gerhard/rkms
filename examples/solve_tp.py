from __future__ import annotations

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
class Transport(Model):
    def __init__(self, dim: int):
        super().__init__(
            order=0,
            dim=dim,
            cl_src_file="./cl/transport/tp.cl",
            cl_build_opts=[""],
            cl_include_dirs=["./cl/transport"],
        )

        self.m = 1


################################################################################
# AVAILABLE TRANSPORT MODEL - DIM 2
################################################################################


# Declare generic Transport model using inheritance
class TransportD2(Transport):
    def __init__(
        self,
    ):
        super().__init__(dim=2)


################################################################################
# AVAILABLE TRANSPORT MODELS - DIM 3
################################################################################


# Declare generic Transport model using inheritance
class TransportD3(Transport):
    def __init__(
        self,
    ):
        super().__init__(dim=3)


if __name__ == "__main__":
    cl_model_inject_val = {
        "__SRC_X__": 0.5,
        "__SRC_Y__": 0.5,
        "__SRC_Z__": 0.5,
        "__SRC_R__": 0.0125,
        "__SRC_TOFF__": 0.5,
        "__VX__": 1.0,
        "__VY__": 0.0,
        "__VZ__": 0.0,
    }

    solve_d2 = False

    if solve_d2:
        m = TransportD2()
        m.cl_inject_vals = cl_model_inject_val
        filename = "./meshes/unit_square_nx1024_ny1024.msh"
    else:
        m = TransportD3()
        m.cl_inject_vals = cl_model_inject_val
        filename = "./meshes/unit_cube_nx100_ny100_nz100.msh"

    simu = Simulation(
        model=m,
        tmax=0.7,
        cfl=0.9,
        filename=filename,
        use_muscl=True,
    )

    simu.print_infos()
    simu.solve()
