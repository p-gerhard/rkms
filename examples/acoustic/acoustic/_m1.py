from rkms.model import Model

# M1 models available:
# - M1 using lebedev (N=302) quadrature to compute the kinetic fluxes.
# - M1 using trigauss quadrature to compute the kinetic fluxes.


class M1_3D_LEBEDEV(Model):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 3
        super().__init__(
            order=1,
            dim=dim,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_LEBEDEV"])),
        )
        self.m = 4


class M1_3D_TRIGAUSS(Model):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 3
        super().__init__(
            order=1,
            dim=dim,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_TRIGAUSS"])),
        )
        self.m = 4
