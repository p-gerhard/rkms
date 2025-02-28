from __future__ import annotations

from rkms.mesh import MeshStructured
import numpy as np


def get_idx(i, j, k, nx, ny, nz):
    return i + j * (nx) + k * (nx) * (ny)


def get_ijk(idx, nx, ny, nz):
    k = idx // (nx * ny)
    j = (idx // nx) % ny
    i = idx % nx
    return i, j, k


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

    mesh.plot()

    print(80 * "#")
    print("# Nodes")
    print(80 * "#")
    print("# Nodes - Manually generated with kij order")
    nodes = np.zeros(
        (mesh.nx + 1, mesh.ny + 1, mesh.nz + 1),
        dtype=object,
    )

    for k in range(mesh.nz + 1):
        for j in range(mesh.ny + 1):
            for i in range(mesh.nx + 1):
                nodes[k][j][i] = [i * mesh.dx, j * mesh.dy, k * mesh.dz]
                print(nodes[k][j][i])

    print("\n# Nodes - MeshBuilder generated")
    print(mesh.points)

    print("\n# Nodes - MeshBuilder generated + (ravel: inside rkms OpenCL buffer)")
    print(np.ravel(mesh.points))

    print(80 * "#")
    print("# Cells")
    print(80 * "#")

    print(
        "\n # Example: mapping for cell mesh indexes (i,j,k) get global cell id (rkms OpenCL global_id)"
    )
    for k in range(mesh.nz):
        for j in range(mesh.ny):
            for i in range(mesh.nx):
                idx = get_idx(
                    i,
                    j,
                    k,
                    mesh.nz,
                    mesh.ny,
                    mesh.nx,
                )
                print(f"(i,j,k) = ({i},{j},{k}) gives {idx} (global_id)")

    print(
        "\n # Example: mapping for global cell id (rkms OpenCL global_id) get cell mesh indexes (i,j,k)"
    )
    for idx in range(mesh_nx * mesh_ny * mesh_nz):
        i, j, k = get_ijk(idx, mesh_nx, mesh_ny, mesh_nz)
        print(f"global_id = {idx} gives (i,j,k) = ({i},{j},{k})")
