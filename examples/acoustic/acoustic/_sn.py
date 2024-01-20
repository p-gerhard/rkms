from rkms.model import SN

# SN models available:
# - Uniform 2D, N=2,4,8,16,32,64,128,256,512
# - Lebedev 3D, N=14,26,38,50,74,86,110,146,170,194,230,266,302,350,434,590,770


#
# 2D Uniform SN models
# N=2,4,8,16,32,64,128,256,512
#


class S4_2D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 2
        order = 4
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_UNIFORM"])),
        )


class S8_2D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 2
        order = 8
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_UNIFORM"])),
        )


class S16_2D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 2
        order = 16
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_UNIFORM"])),
        )


class S32_2D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 2
        order = 32
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_UNIFORM"])),
        )


class S64_2D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 2
        order = 64
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_UNIFORM"])),
        )


class S128_2D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 2
        order = 128
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_UNIFORM"])),
        )


class S256_2D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 2
        order = 256
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_UNIFORM"])),
        )


class S512_2D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 2
        order = 512
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_UNIFORM"])),
        )


#
# 3D Lebedev SN models
# N=6,14,26,38,50,74,86,110,146,170,194,230,266,302,350,434,590,770
#


class S6_3D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 3
        order = 6
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_LEBEDEV"])),
        )


class S14_3D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 3
        order = 14
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_LEBEDEV"])),
        )


class S26_3D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 3
        order = 26
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_LEBEDEV"])),
        )


class S38_3D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 3
        order = 38
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_LEBEDEV"])),
        )


class S50_3D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 3
        order = 50
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_LEBEDEV"])),
        )


class S74_3D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 3
        order = 74
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_LEBEDEV"])),
        )


class S86_3D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 3
        order = 86
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_LEBEDEV"])),
        )


class S110_3D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 3
        order = 110
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_LEBEDEV"])),
        )


class S146_3D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 3
        order = 146
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_LEBEDEV"])),
        )


class S170_3D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 3
        order = 170
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_LEBEDEV"])),
        )


class S194_3D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 3
        order = 194
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_LEBEDEV"])),
        )


class S230_3D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 3
        order = 230
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_LEBEDEV"])),
        )


class S266_3D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 3
        order = 266
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_LEBEDEV"])),
        )


class S302_3D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 3
        order = 302
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_LEBEDEV"])),
        )


class S350_3D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 3
        order = 350
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_LEBEDEV"])),
        )


class S434_3D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 3
        order = 434
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_LEBEDEV"])),
        )


class S590_3D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 3
        order = 590
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_LEBEDEV"])),
        )


class S770_3D(SN):
    def __init__(
        self,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        dim = 3
        order = 770
        super().__init__(
            dim=dim,
            order=order,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=list(set(cl_build_opts + ["-D USE_QUAD_LEBEDEV"])),
        )
