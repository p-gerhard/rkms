# Reduced Kinetic Models Solver

## Description
TODO

## Building and Installation

To use this project on your host system, follow these steps:

1. Ensure that the following dependencies are installed on your system:

    | Name         | Version | Description                                                                                                                   |
    | ------------ | ------- | ----------------------------------------------------------------------------------------------------------------------------- |
    | `Python`     | >=3.7   | Required for running and calling the main code. Make sure to have `pip` and `venv` installed as well.                         |
    | `CMake`      | >=3.18  | Used for building the C++ mesh library during package installation.                                                           |
    | `Clang/LLVM` | >=5     | Used for compiling the C++ mesh library during package installation. Should support `-std=c++17`.                             |
    | `GCC`        | >=9     | Used as an alternative to `Clang/LLVM` if it's not available. Should support `-std=c++17`.                                    |
    | `OpenCL`     | >=1.2   | Required for building the compute kernels at runtime. Make sure to have a compatible driver, headers, and compiler installed. |

    **Note**: If you're working in a cluster environment, load the appropriate environment modules to make the required packages available.

2. Clone the repository

    ```bash
    git clone https://github.com/p-gerhard/rkms.git
    ``` 
       
3. Create a virtual environment for the project:

    ```bash
    python3 -m venv venv-rkms
      ```

4. Activate the virtual environment:

    ```bash
    source venv-rkms/bin/activate
    ```
5. Install the package

    ```bash
    pip install .
    ```
    
## Running examples

### Creating a mesh with Gmsh

Gmsh is an open-source mesh generation software that allows you to create meshes
for various applications. Follow these steps to create a mesh using Gmsh:

1. **Install Gmsh:** You must have the [gmsh](http://gmsh.info/) package
   installed on your to follow the instructions below.

2. **Create/edit a geometry file:** In order to build meshes, two basic Gmsh geometry
   (`.geo`) files are provided in the `/data/geo` directory:

   - `/data/geo/cuboid.geo`: This file defines a three-dimensional cuboid geometry.
     It will produce a mesh of `H8` elements. By default, the geometry is a unit
     cube centered at (0.5, 0.5, 0.5), and the refinement in each direction is set
     to `nx=64`, `ny=64`, and `nz=64`.

   - `/data/geo/rectangle.geo`: This file defines a two-dimensional rectangle
     geometry. It will produce a mesh of `Q4` elements. By default, the geometry
     is a unit square centered at (0.5, 0.5), and the refinement in each direction
     is set to `nx=64` and `ny=64`.

    **Remark**: To permanently modify the dimensions and refinement of the
    geometry, you can edit the following variables in the `.geo` files:

    | Variable | Initial Value | Description                           |
    | -------- | ------------- | ------------------------------------- |
    | `xmin`   | 0             | Minimum x-coordinate                  |
    | `ymin`   | 0             | Minimum y-coordinate                  |
    | `zmin`   | 0             | Minimum z-coordinate                  |
    | `xmax`   | 1             | Maximum x-coordinate                  |
    | `ymax`   | 1             | Maximum y-coordinate                  |
    | `zmax`   | 1             | Maximum z-coordinate                  |
    | `nx`     | 64            | Number of subdivisions in x-direction |
    | `ny`     | 64            | Number of subdivisions in y-direction |
    | `nz`     | 64            | Number of subdivisions in z-direction |

3. **Generate the mesh:** To produce a unit cube mesh with custom refinement,
   you can run the following command:
    
    ```bash
    export nx=100; export ny=100; export nz=100;
    gmsh -3 ./data/geo/cuboid.geo \
    -o ./examples/meshes/unit_cube_nx${nx}_ny${ny}_nz${nz}.msh \
    -format msh22 \
    -setnumber nx ${nx} \
    -setnumber ny ${ny} \
    -setnumber nz ${nz}
    ```

    **Remark:** You can dynamically adjust the geometry dimensions by applying the
    same pattern on `xmin`, `xmax`, `ymin`, `ymax`, `zmin` and `zmax`.
    
### Running an example

1. Make sure to load the correct mesh file in the example `.py` file.

2. To run the `PN` example, **navigate to the `./examples`** folder and execute
   the following command:
 
Note: It is essential to be inside the `./examples` folder before running the
code, as the path is set accordingly in the `.py` file.
      

### Visualize results