from __future__ import annotations

import logging

import meshio
import numpy as np
from rkms.common import *

from ._builder import MeshBuilder
from ._common import MESH_FLOAT_DTYPE, MESH_INT_DTYPE, MESH_TOL
from ._elements import H8_ELEM, Q4_ELEM

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)

logging.basicConfig(
    format="[%(asctime)s] - %(levelname)s - %(message)s",
    datefmt="%m/%d/%Y %I:%M:%S %p",
)

from .libmesh import (
    build_elem2elem,
    build_periodic_mesh,
    check_elem2elem,
    extract_cell_size,
    process_cells,
    process_nodes,
)


class MeshStructured:
    def __init__(
        self,
        filename: str | None = None,
        nx: int = 1,
        ny: int = 1,
        nz: int = 1,
        xmin: float = 0.0,
        xmax: float = 1.0,
        ymin: float = 0.0,
        ymax: float = 1.0,
        zmin: float = 0.0,
        zmax: float = 1.0,
        use_periodic_bd: bool = False,
    ):
        # Read mesh file using meshio library
        self.build_mesh = True

        if filename:
            self.filename = str(filename)
            logger.info("Reading uniform mesh...")
            self.mesh = meshio.read(filename)
            self.build_mesh = False
            self.nx = None
            self.ny = None
            self.nz = None
            self.xmin = None
            self.ymin = None
            self.zmin = None
            self.xmax = None
            self.ymax = None
            self.zmax = None

        # Build simple cuboid/rectangle mesh
        if self.build_mesh:
            self.filename = "None"
            logger.info("Building uniform mesh...")
            self.mesh = MeshBuilder(
                nx,
                ny,
                nz,
                xmin,
                xmax,
                ymin,
                ymax,
                zmin,
                zmax,
            )
            self.nx = nx
            self.ny = ny
            self.nz = nz
            self.xmin = xmin
            self.ymin = ymin
            self.zmin = zmin
            self.xmax = xmax
            self.ymax = ymax
            self.zmax = zmax

        # Create new reference on meshio "points" (nodes coordinates)
        self.nodes = np.asarray(
            self.mesh.points,
            dtype=MESH_FLOAT_DTYPE,
        )

        # Detect if mesh is two or three dim
        self.is_2d = self._is_2d_mesh()

        if self.is_2d:
            logger.info("Two-dimensional mesh detected...")
            self.dim = 2
            self.cell_name = "quad"
            self.elem_data = Q4_ELEM

            logger.info("Removing z-coordinate...")
            self.nodes = np.delete(self.nodes, 2, 1)

        else:
            logger.info("Three-dimensional mesh detected...")
            self.dim = 3
            self.cell_name = "hexahedron"
            self.elem_data = H8_ELEM

        # Extract nodes number and assert correctness of physical dimension
        self.nb_nodes, phy_dim_point = self.nodes.shape
        assert phy_dim_point == self.dim

        # Check that selected cell_name (meshio name) is inside meshio cells_dict
        assert self.cell_name in self.mesh.cells_dict.keys()

        # Extract only cell type of interest Q4 or H8
        self.cells = np.asarray(
            self.mesh.cells_dict[self.cell_name],
            dtype=MESH_INT_DTYPE,
        )

        # Extract number of cells and check number of node per element
        self.nb_cells, nb_loc_node = self.cells.shape
        assert nb_loc_node == self.elem_data["NODE_PER_ELEM"]

        # Ensure data are C order in memory
        self.nodes = np.ravel(self.nodes)
        self.cells = np.ravel(self.cells)

        if self.build_mesh:
            # WARNING: The values below are provided by Meshbuilder which is not
            # the case when reading a mesh with meshio. So we will compute them
            # below.
            self.dx = self.mesh.dx
            self.dy = self.mesh.dy
            self.dz = self.mesh.dz
            self.elem2elem = self.mesh.elem2elem
            self.cells_center = self.mesh.cells_center
        else:
            self.cell_size = self._get_cell_size()
            self.dx = self.cell_size[0]
            self.dy = self.cell_size[1]
            self.dz = self.cell_size[2] if not self.is_2d else np.float64(0.0)
            # Build cell center and verify cells
            self.cells_center = self._process_cells()
            # Check nodes
            self._process_nodes()
            # Build connectivity
            self.elem2elem = self._get_connectivity()

        # Build periodic boundaries
        self.use_periodic_bd = use_periodic_bd
        if self.use_periodic_bd:
            self._build_periodic_bd()

        # Compute some metrics
        self.hmin = self._get_hmin()
        self.volume = self._get_volume()
        self.boundary_surface = self._get_boundary_surface()

        # Reshape point buffer a two-dimensional array (used when export by
        # meshio) [[ x,y,z], ..., [x,y,z]]
        self.points = np.reshape(
            self.nodes,
            (
                self.nb_nodes,
                self.dim,
            ),
        )

        # Reshape cells buffer to a two-dimensional array (used when export by
        # meshio) [[id_node, id_node, ...], ...,  [id_node, id_node, ...]]
        self.cells = np.reshape(
            self.cells, (self.nb_cells, self.elem_data["NODE_PER_ELEM"])
        )

    def _is_2d_mesh(self) -> bool:
        """
        Check if the mesh is two-dimensional based on the z-coordinates of nodes.

        The function uses NumPy's `allclose` to determine if all z-coordinates
        in the mesh are close enough to the z-coordinate of the first node. The
        absolute tolerance is specified by `MESH_TOL`.

        Returns:
            bool: True if the mesh is two-dimensional, False otherwise.
        """
        return np.allclose(self.nodes[0, 2], self.nodes[:, 2], atol=MESH_TOL)

    def _get_cell_size(self):
        """
        Calculate and return the cell size (dx, dy, dz).

        The function utilizes a host buffer to store cell sizes, where 'dx',
        'dy', and 'dz' represent dimensions. It is permissible for 'dx', 'dy',
        and 'dz' to have different values, but all 'dx' (or 'dy' or 'dz') must
        remain constant over all cells.

        The calculation involves calling compiled C++ functions from
        libmesh*.so. WARNING: If the mesh is incorrect, the C++ library may fail
        some assert() post conditions and throw SIG ABORT, leading to process
        termination.

        Returns:
            numpy.ndarray: An array containing the calculated cell sizes for each dimension.
        """
        cell_size = np.zeros(self.dim, dtype=np.float64)

        logger.info("Extracting cell sizes...")
        extract_cell_size(self.nodes, self.cells, cell_size, self.is_2d)

        return cell_size

    def _get_connectivity(self):
        """
        Build and return the connectivity matrix between elements.

        The function creates a buffer to store the connectivity between elements.
        For example:
        - For Q4_ELEM, neighbors' element IDs are stored through each face in
        the order: [RIGHT, LEFT, NORTH, SOUTH].
        - For H8_ELEM, neighbors' element IDs are stored through each face in
        the order: [RIGHT, LEFT, FRONT, BACK, NORTH, SOUTH].

        A value of -1 indicates that an element has no neighbors through the
        face (i.e., a boundary element).

        The calculation involves calling compiled C++ functions from
        libmesh*.so. WARNING: If the mesh is incorrect, the C++ library may fail
        some assert() post conditions and throw SIG ABORT, leading to process
        termination.

        Returns:
            numpy.ndarray: An array containing the connectivity between
            elements.
        """
        elem2elem = np.full(
            self.elem_data["FACE_PER_ELEM"] * self.nb_cells,
            -1,
            dtype=MESH_INT_DTYPE,
        )

        logger.info("Building elements connectivity...")
        build_elem2elem(self.nb_cells, self.cells, elem2elem, self.is_2d)

        logger.info("Checking elements connectivity...")
        check_elem2elem(self.nb_cells, elem2elem, self.is_2d)

        return elem2elem

    def _process_cells(self):
        # Set buffer to store cell center coordinates
        cells_center = np.empty(
            self.dim * self.nb_cells,
            dtype=np.float64,
        )

        logger.info("Processing cells...")
        process_cells(
            self.nb_cells,
            self.cell_size,
            self.nodes,
            self.cells,
            cells_center,
            self.is_2d,
        )

        return cells_center

    def _process_nodes(self) -> None:
        logger.info("Processing nodes...")
        process_nodes(self.nb_nodes, self.cell_size, self.nodes, self.is_2d)

    def _build_periodic_bd(self):
        logger.info("Building periodic boundaries...")
        build_periodic_mesh(self.nb_cells, self.elem2elem, self.is_2d)

    def _get_hmin(self):
        """
        Calculate and return the minimum element size (h_min).

        The function calculates the minimum element size. For a 2D mesh, it uses
        the area and perimeter of the element. For a 3D mesh, it considers the
        volume and surface area.

        Returns: float: The minimum element size (h_min).
        """
        if self.dim == 2:
            cell_v = self.dx * self.dy
            cell_s = 2.0 * (self.dx + self.dy)

        else:
            cell_v = self.dx * self.dy * self.dz
            cell_s = 2.0 * (self.dx * self.dy + self.dy * self.dz + self.dz * self.dx)

        return cell_v / cell_s

    def _get_volume(self):
        """
        Calculate and return the total volume of the mesh.

        Returns:
            float: The volume of the mesh.
        """
        return (
            self.nb_cells * self.dx * self.dy
            if self.dim == 2
            else self.nb_cells * self.dx * self.dy * self.dz
        )

    def _get_boundary_surface(self):
        """
        Calculate and return the total boundary surface of the mesh.

        Returns:
            float: The boundary surface of the geometry.
        """
        face_per_elem = self.elem_data["FACE_PER_ELEM"]

        face_surf = [
            self.dz * self.dy,
            self.dz * self.dy,
            self.dz * self.dx,
            self.dz * self.dx,
            self.dx * self.dy,
            self.dx * self.dy,
        ]

        if self.dim == 2:
            face_surf = [
                self.dy,
                self.dx,
                self.dy,
                self.dx,
            ]

        return sum(
            sum(
                face_surf[idx_face]
                for idx_face in range(face_per_elem)
                if self.elem2elem[idx_elem * face_per_elem + idx_face] == -1
            )
            for idx_elem in range(self.nb_cells)
        )

    def to_dict(self, extra_values={}):
        filtered_name = ["elem_data"]
        dict = serialize(self, filtered_name)
        dict.update(extra_values)
        return dict
