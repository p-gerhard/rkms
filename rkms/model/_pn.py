from __future__ import annotations

from ._model import Model


# Generic PN model using inheritance
class PN(Model):
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
            order,
            dim,
            cl_src_file,
            cl_replace_map,
            cl_include_dirs,
            cl_build_opts,
        )

        if dim == 2:
            self.m = int((order * order / 2.0) + (3.0 * order / 2.0) + 1.0)
        else:
            self.m = int((order + 1.0) * (order + 1.0))
