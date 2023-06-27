import logging
import os

from rkms.common import *

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

logging.basicConfig(
    format="[%(asctime)s] - %(levelname)s - %(message)s",
    datefmt="%m/%d/%Y %I:%M:%S %p",
)


class Model:
    def __init__(
        self,
        order: int,
        dim: int,
        cl_src_file: str,
        cl_inject_vals: dict = {},
        cl_include_dirs: list[str] = [""],
        cl_build_opts: list[str] = [""],
    ) -> None:
        self.order = order
        self.dim = dim
        self.cl_build_opts = cl_build_opts
        self.cl_src_file = cl_src_file
        self.cl_inject_vals = cl_inject_vals
        self.cl_include_dirs = cl_include_dirs
        self.m = 0
        self.nb_macro_to_reconstruct = 0

    @property
    def dim(self) -> int:
        return self.__dim

    @dim.setter
    def dim(self, value: int) -> None:
        assert isinstance(value, int) and (value == 2 or value == 3)
        self.__dim = value

    @property
    def order(self) -> int:
        return self.__order

    @order.setter
    def order(self, value: int) -> None:
        assert isinstance(value, int) and value >= 0
        self.__order = value

    @property
    def cl_src_file(self) -> str:
        return self.__cl_src_file

    @cl_src_file.setter
    def cl_src_file(self, value: str) -> None:
        assert isinstance(value, str)

        # Ensure that cl file exists
        try:
            os.path.exists(value)
        except Exception:
            print(Exception)
            exit()
        self.__cl_src_file = value

    @property
    def cl_inject_vals(self) -> dict:
        return self.__cl_inject_vals

    @cl_inject_vals.setter
    def cl_inject_vals(self, value: dict) -> None:
        assert isinstance(value, dict)

        res = {}
        for k, v in value.items():
            if is_num_type(v) or isinstance(v, str):
                res[k] = v
            else:
                logger.error(
                    "pair {}:{} cannot be inject, value type must be numeric or"
                    "string".format(k, v)
                )
        self.__cl_inject_vals = res

    @property
    def cl_build_opts(self) -> list[str]:
        return self.__cl_build_opts

    @cl_build_opts.setter
    def cl_build_opts(self, value: list[str]) -> None:
        assert isinstance(value, list)
        self.__cl_build_opts = value

    @property
    def cl_include_dirs(self) -> list[str]:
        return self.__cl_include_dirs

    @cl_include_dirs.setter
    def cl_include_dirs(self, value: list[str]) -> None:
        assert isinstance(value, list)
        self.__cl_include_dirs = value

    @property
    def m(self) -> int:
        return self.__m

    @m.setter
    def m(self, value: int) -> None:
        assert isinstance(value, int) and value >= 0
        self.__m = int(value)

    @property
    def nb_macro_to_reconstruct(self) -> int:
        return self.__nb_macro_to_reconstruct

    @nb_macro_to_reconstruct.setter
    def nb_macro_to_reconstruct(self, value: int) -> None:
        assert isinstance(value, int) and value >= 0
        self.__nb_macro_to_reconstruct = value

    def get_params_to_print(self):
        params = {
            "Name": self.__class__.__name__,
            "Order": self.order,
            "Dim": self.dim,
            "CL file": self.cl_src_file,
            "CL inject values": self.cl_inject_vals,
            "CL include folder": self.cl_include_dirs,
            "Nb. of variable": self.m,
            "Nb. macro vars to reconstruct": self.nb_macro_to_reconstruct,
        }

        return params

    def print_infos(self):
        params = self.get_params_to_print()
        pprint_dict(params, header_msg="MODEL INFOS")
