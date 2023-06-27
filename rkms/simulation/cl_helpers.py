import os
import logging
import shutil
import time
from datetime import datetime

import numpy as np
import pyopencl as cl

from rkms.common import *


logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

logging.basicConfig(
    format="[%(asctime)s] - %(levelname)s - %(message)s",
    datefmt="%m/%d/%Y %I:%M:%S %p",
)


def copy_full_content(src: str, dst: str):
    for src_dir, dirs, files in os.walk(src):
        dst_dir = os.path.abspath(os.path.join(dst, src_dir))

        if not os.path.exists(dst_dir):
            os.makedirs(dst_dir)

        for file in files:
            src_file = os.path.abspath(os.path.join(src_dir, file))
            dst_file = os.path.abspath(os.path.join(dst_dir, file))

            if os.path.exists(dst_file):
                os.remove(dst_file)

            shutil.copy(src_file, dst_file)


def filter_dict(dict: dict) -> dict:
    res = {}
    for k, v in dict.items():
        if is_num_type(v) or isinstance(v, str):
            res[k] = v

    return res


def try_merge_dict(dict_a: dict, dict_b: dict) -> tuple[dict | str]:
    res = dict_a.copy()
    failed = False
    for k, v in dict_b.items():
        val = dict_a.get(k)
        if val is not None:
            failed = True
            return (val, k, failed)
        else:
            res[k] = v

    return (res, "", failed)


def cl_build_program(
    build_dir: str,
    model_src_file: str,
    model_inject_vals: dict = {},
    model_build_opts: list[str] = [""],
    model_include_dirs: list[str] = [""],
    solver_inject_vals: dict = {},
    solver_include_dirs: list[str] = [""],
    solver_build_opts: list[str] = [""],
):
    tag = datetime.now().strftime("%d%m%Y_%H%M%S")
    dir = os.path.join(build_dir, "tmp_{}".format(tag))

    # Create tmp build dir
    # if not os.path.exists(dir):
    #     os.makedirs(dir)

    # Merge solver and model values to inject in source
    inject_vals, key, failed = try_merge_dict(
        solver_inject_vals,
        model_inject_vals,
    )

    if failed:
        logger.error(
            "using 'key '{}' in 'Model.__cl_inject_vals' is forbidden since "
            "its already used in Solver.__cl_inject_vals'. Exiting...".format(key)
        )
        exit()

    # Read content of model main source file
    with open(model_src_file, "r") as f:
        src_buf = f.read()

    # Injection process
    for k, v in inject_vals.items():
        if isinstance(v, np.float32):
            src_buf = src_buf.replace("{}".format(k), "({:f}f)".format(v))
        else:
            src_buf = src_buf.replace("{}".format(k), "({})".format(v))

    # dest = os.path.join(cl_build_dir, os.path.basename(cl_src_main_file))

    # # Write final version of cl src main file
    # with open(dest, "w") as f:
    #     f.write(cl_src)

    # Set build options
    build_opts = solver_build_opts + model_build_opts

    # Set include dirs build options
    include_dirs = solver_include_dirs + model_include_dirs
    for dir in include_dirs:
        build_opts.append("-I {}".format(os.path.abspath(dir)))

    ocl_ctx = cl.create_some_context(interactive=True)
    ocl_prg = cl.Program(ocl_ctx, src_buf)

    logger.info("Building CL target...")
    t_start = time.time()
    ocl_prg.build(options=build_opts)

    logger.info(
        "CL target built in {:>6.8f} sec".format(time.time() - t_start),
    )

    return ocl_ctx, ocl_prg
    # # Copy kernel source files to PyOpenCL's default kernel folder
    # if copy_kernel_to_ocl_path:
    #     self.ocl_include_default_path = _find_pyopencl_include_path()
    #     self.dest_kernel_dir_list = build_subfolder_list(
    #         kernel_base, self.ocl_include_default_path
    #     )
    #     self.dest_kernel_dir_list = list(set(self.dest_kernel_dir_list))

    #     dir_util.copy_tree(kernel_base, self.ocl_include_default_path)

    # else:
    #     self.ocl_options.extend(["-I", kernel_base])

    # # Remove copied files
    # if copy_kernel_to_ocl_path:
    #     recursive_remove(self.dest_kernel_dir_list)


def cl_preprocess_main_src(cl_file: str, injection_dict: dict = {}) -> str:
    # Load CL file
    cl_src = ""
    with open(cl_file, "r") as f:
        cl_src = f.read()

    # Get OpenCL numeric only parameters to inject in OpenCL source file
    ocl_params = cl_process_injection_dict(injection_dict)

    # For each (key-value) pair in ocl_params, the injection process inside the
    # cl_file is achieved through the following steps:
    #
    # - Step 1: Transform the key string into "_key_".
    #
    # - Step 2: In cl_file, locate the string '_key_' and replace it with its
    #           associated value.
    #
    # For instance, let's consider `ocl_params = {tmax : "1.20"}` and if in the
    # OpenCL file, the line `#DEFINE TMAX _tmax_`, is present then it the
    # injection process will produce in the cl_file :
    #
    # #define TMAX (1.20)

    # Injection process
    for k, v in ocl_params.items():
        cl_src = cl_src.replace("_{}_".format(k), "({})".format(v))

    return cl_src
