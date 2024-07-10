import numpy as np
import matplotlib.pyplot as plt
import matplotlib.lines as mlines
import logging

from ._common import MESH_FLOAT_DTYPE, MESH_INT_DTYPE

logger = logging.getLogger(__name__)
logger.setLevel(logging.INFO)


def test_loop_1(self):
    nodes = np.zeros((self.nx + 1, self.ny + 1, self.nz + 1), dtype=object)

    for k in range(self.nz + 1):
        for j in range(self.ny + 1):
            for i in range(self.nx + 1):
                nodes[k][j][i] = (i * self.dx, j * self.dy, k * self.dz)
    return nodes


class MeshBuilder:
    def __init__(self, nx, ny, nz, xmin, xmax, ymin, ymax, zmin, zmax):
        # Number of cells in each direction
        self.nx = MESH_INT_DTYPE(max(nx, 1))
        self.ny = MESH_INT_DTYPE(max(ny, 0))
        self.nz = MESH_INT_DTYPE(max(nz, 0))

        # Geometry (cuboide/rectangle) dimensions
        self.xmin = xmin
        self.xmax = xmax
        self.ymin = ymin
        self.ymax = ymax
        self.zmin = zmin
        self.zmax = zmax

        # x axis is never null
        assert self.xmin != self.xmax
        self.nx_c = self.nx
        self.dx = abs(self.xmax - self.xmin) / self.nx

        # y axis can be null in 1D meshes
        if self.ny == 0:
            assert self.nz == 0, "Case ny=0 and nz!=0 is not allowed"
            self.dy = 0.0
            self.ny_c = MESH_INT_DTYPE(1)
        else:
            self.ny_c = self.ny
            self.dy = abs(self.ymax - self.ymin) / self.ny

        # z axis can be null in 2D meshes
        if self.nz == 0:
            self.dz = 0.0
            self.nz_c = MESH_INT_DTYPE(1)
        else:
            self.nz_c = self.nz
            self.dz = abs(self.zmax - self.zmin) / self.nz

        self.dim = self.get_dim()
        self.nb_nodes = (self.nx + 1) * (self.ny + 1) * (self.nz + 1)
        self.nb_cells = self.nx_c * self.ny_c * self.nz_c

        # Build mesh (points, cells), cell centers and connectivity
        self.points = self.build_nodes()
        self.cells_center = self.build_cells_center()
        self.cells = self.build_cells()
        self.elem2elem = self.build_elem2elem()

        # Note: Creating cells_dicts so MeshUniform can call the same members
        # than meshio.mesh meshio.mesh, bit hacky could be improved.
        self.cells_dict = {cell[0]: cell[1] for cell in self.cells}

    def get_dim(self):
        return (
            1
            if self.ny == 0 and self.nz == 0
            else 2 if self.ny != 0 and self.nz == 0 else 3
        )

    def get_idx(self, i, j, k, nx, ny, nz):
        return i + j * (nx) + k * (nx) * (ny)

    def get_ijk(self, idx, nx, ny, nz):
        k = idx // (nx * ny)
        j = (idx // nx) % ny
        i = idx % nx
        return i, j, k

    def build_nodes(self):
        """
        Generate and return a NumPy array containing the coordinates of the
        nodes that constitute the cells of mesh. The access of a node located at
        (x=i*nx,y=j*ny,z=k*nz) is done using nodes[k][j][i].
        """
        x, y, z = np.meshgrid(
            np.linspace(
                self.zmin,
                self.zmax,
                self.nz + 1,
                dtype=MESH_FLOAT_DTYPE,
            ),
            np.linspace(
                self.ymin,
                self.ymax,
                self.ny + 1,
                dtype=MESH_FLOAT_DTYPE,
            ),
            np.linspace(
                self.xmin,
                self.xmax,
                self.nx + 1,
                dtype=MESH_FLOAT_DTYPE,
            ),
            indexing="ij",
        )

        return np.column_stack((z.flatten(), y.flatten(), x.flatten()))

    def build_cells_center(self):
        """
        Generate and return a NumPy array containing the coordinates of the cell
        centers within the mesh.
        """
        x, y, z = np.meshgrid(
            np.linspace(
                self.zmin + 0.5 * self.dz,
                self.zmax - 0.5 * self.dz,
                self.nz_c,
                dtype=MESH_FLOAT_DTYPE,
            ),
            np.linspace(
                self.ymin + 0.5 * self.dy,
                self.ymax - 0.5 * self.dy,
                self.ny_c,
                dtype=MESH_FLOAT_DTYPE,
            ),
            np.linspace(
                self.xmin + 0.5 * self.dx,
                self.xmax - 0.5 * self.dx,
                self.nx_c,
                dtype=MESH_FLOAT_DTYPE,
            ),
            indexing="ij",
        )

        return np.column_stack((z.flatten(), y.flatten(), x.flatten()))

    def build_cells(self):
        idx = np.arange(
            self.nb_cells,
            dtype=MESH_INT_DTYPE,
        )

        i, j, k = self.get_ijk(idx, self.nx_c, self.ny_c, self.nz_c)

        # Extract the first node indexe
        # ie: Starts 0, try go x axis, try go y axis, try go z axis
        n0 = i + j * (self.nx + 1) + k * (self.nx + 1) * (self.ny + 1)
        n1 = n0 + 1

        if self.dim > 1:
            n2 = n1 + (self.nx + 1)
            n3 = n2 - 1

        if self.dim > 2:
            n4 = n0 + (self.nx + 1) * (self.ny + 1)
            n5 = n4 + 1
            n6 = n5 + (self.nx + 1)
            n7 = n6 - 1

        if self.dim == 1:
            return [("line", np.column_stack((n0, n1)))]
        if self.dim == 2:
            return [("quad", np.column_stack((n0, n1, n2, n3)))]
        else:
            return [("hexahedron", np.column_stack((n0, n1, n2, n3, n4, n5, n6, n7)))]

    def build_elem2elem(self):
        idx = np.arange(
            self.nb_cells,
            dtype=MESH_INT_DTYPE,
        )

        # Re-copy for redability only
        nx_c = self.nx_c
        ny_c = self.ny_c
        nz_c = self.nz_c

        i, j, k = self.get_ijk(idx, nx_c, ny_c, nz_c)

        e_r = np.where((i == (nx_c - 1)), -1, idx + 1)
        e_l = np.where((i == 0), -1, idx - 1)

        if self.dim > 1:
            e_f = np.where((j == (ny_c - 1)), -1, idx + nx_c)
            e_b = np.where((j == 0), -1, idx - nx_c)

        if self.dim > 2:
            e_n = np.where((k == (nz_c - 1)), -1, idx + (nx_c) * (ny_c))
            e_s = np.where((k == 0), -1, idx - (nx_c) * (ny_c))

        if self.dim == 1:
            return np.column_stack((e_r, e_l)).flatten()
        elif self.dim == 2:
            return np.column_stack((e_r, e_l, e_f, e_b)).flatten()
        else:
            return np.column_stack((e_r, e_l, e_f, e_b, e_n, e_s)).flatten()

    def plot(self):
        fig = plt.figure()
        ax = fig.add_subplot(111, projection="3d")

        mrk_nodes = mlines.Line2D(
            [],
            [],
            color="red",
            marker="+",
            linestyle="None",
            markersize=10,
            label="Cell ID",
        )

        mrk_cells = mlines.Line2D(
            [],
            [],
            color="blue",
            marker="o",
            linestyle="None",
            markersize=10,
            label="Node ID",
        )

        if self.nx > 4 and self.ny > 4 and self.nz > 4:
            print("Error cant plot too many nodes")
            return

        id_edges = [[0, 1]]
        if self.dim > 1:
            id_edges += [
                [1, 2],
                [2, 3],
                [3, 0],
            ]
        if self.dim > 2:
            id_edges += [
                [4, 5],
                [5, 6],
                [6, 7],
                [7, 4],
                [0, 4],
                [1, 5],
                [2, 6],
                [3, 7],
            ]

        # Plot mesh nodes and associated index
        count = 0
        for k in range(self.nz + 1):
            for j in range(self.ny + 1):
                for i in range(self.nx + 1):
                    idx = self.get_idx(
                        i,
                        j,
                        k,
                        self.nx + 1,
                        self.ny + 1,
                        self.nz + 1,
                    )
                    ax.scatter(
                        self.points[idx][0],
                        self.points[idx][1],
                        self.points[idx][2],
                        marker="o",
                        color="blue",
                    )
                    ax.text(
                        self.points[idx][0],
                        self.points[idx][1],
                        self.points[idx][2],
                        f"{count}",
                        size=10,
                        zorder=2,
                        color="b",
                        horizontalalignment="left",
                        verticalalignment="bottom",
                    )
                    count += 1

        for k in range(self.nz_c):
            for j in range(self.ny_c):
                for i in range(self.nx_c):
                    idx = self.get_idx(
                        i,
                        j,
                        k,
                        self.nx_c,
                        self.ny_c,
                        self.nz_c,
                    )
                    n = self.cells[0][1][idx]

                    for id_edge in id_edges:
                        p1 = self.points[n[id_edge[0]]]
                        p2 = self.points[n[id_edge[1]]]

                        plt.plot(
                            [p1[0], p2[0]],
                            [p1[1], p2[1]],
                            [p1[2], p2[2]],
                            "ko-",
                            linewidth=1,
                        )

        # Plot mesh cells center and associated index
        count = 0
        for k in range(self.nz_c):
            for j in range(self.ny_c):
                for i in range(self.nx_c):
                    idx = self.get_idx(
                        i,
                        j,
                        k,
                        self.nx_c,
                        self.ny_c,
                        self.nz_c,
                    )
                    ax.scatter(
                        self.cells_center[idx][0],
                        self.cells_center[idx][1],
                        self.cells_center[idx][2],
                        marker="+",
                        color="red",
                        s=20,
                    )
                    ax.text(
                        self.cells_center[idx][0],
                        self.cells_center[idx][1],
                        self.cells_center[idx][2],
                        f"{count}",
                        size=10,
                        zorder=2,
                        color="r",
                        horizontalalignment="left",
                        verticalalignment="bottom",
                    )
                    count += 1

        ax.set_title("Mesh Plot")
        ax.set_xlabel("X-axis")
        ax.set_ylabel("Y-axis")
        ax.set_zlabel("Z-axis")
        plt.legend(handles=[mrk_nodes, mrk_cells])
        plt.show()
