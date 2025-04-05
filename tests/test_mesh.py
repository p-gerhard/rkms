import numpy as np

from rkms.mesh import *

MESH_TOL = 1e-6


def test_mesh_q4_unit_square_nx2_ny2():
    nb_cells_ref = 4
    dx_ref = 0.50
    dy_ref = 0.50

    elem2elem_ref = np.asarray(
        [
            [2, -1, 1, -1],
            [3, -1, -1, 0],
            [-1, 0, 3, -1],
            [-1, 1, -1, 2],
        ],
        dtype=np.int64,
    )

    cells_center_ref = np.asarray(
        [
            [0.25, 0.25],
            [0.25, 0.75],
            [0.75, 0.25],
            [0.75, 0.75],
        ],
        dtype=np.float32,
    )

    m = MeshStructured(
        filename="./tests/meshes/q4_unit_square_nx2_ny2.msh",
    )

    # Checking cells dimensions
    assert abs(m.cell_size[0] < dx_ref) < MESH_TOL
    assert abs(m.cell_size[1] < dy_ref) < MESH_TOL

    # Checking connectivity
    elem2elem = m.elem2elem.reshape(
        (nb_cells_ref, Q4_ELEM.get("FACE_PER_ELEM")),
    )
    assert np.array_equal(elem2elem_ref, elem2elem)

    # Checking cells center
    cells_center = m.cells_center.reshape(
        (nb_cells_ref, Q4_ELEM.get("PHY_DIM")),
    )
    assert np.array_equal(cells_center_ref, cells_center)


def test_mesh_h8_unit_cube_nx2_ny2_nz2():
    nb_cells_ref = 8
    dx_ref = 0.50
    dy_ref = 0.50
    dz_ref = 0.50

    elem2elem_ref = np.asarray(
        [
            [4, -1, 2, -1, -1, 1],
            [5, -1, 3, -1, 0, -1],
            [6, -1, -1, 0, -1, 3],
            [7, -1, -1, 1, 2, -1],
            [-1, 0, 6, -1, -1, 5],
            [-1, 1, 7, -1, 4, -1],
            [-1, 2, -1, 4, -1, 7],
            [-1, 3, -1, 5, 6, -1],
        ],
        dtype=np.int64,
    )

    cells_center_ref = np.asarray(
        [
            [0.25, 0.25, 0.75],
            [0.25, 0.25, 0.25],
            [0.25, 0.75, 0.75],
            [0.25, 0.75, 0.25],
            [0.75, 0.25, 0.75],
            [0.75, 0.25, 0.25],
            [0.75, 0.75, 0.75],
            [0.75, 0.75, 0.25],
        ],
        dtype=np.float32,
    )

    m = MeshStructured(
        filename="./tests/meshes/h8_unit_cube_nx2_ny2_nz2.msh",
    )

    # Checking cells dimensions
    assert abs(m.cell_size[0] < dx_ref) < MESH_TOL
    assert abs(m.cell_size[1] < dy_ref) < MESH_TOL
    assert abs(m.cell_size[2] < dz_ref) < MESH_TOL

    # Checking connectivity
    elem2elem = m.elem2elem.reshape(
        (nb_cells_ref, H8_ELEM.get("FACE_PER_ELEM")),
    )
    assert np.array_equal(elem2elem_ref, elem2elem)

    # Checking cells center
    cells_center = m.cells_center.reshape(
        (nb_cells_ref, H8_ELEM.get("PHY_DIM")),
    )
    assert np.array_equal(cells_center_ref, cells_center)

    m.print_infos()
