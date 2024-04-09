from __future__ import annotations

import numpy as np
import inspect


def is_num_type(val):
    return np.issubdtype(type(val), np.number)


def pprint_dict(dict, header_msg="", indent=1):
    print("#{}:".format(header_msg))
    for k, v in sorted(dict.items()):
        if is_num_type(v):
            if np.issubdtype(type(v), np.integer):
                print(indent * " " + "- {:<40} {:<12d}".format(k, v))
            if np.issubdtype(type(v), np.inexact):
                print(indent * " " + "- {:<40} {:<.6e}".format(k, v))
        else:
            print(indent * " " + "- {:<40} {}".format(k, v))


def cast_data(instance, dtype=np.float32):
    for name, val in inspect.getmembers(instance):
        # Cast scalar float members
        if isinstance(val, (float, np.float32, np.float64)):
            setattr(instance, name, dtype(val))

        # Cast array float members
        if isinstance(val, np.ndarray):
            if val.dtype in (np.float32, np.float64):
                setattr(instance, name, dtype(val))


# def serialize(obj, filtered_names=None):
#     if filtered_names is None:
#         filtered_names = []

#     data = {}
#     for name, value in vars(obj).items():
#         if name not in filtered_names and not callable(value):
#             if isinstance(value, (int, float, str, list, dict, bool, np.generic)):
#                 data[name] = value
#     return data


def cast_numpy_to_python(data):
    if isinstance(data, dict):
        return {k: cast_numpy_to_python(v) for k, v in data.items()}
    elif isinstance(data, (list, tuple)):
        return [cast_numpy_to_python(item) for item in data]
    elif isinstance(data, (np.integer, np.floating)):
        return data.item()
    elif isinstance(data, (int, float, str, bool)):
        return data
    else:
        return "WARNING_NOT_DISPLAYED"


def serialize(obj, filtered_names=None):

    if filtered_names is None:
        filtered_names = []

    data = {}
    for name, value in inspect.getmembers(obj):
        if (
            not name.startswith("_")
            and name not in filtered_names
            and not inspect.ismethod(value)
        ):
            if isinstance(value, np.integer):
                data[name] = int(value)
            elif isinstance(value, np.floating):
                data[name] = float(value)
            elif isinstance(value, (int, float, str, list, bool)):
                data[name] = value
            elif isinstance(value, dict):
                data[name] = cast_numpy_to_python(value)
    return data


# def __dump_parameters(self, print=True, dump=True):
#     dict = json.loads(
#         json.dumps(self, default=lambda o: getattr(o, "__dict__", str(o)))
#     )

#     if print:
#         logger.info("{:<30}:".format("Simulation parameters"))
#         logger.info(pformat(dict, indent=2, width=120))

#     if dump:
#         with open(JSON_FILE_NAME, "w") as f:
#             json.dump(dict, f)
