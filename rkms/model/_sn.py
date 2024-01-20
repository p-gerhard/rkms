from __future__ import annotations

from ._model import Model


# Generic SN model using inheritance
class SN(Model):
    def __init__(
        self,
        order: int,
        dim: int,
        cl_src_file: str,
        cl_replace_map: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ):
        super().__init__(
            order=order,
            dim=dim,
            cl_src_file=cl_src_file,
            cl_replace_map=cl_replace_map,
            cl_include_dirs=cl_include_dirs,
            cl_build_opts=cl_build_opts,
        )

        self.m = self.order
