from __future__ import annotations

from rkms.mesh import MeshStructured
import numpy as np

if __name__ == "__main__":
    # Build Mesh
    dim = 3
    mesh_nx = 2
    mesh_ny = 2
    mesh_nz = 2 if dim == 3 else 0

    mesh = MeshStructured(
        filename=None,
        nx=mesh_nx,
        ny=mesh_ny,
        nz=mesh_nz,
        xmin=0.0,
        xmax=1.0,
        ymin=0.0,
        ymax=1.0,
        zmin=0.0,
        zmax=1.0,
        use_periodic_bd=True,
    )

    nb_neighors = 3
    dx_offset = 0.5 * mesh.dx
    dy_offset = 0.5 * mesh.dy

    if dim == 3:
        nb_neighors = 6
        dz_offset = 0.5 * mesh.dz

    nbs = mesh.elem2elem.reshape(-1, nb_neighors)
    print(nbs)


    import numpy as np

    nb_neighbors = 6 if dim == 3 else 3

    dx_offset = 0.5 * mesh.dx
    dy_offset = 0.5 * mesh.dy
    dz_offset = 0.5 * mesh.dz if dim == 3 else None

    nbs = mesh.elem2elem.reshape(-1, nb_neighbors)

    # Cells on -X face
    # nbs[mesh.cells_center[:, 0] == mesh.xmin + dx_offset, 1] = -1 

    # Cells on +X face
    # nbs[mesh.cells_center[:, 0] == mesh.xmax - dx_offset, 0] = -1

    # Cells on -Y face
    nbs[mesh.cells_center[:, 1] == mesh.ymin + dy_offset, 3] = -1 

    # Cells on +Y face
    nbs[mesh.cells_center[:, 1] == mesh.ymax - dy_offset, 2] = -1


    if dim == 3:
        # Cells on -Z face
        nbs[mesh.cells_center[:, 2] == mesh.zmin + dz_offset, 5] = -1  

        # Cells on +Z face
        nbs[mesh.cells_center[:, 2] == mesh.zmax - dz_offset, 4] = -1 

    print(nbs)
    # Flatten back
    mesh.elem2elem = nbs.flatten()
    print(mesh.elem2elem)

    exit()

    # UNVECTORIZED VERSION DEPRECATED

    # for idx in range(nbs.shape[0]):

        # Check if the cell lies on the -X boundary face
        # if mesh.cells_center[idx][0] == mesh.xmin + dx_offset:
            # print("The cell lies on the boundary face with normal in the -X direction.")
            # For a non-periodic mesh, the Left face (index 1) should have no neighbor (-1).
            # assert nbs[idx][1] == -1

            # For a periodic mesh we strip the neighbor
            # nbs[idx][1] == -1

        # Check if the cell lies on the +X boundary face
        # if mesh.cells_center[idx][0] == mesh.xmax - dx_offset:
            # print("The cell lies on the boundary face with normal in the +X direction.")
            # For a non-periodic mesh, the Right face (index 0) should have no neighbor (-1).
            # assert nbs[idx][0] == -1

            # For a periodic mesh we strip the neighbor
            # nbs[idx][0] == -1

        # Check if the cell lies on the -Y boundary face
        # if mesh.cells_center[idx][1] == mesh.ymin + dy_offset:
            # print("The cell lies on the boundary face with normal in the -Y direction.")
            # For a non-periodic mesh, the Back face (index 3) should have no neighbor (-1).
            # assert nbs[idx][3] == -1

            # For a periodic mesh we strip the neighbor
            # nbs[idx][3] = -1

        # Check if the cell lies on the +Y boundary face
        # if mesh.cells_center[idx][1] == mesh.ymax - dy_offset:
            # print("The cell lies on the boundary face with normal in the +Y direction.")
            # For a non-periodic mesh, the Front face (index 2) should have no neighbor (-1).
            # assert nbs[idx][2] == -1

            # For a periodic mesh we strip the neighbor
            # nbs[idx][2] = -1

        # Check if the cell lies on the -Z boundary face
        # if dim == 3 and (mesh.cells_center[idx][2] == mesh.zmin + dz_offset):
            # print("The cell lies on the boundary face with normal in the -Z direction.")
            # For a non-periodic mesh, the South face (index 5) should have no neighbor (-1).
            # assert nbs[idx][5] == -1

            # For a periodic mesh we strip the neighbor
            # nbs[idx][5] = -1

        # Check if the cell lies on the +Z boundary face
        # if dim == 3 and (mesh.cells_center[idx][2] == mesh.zmax + dz_offset):
            # print("The cell lies on the boundary face with normal in the +Z direction.")
            # For a non-periodic mesh, the North face (index 4) should have no neighbor (-1).
            # assert nbs[idx][4] == -1

            # For a periodic mesh we strip the neighbor
            # nbs[idx][4] = -1

    # print(nbs)
    # Flatten back
    # mesh.elem2elem = nbs.flatten()
    # print(mesh.elem2elem)
