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
