#!/usr/bin/env python3
# -*- coding: utf-8 -*-
import logging
import meshio
import numpy as np

from rkms.common import *

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

from .libmesh import (
    extract_cell_size,
    build_elem2elem,
    process_cells,
    process_nodes,
    check_elem2elem,
)

MESH_INT_DTYPE = np.int64
MESH_FLOAT_DTYPE = np.float32
MESH_TOL = 1e-6
# GMSH Quadrangle:
#
#       v
#       ^
#       |
# 3-----------2
# |     |     |
# |     |     |
# |     +---- | --> u
# |           |
# |           |
# 0-----------1

Q4_ELEM = {
    "ELEM_CODE": 3,
    "PHY_DIM": 2,
    "FACE_PER_ELEM": 4,
    "NODE_PER_ELEM": 4,
    "NODE_PER_FACE": 2,
    "FACE_TO_LOC_NODE": [
        [1, 2],  # Right
        [3, 0],  # Left
        [2, 3],  # North
        [0, 1],  # South
    ],
    "GMSH_REF_NODE_COORD": [
        (0.0, 0.0),
        (1.0, 0.0),
        (1.0, 1.0),
        (0.0, 1.0),
    ],
}

# GMSH Order Hexahedron:
#
#        v
# 3----------2
# |\     ^   |\
# | \    |   | \
# |  \   |   |  \
# |   7------+---6
# |   |  +-- |-- | -> u
# 0---+---\--1   |
#  \  |    \  \  |       8
#   \ |     \  \ |
#    \|      w  \|
#     4----------5

H8_ELEM = {
    "ELEM_CODE": 5,
    "PHY_DIM": 3,
    "FACE_PER_ELEM": 6,
    "NODE_PER_ELEM": 8,
    "NODE_PER_FACE": 4,
    "FACE_TO_LOC_NODE": [
        [1, 2, 6, 5],  # Right
        [0, 4, 7, 3],  # Left
        [2, 3, 7, 6],  # Front
        [1, 5, 4, 0],  # Back
        [4, 5, 6, 7],  # North
        [0, 3, 2, 1],  # South
    ],
    "GMSH_REF_NODE_COORD": [
        (0.0, 0.0, 0.0),
        (1.0, 0.0, 0.0),
        (1.0, 1.0, 0.0),
        (0.0, 1.0, 0.0),
        (0.0, 0.0, 1.0),
        (1.0, 0.0, 1.0),
        (1.0, 1.0, 1.0),
        (0.0, 1.0, 1.0),
    ],
}


def get_geometry_volume(nb_cells, dx, dy, dz, is_2d):
    if is_2d:
        volume = nb_cells * dx * dy
    else:
        volume = nb_cells * dx * dy * dz

    return volume


def get_geometry_surface(nb_cells, elem2elem, dx, dy, dz, is_2d):
    surface = 0

    if is_2d:
        face_area = [dy, dx, dy, dx]

        for idx_elem in range(nb_cells):
            for idx_face in range(0, 4):
                if elem2elem[idx_elem * 4 + idx_face] == -1:
                    surface += face_area[idx_face]
    else:
        face_area = [dz * dy, dz * dy, dz * dx, dz * dx, dx * dy, dx * dy]

        for idx_elem in range(nb_cells):
            for idx_face in range(0, 6):
                if elem2elem[idx_elem * 6 + idx_face] == -1:
                    surface += face_area[idx_face]

    return surface


