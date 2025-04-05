from __future__ import annotations

from rkms.mesh import MeshStructured

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

    mesh.elem2elem = nbs.flatten()
