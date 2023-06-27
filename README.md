# Reduced Kinetic Models Solver

## Description
TODO

## Building and Installation

To use this project on your host system, follow these steps:

1. Ensure that the following dependencies are installed on your system:

    | Name         | Version | Description                                                                                                                        |
    | ------------ | ------- | ---------------------------------------------------------------------------------------------------------------------------------- |
    | `Python`     | >=3.7   | Required for running and calling the main code. Make sure to have `pip` and `venv` installed as well.                                                   |
    | `CMake`      | >=3.18  | Used for building the C++ mesh library during package installation.                                                                                 |
    | `Clang/LLVM` | >=5     | Used for compiling the C++ mesh library during package installation. Should support `-std=c++17`.                                                     |
    | `GCC`        | >=9     | Used as an alternative to `Clang/LLVM` if it's not available. Should support `-std=c++17`. |
    | `OpenCL`     | >=1.2   | Required for building the compute kernels at runtime. Make sure to have a compatible driver, headers, and compiler installed.                               |

    **Note**: If you're working in a cluster environment, load the appropriate environment modules to make the required packages available.
       
2. Create a virtual environment for the project:

    ```bash
    python3 -m venv venv-rkms
      ```

2. Activate the virtual environment:
   
   ```bash
    python3 -m venv venv-rkms
    ```

3. Activate the virtual environment:

    ```bash
    source venv-rkms/bin/activate
    ```
4. Install the package

    ```bash
    pip install git+https://github.com/p-gerhard/rkms
    ```