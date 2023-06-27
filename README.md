# Reduced Kinetic Models Solver

## Description
TODO

## Building and Installation

This project is implemented in Python 3, OpenCL v1.2, and C++11. It relies on several packages and libraries, including:

| Name                    | Link                                                            | Description                                                                                    |
| ----------------------- | --------------------------------------------------------------- | ---------------------------------------------------------------------------------------------- |
| `meshio`                | [meshio](https://github.com/nschloe/meshio "meshio")            | A package for handling mesh data                                                               |
| `pybind11`              | [pybind11](https://github.com/pybind/pybind11 "pybind11")       | A lightweight library for creating Python bindings for C++ code                                |
| `pyopencl `             | [pyopencl](https://github.com/inducer/pyopencl "PyOpenCL")      | A Python wrapper for OpenCL, providing GPU and multi-core CPU parallel computing capabilities. |
| `abseil-cpp (optional)` | [abseil-cpp](https://github.com/abseil/abseil-cpp "abseil-cpp") | Abseil Common Libraries, a collection of C++ libraries used for various purposes               |

To use this project on your host system, follow these steps:

1. Ensure you have installed on your system.

| Name         | Version | Description                                                                                                                        |
| ------------ | ------- | ---------------------------------------------------------------------------------------------------------------------------------- |
| `Python`     | >=3.7   | Running and calling the main code. The modules `pip` and `venv` must be available.                                                   |
| `CMake `     | >=3.12  | Building the C++ mesh lib at package installation.                                                                                 |
| `Clang/LLVM` | >=5     | Compiling the C++ mesh lib at package installation. Must support `-std=c++17`.                                                     |
| `GCC`        | >=9     | Compiling the C++ mesh lib at package installation. As an alternative to `Clang/LLVM` if not available. Must support `-std=c++17`. |
| `OpenCL`     | >=1.2   | Building the compute kernels at runtime. A Compatible driver, headers and compiler must be installed                               |

<!-- 1. Clone the project repository from GitHub:
 
        git clone https://github.com/p-gerhard/rkms.git -->
       
2. Create a virtual environment for the project:
   
        python3 -m venv rkms-env
        
3. Activate the virtual environment:

        source rkms-env/bin/activate
  
Advices:
  1. Create a virtual dedicated environment using `python3 -m venv venv-rkms`

