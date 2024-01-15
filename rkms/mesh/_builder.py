import numpy as np
import matplotlib.pyplot as plt
import meshio


class MeshBuilder:
    def __init__(
        self,
        nx,
        ny,
        nz,
        xmin=0.0,
        xmax=1.0,
        ymin=0.0,
        ymax=1.0,
        zmin=0.0,
        zmax=1,
        dtype=np.float64,
    ):
        self.dtype = dtype

        self.nx = np.int64(max(nx, 0))
        self.ny = np.int64(max(ny, 0))
        self.nz = np.int64(max(nz, 0))

        self.xmin = self.dtype(xmin)
        self.xmax = self.dtype(xmax)

        self.ymin = self.dtype(ymin)
        self.ymax = self.dtype(ymax)

        self.zmin = self.dtype(zmin)
        self.zmax = self.dtype(zmax)

        if self.nx == 0:
            self.dx = dtype(0.0)
            self.nx_c = 1
        else:
            self.nx_c = self.nx
            self.dx = abs(self.xmax - self.xmin) / self.nx

        if self.ny == 0:
            self.dy = dtype(0.0)
            self.ny_c = 1
        else:
            self.ny_c = self.ny
            self.dy = abs(self.ymax - self.ymin) / self.ny

        if self.nz == 0:
            self.dz = dtype(0.0)
            self.nz_c = 1
        else:
            self.nz_c = self.nz
            self.dz = abs(self.zmax - self.zmin) / self.nz

        self.nodes = self.build_nodes()
        self.cells_center = self.build_cells_center()
        self.cells = self.build_cells()

    def build_nodes(self):
        x, y, z = np.meshgrid(
            np.linspace(
                self.zmin,
                self.zmax,
                self.nz + 1,
                dtype=self.dtype,
            ),
            np.linspace(
                self.ymin,
                self.ymax,
                self.ny + 1,
                dtype=self.dtype,
            ),
            np.linspace(
                self.xmin,
                self.xmax,
                self.nx + 1,
                dtype=self.dtype,
            ),
            indexing="ij",
        )

        return np.column_stack((z.flatten(), y.flatten(), x.flatten()))

    def build_cells_center(self):
        x, y, z = np.meshgrid(
            np.linspace(
                self.zmin + 0.5 * self.dz,
                self.zmax - 0.5 * self.dz,
                self.nz_c,
                dtype=self.dtype,
            ),
            np.linspace(
                self.ymin + 0.5 * self.dy,
                self.ymax - 0.5 * self.dy,
                self.ny_c,
                dtype=self.dtype,
            ),
            np.linspace(
                self.xmin + 0.5 * self.dx,
                self.xmax - 0.5 * self.dx,
                self.nx_c,
                dtype=self.dtype,
            ),
            indexing="ij",
        )

        return np.column_stack((z.flatten(), y.flatten(), x.flatten()))

    def build_cells(self):
        idx = np.arange(
            self.nx_c * self.ny_c * self.nz_c,
            dtype=np.int64,
        )

        i = idx // (self.ny_c * self.nz_c)
        j = (idx // self.nz_c) % self.ny_c
        k = idx % self.nz_c

        # Extract nodes indexes
        if self.nz == 0:
            t0 = 0
        else:
            t0 = k % self.nz

        n0 = t0 + i * (self.ny + 1) * (self.nz + 1) + j * (self.nz + 1)
        n1 = n0 + 1
        n2 = n1 + (self.nx + 1)
        n3 = n2 - 1

        if self.nx * self.ny * self.nz > 0:
            n4 = n0 + (self.nx + 1) * (self.ny + 1)
            n5 = n4 + 1
            n6 = n5 + (self.nx + 1)
            n7 = n6 - 1
            return [("hexahedron", np.column_stack((n0, n1, n2, n3, n4, n5, n6, n7)))]
        else:
            return [("quad", np.column_stack((n0, n1, n2, n3)))]

    def build_elem2elem_2(self):
        idx = np.arange(
            self.nx_c * self.ny_c * self.nz_c,
            dtype=np.int64,
        )

        k, j, i = np.unravel_index(idx, (self.nz_c, self.ny_c, self.nx_c))

        e_r = idx + 1
        e_r[i == (self.nx_c - 1)] = -1

        e_l = idx - 1
        e_l[i == 0] = -1

        e_f = idx + self.nx_c
        e_f[j == (self.ny_c - 1)] = -1

        e_b = idx - self.nx_c
        e_b[j == 0] = -1

        e_n = idx + (self.nx_c) * (self.ny_c)
        e_n[k == (self.nz_c - 1)] = -1

        e_s = idx - (self.nx_c) * (self.ny_c)
        e_s[k == 0] = -1

        return np.column_stack((e_r, e_l, e_f, e_b, e_n, e_s))

    def build_elem2elem(self):
        idx = np.arange(
            self.nx_c * self.ny_c * self.nz_c,
            dtype=np.int64,
        )

        k = idx // (self.nx_c * self.ny_c)
        j = (idx // self.nx_c) % self.ny_c
        i = idx % self.nx_c

        e_r = np.where((i == (self.nx_c - 1)), -1, idx + 1)
        e_l = np.where((i == 0), -1, idx - 1)
        e_f = np.where((j == (self.ny_c - 1)), -1, idx + self.nx_c)
        e_b = np.where((j == 0), -1, idx - self.nx_c)
        e_n = np.where((k == (self.nz_c - 1)), -1, idx + (self.nx_c) * (self.ny_c))
        e_s = np.where((k == 0), -1, idx - (self.nx_c) * (self.ny_c))

        return np.column_stack((e_r, e_l, e_f, e_b, e_n, e_s))

    def get_idx(self, i, j, k, nx, ny, nz):
        return i + j * (nx) + k * (nx) * (ny)

    def get_ijk(self, idx, nx, ny, nz):
        k = idx // (nx * ny)
        j = (idx // nx) % ny
        i = idx % nx
        return i, j, k

    def plot(self):
        fig = plt.figure()
        ax = fig.add_subplot(111, projection="3d")

        if self.nx > 4 and self.ny > 4 and self.nz > 4:
            print("Error cant plot too many nodes")
            return

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
                    xyz = self.nodes[idx]
                    ax.scatter(
                        xyz[0],
                        xyz[1],
                        xyz[2],
                        marker="o",
                        color="blue",
                    )
                    ax.text(
                        xyz[0],
                        xyz[1],
                        xyz[2],
                        f"{count}",
                        size=10,
                        zorder=2,
                        color="b",
                    )
                    count += 1

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
                    xyz = self.cells_center[idx]
                    ax.scatter(
                        xyz[0],
                        xyz[1],
                        xyz[2],
                        marker="x",
                        color="red",
                    )
                    ax.text(
                        xyz[0],
                        xyz[1],
                        xyz[2],
                        f"{count}",
                        size=10,
                        zorder=2,
                        color="r",
                    )
                    count += 1

        ax.set_title("Mesh Plot")
        ax.set_xlabel("X-axis")
        ax.set_ylabel("Y-axis")
        ax.set_zlabel("Z-axis")
        plt.show()

    def test_loop_1(self):
        nodes = np.zeros((self.nx + 1, self.ny + 1, self.nz + 1), dtype=object)

        for k in range(self.nz + 1):
            for j in range(self.ny + 1):
                for i in range(self.nx + 1):
                    nodes[k][j][i] = (i * self.dx, j * self.dy, k * self.dz)
        return nodes


m = MeshBuilder(256, 256, 256)

# p = m.test_loop_1()
# print(p[2][2][2])

# print(m.nodes)
# print(m.cells_center)
# print(m.cells)
# m.plot()
# tt = m.build_elem2elem()
# print(tt)
tt = m.build_elem2elem_2()
# print(tt)
# mesh = meshio.Mesh(m.nodes, m.cells)
# # mesh.write("foo.msh", binary=False, file_format="gmsh22")
# mesh.write("foo.vtk")

exit()


dx = abs(xmax - xmin) / nx
dy = abs(ymax - ymin) / ny
dz = abs(zmax - zmin) / nz

for k in range(nz + 1):
    for j in range(ny + 1):
        for i in range(nx + 1):
            idx = i + j * (nx + 1) + k * (ny + 1) * (ny + 1)

            x = i * dx
            y = j * dy
            z = k * dz

            print(idx, x, y, z)
