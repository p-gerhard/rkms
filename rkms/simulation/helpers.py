from __future__ import annotations
import glob
import logging

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

import json
import os
import shutil
import numbers
import time


import numpy as np


def try_remove(path):
    try:
        if os.path.isfile(path) or os.path.islink(path):
            os.unlink(path)
    except Exception as e:
        print("Failed to delete {}. {}".format(path, e))


def dump_dic_to_json(dic, filename):
    # Cast dict data to serializable type
    dumpable_dict = dic.copy()
    for key, value in dumpable_dict.items():
        if isinstance(value, np.floating):
            dumpable_dict[key] = float(dumpable_dict[key])

        if isinstance(value, np.integer):
            dumpable_dict[key] = int(dumpable_dict[key])

    with open(filename, "w") as file:
        json.dump(dumpable_dict, file, indent=4, sort_keys=True)


def pprint_simu(dict, indent=2):
    for k, v in sorted(dict.items()):
        if is_num_type(v):
            if np.issubdtype(type(v), np.integer):
                print(indent * "\t" + "- {:<20} {:<12d}".format(k, v))
            if np.issubdtype(type(v), np.inexact):
                print(indent * "\t" + "- {:<20} {:<12.6f}".format(k, v))

        else:
            print(indent * "\t" + "- {:<20} {}".format(k, v))


def mkdir_clean(dir_path):
    try:
        os.mkdir(dir_path)
    except:
        pass

    for filename in os.listdir(dir_path):
        file_path = os.path.join(dir_path, filename)
        try:
            if os.path.isfile(file_path) or os.path.islink(file_path):
                os.unlink(file_path)
        except Exception as e:
            print("Failed to delete {}. Reason: {}".format(file_path, e))


def check_inclusion_and_type(input_param, ref_param, msg_header=""):
    is_missing = False

    for key, value in ref_param.items():
        # Check inclusion
        if key not in input_param.keys():
            if msg_header != "":
                error_msg = '{} "{} is missing'.format(msg_header, key)
            else:
                error_msg = 'Parameter "{} is missing'.format(msg_header, key)

            logger.error(error_msg)
            is_missing = True

        # Check type and try to cast if possible
        else:
            if not isinstance(input_param[key], ref_param[key]):
                try:
                    input_param[key] = ref_param[key](input_param[key])
                except:
                    if msg_header != "":
                        logger.error(
                            '{msg} "{k}" of type {t_in} cannot be cast into {t_ref} !'.format(
                                msg=msg_header,
                                k=key,
                                t_in=type(input_param[key]),
                                t_ref=ref_param[key],
                            )
                        )
                    else:
                        logger.error(
                            'Parameter "{k}" of type {t_in} into {t_ref}'.format(
                                k=key, t_in=type(input_param[key]), t_ref=ref_param[key]
                            )
                        )
                    is_missing = True

    if is_missing:
        logger.error("Required values are : {}".format(list(ref_param)))

    else:
        if msg_header != "":
            info_msg = "{:<30}: OK".format("{} ".format(msg_header))
        else:
            info_msg = "{:<30}: OK".format("Parameters")

        logger.info(info_msg)

    return not is_missing


def compute_dt(
    dim: np.int32, cfl: np.float32, dx: np.float32, dy: np.float32, dz: np.float32
) -> np.float32:
    """Compute the time step dt according to the CFL condition of a finite
       volume scheme using an Euler time integrator

    Parameters:
    - dim (int): Physical dimension of the probleme (e.g 2 or 3).
    - cfl (np.float32): The CFL condition usally < 1
    - dx (np.float32): The space step on x
    - dy (np.float32): The space step on y
    - dz (np.float32): The space step on z

    Returns:
    np.float32: The time step dt

    """
    dt = 0

    if dim == 2:
        dt = cfl * (dx * dy) / (2.0 * dx + 2.0 * dy)

    if dim == 3:
        dt = cfl * (dx * dy * dz) / (2.0 * (dx * dy + dy * dz + dz * dx))

    return dt


def check_inclusion(input_param, ref_param, msg_header=""):
    is_missing = False

    # To make it iterable
    if isinstance(input_param, (str, int, float, complex, bool)):
        input_param = [input_param]

    for p in input_param:
        if p not in ref_param:
            if msg_header != "":
                error_msg = '{} "{} is missing'.format(msg_header, p)
            else:
                error_msg = 'Parameter "{} is missing'.format(msg_header, p)

            logger.error(error_msg)
            is_missing = True

    if is_missing:
        logger.error("Required values are : {}".format(list(ref_param)))
    else:
        if msg_header != "":
            info_msg = "{:<30}: OK".format("{} ".format(msg_header))
        else:
            info_msg = "{:<30}: OK".format("Parameters")

        logger.info(info_msg)

    return not is_missing


def build_subfolder_list(base_folder, dest_folder=None):
    subfolder_list = []
    for r, d, f in os.walk(base_folder):
        for file in f:
            subfolder = os.path.relpath(r, base_folder)

            if dest_folder is not None:
                subfolder = os.path.join(dest_folder, subfolder)

            subfolder_list.append(subfolder)

    return list(set(subfolder_list))


def recursive_remove(dir_list):
    for dir in dir_list:
        shutil.rmtree(dir, ignore_errors=False, onerror=None)


def get_ite_title(ite, t, elapsed):
    return "ite = {}, t = {:f}, elapsed (s) = {:f}".format(ite, t, elapsed)


def is_num_type(val):
    return np.issubdtype(type(val), np.number)
