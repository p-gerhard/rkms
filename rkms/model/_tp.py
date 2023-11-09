from __future__ import annotations

from ._model import Model


# Declare generic TP (transport) model using inheritance
class TP(Model):
    def __init__(
        self,
        dim: int,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        super().__init__(
            order=0,
            dim=dim,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=cl_build_opts,
        )

        self.m = 1
