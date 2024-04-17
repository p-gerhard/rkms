from __future__ import annotations

import inspect
import json
import logging
import os
import time
from abc import ABC, abstractmethod

import numpy as np
import pyopencl as cl

XDMF_FILE_NAME = "data.xmf"
JSON_FILE_NAME = "config.json"

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

logging.basicConfig(
    format="[%(asctime)s] - %(levelname)s - %(message)s",
    datefmt="%m/%d/%Y %I:%M:%S %p",
)


def get_progressbar(iter, iter_max, t, t_max):
    print(
        f"Solver iteration = {iter}/{iter_max}, time = {t:.3f}/{t_max:.3f}",
        end="\r",
    )


def get_mem_size_mb(tag, *buffers):
    size = sum(buffer.nbytes for buffer in buffers) / 1e6
    logger.info(f"{tag} buffer size: {size:.3f} MB")


def get_export_dir(dir=None):
    if dir is None:
        basename = os.path.splitext(
            os.path.basename(inspect.stack()[-1].filename),
        )[0]

        return os.path.join(
            os.getcwd(),
            time.strftime(f"res_{basename}_%Y%m%d_%H%M%S"),
        )
    else:
        assert isinstance(dir, str)
        return os.path.abspath(dir)


class SolverCl(ABC):

    @property
    @abstractmethod
    def cl_src_file(self) -> None:
        pass

    @property
    @abstractmethod
    def cl_replace_map(self) -> None:
        pass

    @property
    @abstractmethod
    def cl_build_opts(self) -> list[str]:
        pass

    @property
    @abstractmethod
    def cl_include_dirs(self) -> list[str]:
        pass

    @abstractmethod
    def _dalloc(self, ocl_queue) -> None:
        pass

    @abstractmethod
    def _halloc(self) -> None:
        pass

    @abstractmethod
    def _init_sol(self, ocl_queue, ocl_prg) -> None:
        pass

    @abstractmethod
    def _solve(self, ocl_queue, ocl_prog) -> None:
        pass

    def _init_ocl(self):
        # Create OpenCL context and queue
        self.ctx = cl.create_some_context(interactive=True)

        self.ocl_queue = cl.CommandQueue(
            self.ctx,
            properties=cl.command_queue_properties.PROFILING_ENABLE,
        )

        # Read OpenCL main source file
        with open(self.cl_src_file, "r") as f:
            src = f.read()

        # Inject values into the OpenCL source using replace_maps
        if self.use_double:
            fmt = ".15f"
            suffix = ""
        else:
            fmt = ".8f"
            suffix = "f"

        for key, val in self.cl_replace_map.items():
            val_fmt = (
                f"({val:{fmt}}{suffix})"
                if isinstance(val, np.float32) or isinstance(val, np.float64)
                else f"({val})"
            )
            src = src.replace("{}".format(key), val_fmt)

        # Create OpenCL program
        self.ocl_prg = cl.Program(self.ctx, src)
        logger.info("Starting to build OpenCL target...")
        t_start = time.time()
        self.ocl_prg.build(options=self.cl_build_opts)
        logger.info(f"OpenCL sucessfully built in {time.time() - t_start:>.3f} sec")

        print(src)

    def run(self) -> None:
        # Initialize OpenCL contexte, queue and program (compile source)
        self._init_ocl()

        # Initialize OpenCL buffer
        self._dalloc(self.ocl_queue)

        # Initialize numpy buffers
        self._halloc()

        # Initialize OpenCL solution buffer
        self._init_sol(self.ocl_queue, self.ocl_prg)

        self.get_gpu_mem_size_mb()

        # Change dir for exporter
        self.export_dir = get_export_dir()
        if not os.path.exists(self.export_dir):
            os.makedirs(self.export_dir)
        
        # Dump simulation config data
        os.chdir(self.export_dir)
        with open("config.json", "w") as f:
            json.dump(self.to_dict(), f, indent=4)

        # Execute the solver
        logger.info("Starting to solve...")
        t1 = time.time()
        self._solve(self.ocl_queue, self.ocl_prg)
        logger.info(f"Computation done in {time.time() - t1:>.3f} sec")

    def get_gpu_mem_size_mb(self):
        buf_sizes = 0
        buf_names = []

        for name, value in inspect.getmembers(self):
            if isinstance(value, cl.array.Array):
                buf_names += [name]
                buf_sizes += value.nbytes

        buf_names = ", ".join(buf_names)
        buf_sizes /= 1e6
        logger.info(f"OpenCL buffer names: {buf_names}")
        logger.info(f"OpenCL buffer total size: {buf_sizes:.3f} MB")

    @abstractmethod
    def to_dict(self, extra_values={}):
        pass

    @abstractmethod
    def _export_data(self, ocl_queue, writer) -> None:
        pass