class MeshStructured:
    def __init__(self, filename):
        assert isinstance(filename, str)
        self.filename = filename

        # Read mesh using meshio
        print("Reading mesh file...")
        self.mesh = meshio.read(filename)

        # Create reference on meshio nodes coordinates
        self.nodes = np.asarray(
            self.mesh.points,
            dtype=MESH_FLOAT_DTYPE,
        )

        # Compare z-coordinates of nodes (always present in meshio even at 2D)
        # in order to detect if the mesh is 2D or 3D
        z_equal = abs(self.nodes[0][2] - self.nodes[:, 2]) < MESH_TOL
        is_2d = np.bitwise_and.reduce(z_equal) == z_equal[0]

        if is_2d:
            print("2-dimensional mesh detected...")
            self.dim = 2
            self.cell_name = "quad"
            self.elem_data = Q4_ELEM

            print("Removing nodes z-coordinate...")
            self.nodes = np.delete(self.nodes, 2, 1)

        else:
            print("3-dimensional mesh detected...")
            self.dim = 3
            self.cell_name = "hexahedron"
            self.elem_data = H8_ELEM

        # Extract nodes number and assert correctness of physical dimension
        self.nb_nodes, phy_dim_point = self.nodes.shape
        assert phy_dim_point == self.dim

        # Check that selected cell_name (meshio name) is inside meshio cells_dict
        assert self.cell_name in self.mesh.cells_dict.keys()

        # Extract only cell type of interest
        self.cells = np.asarray(
            self.mesh.cells_dict[self.cell_name],
            dtype=MESH_INT_DTYPE,
        )

        # Extract number of cells and check of node per element
        self.nb_cells, nb_loc_node = self.cells.shape
        assert nb_loc_node == self.elem_data["NODE_PER_ELEM"]

        # Ensure data are C order in memory
        self.cells = np.ravel(self.cells)
        self.points = np.ravel(self.nodes)

        # Host buffer to store cell center coordinates
        self.cells_center = np.empty(
            self.dim * self.nb_cells,
            dtype=MESH_FLOAT_DTYPE,
        )

        # Host buffer to store element to elements (through cell faces)
        # connectivity
        size_elem2elem = self.elem_data["FACE_PER_ELEM"] * self.nb_cells

        # Buffer storing the connectivity element to element.
        # Example:
        # - For Q4_ELEM we store neighbours element id through each face in the
        #   order: [RIGHT, LEFT, NORTH, SOUTH].
        #   See drawing of the Q4_ELEM above.
        # - For H8_ELEM we store neighbours element id through each face in the
        #   order: [RIGHT, LEFT, FRONT, BACK, NORTH, SOUTH].
        #   See drawing of the Q4_ELEM above.
        # - A value -1 means that an element has no neighbours through the face
        #   (ie. boundary element).

        self.elem2elem = np.full(
            size_elem2elem,
            -1,
            dtype=MESH_INT_DTYPE,
        )

        # Host buffer to store cell size ie dx, dy, dz. Its possible to have
        # 'dx' != 'dy' != 'dz' but all 'dx' (resp. 'dy', resp. 'dz') must be
        # constant over all cells
        self.cell_size = np.zeros(
            self.dim,
            dtype=MESH_FLOAT_DTYPE,
        )

        # Calling now compiled C++ functions from libmesh*.so
        # WARNING: If the mesh is wrong the cpp lib will fail some assert()
        # post conditions and throw SIG ABORT so the process will end.
        print("Extracting cell sizes...")
        extract_cell_size(self.nodes, self.cells, self.cell_size, is_2d)

        self.dx = MESH_FLOAT_DTYPE(self.cell_size[0])
        self.dy = MESH_FLOAT_DTYPE(self.cell_size[1])
        self.dz = MESH_FLOAT_DTYPE(0.0)
        if not is_2d:
            self.dz = MESH_FLOAT_DTYPE(self.cell_size[2])

        print("Processing cells...")
        process_cells(
            self.nb_cells,
            self.cell_size,
            self.nodes,
            self.cells,
            self.cells_center,
            is_2d,
        )

        print("Processing nodes...")
        process_nodes(self.nb_nodes, self.cell_size, self.nodes, is_2d)

        print("Building elements connectivity...")
        build_elem2elem(self.nb_cells, self.cells, self.elem2elem, is_2d)

        print("Checking elements connectivity...")
        check_elem2elem(self.nb_cells, self.elem2elem, is_2d)

        # Compute total volume of the mesh
        self.volume = get_geometry_volume(
            self.nb_cells,
            self.dx,
            self.dy,
            self.dz,
            is_2d,
        )

        # Compute surface of mesh boundaries
        self.surface = get_geometry_surface(
            self.nb_cells,
            self.elem2elem,
            self.dx,
            self.dy,
            self.dz,
            is_2d,
        )

        # Reshape point buffer a two-dimensional array
        # [[ x,y,z], ..., [x,y,z]]
        self.points = np.reshape(
            self.nodes,
            (self.nb_nodes, self.dim),
        )

        # Reshape cells buffer to a two-dimensional array
        # [[id_node, id_node, ...], ...,  [id_node, id_node, ...]]
        self.cells = np.reshape(
            self.cells,
            (self.nb_cells, self.elem_data["NODE_PER_ELEM"]),
        )

    def get_params_to_print(self):
        params = {
            "Filename": self.filename,
            "Dim": self.dim,
            "Cell type": self.cell_name,
            "Node number": self.nb_nodes,
            "Cell number": self.nb_cells,
            "Size dx": self.dx,
            "Size dy": self.dy,
            "Size dz": self.dz,
            "Mesh outer surface": self.surface,
            "Mesh inner volume": self.volume,
        }

        return params

    def print_infos(self):
        params = self.get_params_to_print()
        pprint_dict(params, header_msg="MESH INFOS")
