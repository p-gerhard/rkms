from __future__ import annotations

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
    model_src_file: str,
    model_inject_vals: dict = {},
    model_build_opts: list[str] = [""],
    model_include_dirs: list[str] = [""],
    solver_inject_vals: dict = {},
    solver_include_dirs: list[str] = [""],
    solver_build_opts: list[str] = [""],
):
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
