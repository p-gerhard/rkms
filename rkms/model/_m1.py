from __future__ import annotations

from ._model import Model


# Declare generic M1 (Moment) model using inheritance
class M1(Model):
    def __init__(
        self,
        dim: int,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        super().__init__(
            order=1,
            dim=dim,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=cl_build_opts,
        )

        self.m = 4
