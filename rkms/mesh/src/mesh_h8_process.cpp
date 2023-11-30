#undef NDEBUG
#include <assert.h>
#include <cmath>
#include <iostream>
#include <tuple>

#if defined(__USE_ABSL__)
#include <absl/container/flat_hash_map.h>
#else
#include <map>
#endif

#include "mesh_h8_process.h"

/* GMSH hexahedron loc_nodes_id:
 *
 *         y
 *  3----------2
 *  |\     ^   |\
 *  | \    |   | \
 *  |  \   |   |  \
 *  |   7------+---6
 *  |   |  +-- |-- | -> x
 *  0---+---\--1   |
 *   \  |    \  \  |       8
 *    \ |     \  \ |
 *     \|      z  \|
 *      4----------5
 */

#define H8_ELEM_CODE     5
#define H8_PHY_DIM       3
#define H8_FACE_PER_ELEM 6
#define H8_NODE_PER_ELEM 8
#define H8_NODE_PER_FACE 4
#define MESH_TOL         1e-6

typedef std::tuple<long, long, long, long> key4_t;

static const int h8_face_to_loc_node[H8_FACE_PER_ELEM][H8_NODE_PER_FACE] = {
    {1, 2, 6, 5}, // Right
    {0, 4, 7, 3}, // Left
    {2, 3, 7, 6}, // Front
    {1, 5, 4, 0}, // Back
    {4, 5, 6, 7}, // North
    {0, 3, 2, 1}, // South
};

static const double h8_face_normals[H8_FACE_PER_ELEM][3] = {
    { 1,  0,  0}, // Right
    {-1,  0,  0}, // Left
    { 0,  1,  0}, // Front
    { 0, -1,  0}, // Back
    { 0,  0,  1}, // North
    { 0,  0, -1}  // South
};

static const int h8_face_edge_len[H8_FACE_PER_ELEM][2] = {
    {2, 1}, // Right : dz, dy
    {2, 1}, // Left  : dz, dy
    {2, 0}, // Front : dz, dx
    {2, 0}, // Back  : dz, dx
    {0, 1}, // North : dx, dy
    {0, 1}, // South : dx, dy
};

static const int h8_lex_order[H8_NODE_PER_ELEM] = { 0, 4, 3, 7, 1, 5, 2, 6 };

static const int h8_opp_face[H8_FACE_PER_ELEM] = { 1, 0, 3, 2, 5, 4 };

/**
 * Prints an error message if the given condition is false.
 *
 * @param condition Boolean condition to check.
 * @param func_name Function name where the error occurred.
 * @param message Error message to display.
 *
 */
static void check_perror(bool condition, const std::string &func_name,
                         const std::string &message)
{
    if (!condition) {
        std::cerr << "[ERROR] - " << func_name << " - " << message << std::endl;
    }
}

/**
 * Computes a 3D vector from two nodes in a given set of nodes.
 *
 * @param nodes Array of node coordinates.
 * @param n0_idx Index of the first node in the `nodes` array.
 * @param n1_idx Index of the second node in the `nodes` array.
 * @param vec Array to store the computed vector.
 */
static inline void get_vector(const double nodes[H8_NODE_PER_ELEM * 3],
                              int n0_idx, int n1_idx, double vec[3])
{
    vec[0] = nodes[3 * n1_idx + 0] - nodes[3 * n0_idx + 0];
    vec[1] = nodes[3 * n1_idx + 1] - nodes[3 * n0_idx + 1];
    vec[2] = nodes[3 * n1_idx + 2] - nodes[3 * n0_idx + 2];
}

/**
 * Calculates the dot product of two 3D vectors.
 *
 * @param x Array containing the coordinates of the first vector.
 * @param y Array containing the coordinates of the second vector.
 * @return The dot product of the two vectors.
 */
static inline double dot_product(const double x[3], const double y[3])
{
    return x[0] * y[0] + x[1] * y[1] + x[2] * y[2];
}

/**
 * Calculates the Euclidean norm (magnitude) of a 3D vector.
 *
 * @param x Array containing the coordinates of the vector.
 * @return The Euclidean norm of the vector.
 */
static inline double norm(const double x[3])
{
    return sqrt(x[0] * x[0] + x[1] * x[1] + x[2] * x[2]);
}

/**
 * Calculates the cross product of two 3D vectors.
 *
 * @param x Array containing the coordinates of the first vector.
 * @param y Array containing the coordinates of the second vector.
 * @param res Array to store the resulting cross product.
 */
static inline void cross_product(const double x[3], const double y[3],
                                 double res[3])
{
    res[0] = x[1] * y[2] - x[2] * y[1];
    res[1] = x[2] * y[0] - x[0] * y[2];
    res[2] = x[0] * y[1] - x[1] * y[0];
}

/**
 * Lexicographically sorts the coordinates of the nodes and their corresponding
 * IDs in a H8 element.
 *
 * @param node_coords Array containing the coordinates of the nodes composing
 * the cell.
 * @param node_ids Array containing the IDs of the nodes composing the cell.
 */
static inline void h8_lexsort(double node_coords[H8_NODE_PER_ELEM * H8_PHY_DIM],
                              long node_ids[H8_NODE_PER_ELEM])
{
    // Macro to swap the coordinates and IDs of two nodes
#define SWAP_NODE(i, j)                                                        \
    const double tmp_x = node_coords[3 * i + 0];                               \
    const double tmp_y = node_coords[3 * i + 1];                               \
    const double tmp_z = node_coords[3 * i + 2];                               \
    node_coords[3 * i + 0] = node_coords[3 * j + 0];                           \
    node_coords[3 * i + 1] = node_coords[3 * j + 1];                           \
    node_coords[3 * i + 2] = node_coords[3 * j + 2];                           \
    node_coords[3 * j + 0] = tmp_x;                                            \
    node_coords[3 * j + 1] = tmp_y;                                            \
    node_coords[3 * j + 2] = tmp_z;                                            \
    const long tmp_int = node_ids[i];                                          \
    node_ids[i] = node_ids[j];                                                 \
    node_ids[j] = tmp_int;

    // Macro to reorder two nodes based on their coordinates
#define REORDER(i, j)                                                          \
    if (node_coords[3 * j + 0] < node_coords[3 * i + 0]) {                     \
        SWAP_NODE(i, j)                                                        \
    }                                                                          \
    if (fabs(node_coords[3 * j + 0] - node_coords[3 * i + 0]) < MESH_TOL &&    \
        node_coords[3 * j + 1] < node_coords[3 * i + 1]) {                     \
        SWAP_NODE(i, j)                                                        \
    }                                                                          \
    if (fabs(node_coords[3 * j + 0] - node_coords[3 * i + 0]) < MESH_TOL &&    \
        fabs(node_coords[3 * j + 1] - node_coords[3 * i + 1]) < MESH_TOL &&    \
        node_coords[3 * j + 2] < node_coords[3 * i + 2]) {                     \
        SWAP_NODE(i, j)                                                        \
    }

    // Bubble sort to lexicographically sort the nodes
    REORDER(0, 1);
    REORDER(1, 2);
    REORDER(2, 3);
    REORDER(3, 4);
    REORDER(4, 5);
    REORDER(5, 6);
    REORDER(6, 7);
    REORDER(0, 1);
    REORDER(1, 2);
    REORDER(2, 3);
    REORDER(3, 4);
    REORDER(4, 5);
    REORDER(5, 6);
    REORDER(0, 1);
    REORDER(1, 2);
    REORDER(2, 3);
    REORDER(3, 4);
    REORDER(4, 5);
    REORDER(0, 1);
    REORDER(1, 2);
    REORDER(2, 3);
    REORDER(3, 4);
    REORDER(0, 1);
    REORDER(1, 2);
    REORDER(2, 3);
    REORDER(0, 1);
    REORDER(1, 2);
    REORDER(0, 1);
#undef REORDER
#undef SWAP
}

/**
 * Checks the normals of the faces of a H8 cell
 *
 * @param node_coords Array containing the coordinates of the nodes composing
 * the cell.
 * @param sizes Array containing the size of the cell (dx, dy, dz).
 * @return True if all the computed normals satisfy the given tolerance; False
 * otherwise.
 *
 * @remarks This function checks the orthogonality between vectors formed by
 *          adjacent nodes of each hexahedral face. It also verifies the edge
 *          lengths and the direction of the computed normals for each face.
 */
static bool h8_check_normals(double node_coords[H8_NODE_PER_ELEM * H8_PHY_DIM],
                             const double sizes[H8_PHY_DIM])
{
    bool check = true;
    for (int id_face = 0; id_face < H8_FACE_PER_ELEM; id_face++) {
        long n0 = h8_face_to_loc_node[id_face][0];
        long n1 = h8_face_to_loc_node[id_face][1];
        long n2 = h8_face_to_loc_node[id_face][2];

        double e0[H8_PHY_DIM], e1[H8_PHY_DIM];
        // Compute vector from node (n0) to node (n1)
        get_vector(node_coords, n0, n1, e0);

        // Compute vector from node (n1) and node (n2)
        get_vector(node_coords, n1, n2, e1);

        // Check orthogonality between vectors composing the face
        const double e0_dot_e1 = dot_product(e0, e1);
        check = check && (fabs(e0_dot_e1) < MESH_TOL);

        // Check both edge lengths
        const double e0_ln = norm(e0);
        const double e1_ln = norm(e1);

        int edge_len_id = h8_face_edge_len[id_face][0];
        check = (check && (fabs(e0_ln - sizes[edge_len_id]) < MESH_TOL));

        edge_len_id = h8_face_edge_len[id_face][1];
        check = check && (fabs(e1_ln - sizes[edge_len_id]) < MESH_TOL);

        check_perror(check, "h8_check_normals",
                     "One or more edge have wrong length");

        assert(check);
        // Check normal direction to the face
        double n[H8_PHY_DIM];
        double a = (e0_ln * e1_ln);
        cross_product(e0, e1, n);

        const double n_ref[H8_PHY_DIM] = { h8_face_normals[id_face][0],
                                           h8_face_normals[id_face][1],
                                           h8_face_normals[id_face][2] };

        check = check && (fabs(n_ref[0] - n[0] / a) < MESH_TOL);
        check = check && (fabs(n_ref[1] - n[1] / a) < MESH_TOL);
        check = check && (fabs(n_ref[2] - n[2] / a) < MESH_TOL);

        check_perror(check, "h8_check_normals",
                     "One or more face have wrong normal vector orientation");
        assert(check);
    }

    return check;
}

/**
 * Extracts the size (dx, dy, dz) of the first cell in the cells array.
 *
 * @param nodes Array containing the full mesh node coordinates.
 * @param cells Array containing the full node IDs composing each cell of the
 * mesh.
 * @param sizes Array containing the found cell sizes (dx, dy, dz).
 */
void mesh_h8_extract_cell_size(const double *nodes, long *cells,
                               double sizes[3])
{
    // Step 1: Load the first cell's node IDs (H8_NODE_PER_ELEM first node IDs)
    long loc_cell_nodes_id[H8_NODE_PER_ELEM];
    for (int i = 0; i < H8_NODE_PER_ELEM; i++) {
        loc_cell_nodes_id[i] = cells[i];
    }

    // Step 2: Load the coordinates of the first cell's nodes
    double loc_nodes[H8_NODE_PER_ELEM * H8_PHY_DIM];
    for (int i = 0; i < H8_NODE_PER_ELEM; i++) {
        long id_node = loc_cell_nodes_id[i];
        for (int k = 0; k < H8_PHY_DIM; k++) {
            loc_nodes[H8_PHY_DIM * i + k] = nodes[H8_PHY_DIM * id_node + k];
        }
    }

    /**
	 * Note: The following steps are intended to address the issue of node ID
	 * order being disrupted in the cell. This problem can occur when a
	 * face/edge has an incorrect orientation in the geometry. While the mesh
	 * may appear visually satisfactory, it cannot be utilized for finite
	 * element methods. The re-ordering process corrects the orientation of
	 * erroneous faces/edges
	 */

    // Step 3: Re-order the node IDs of the first cell based on a lexical sort
    // of the coordinates
    h8_lexsort(loc_nodes, loc_cell_nodes_id);

    // Step 4: Re-order inplace from the lexical order to the proper H8 order
    for (int i = 0; i < H8_NODE_PER_ELEM; i++) {
        cells[h8_lex_order[i]] = loc_cell_nodes_id[i];
    }

    // Step 5: Reload cell node coordinates using the proper H8 order
    for (int i = 0; i < H8_NODE_PER_ELEM; i++) {
        long id_node = cells[i];
        for (int k = 0; k < H8_PHY_DIM; k++) {
            loc_nodes[H8_PHY_DIM * i + k] = nodes[H8_PHY_DIM * id_node + k];
        }
    }

    // Step 6: Compute the length of each H8 edge
    const int dx_edge[4][2] = {
        {0, 1},
        {3, 2},
        {4, 5},
        {7, 6}
    };
    const int dy_edge[4][2] = {
        {0, 3},
        {1, 2},
        {4, 7},
        {5, 6}
    };
    const int dz_edge[4][2] = {
        {0, 4},
        {1, 5},
        {3, 7},
        {2, 6}
    };

    double v[3], dx[4], dy[4], dz[4];

    // Computing length of each H8 edges
    for (int k = 0; k < 4; k++) {
        // Compute dx vector
        get_vector(loc_nodes, dx_edge[k][0], dx_edge[k][1], v);
        dx[k] = norm(v);

        // Compute dy vector
        get_vector(loc_nodes, dy_edge[k][0], dy_edge[k][1], v);
        dy[k] = norm(v);

        // Compute dz vector
        get_vector(loc_nodes, dz_edge[k][0], dz_edge[k][1], v);
        dz[k] = norm(v);
    }

    bool check = true;
    // Step 7: Compare the lengths of each H8 edge
    for (int k = 1; k < 4; k++) {
        check = check && (fabs(dx[k - 1] - dx[k]) < MESH_TOL);
        check = check && (fabs(dy[k - 1] - dy[k]) < MESH_TOL);
        check = check && (fabs(dz[k - 1] - dz[k]) < MESH_TOL);
    }

    check_perror(check, "mesh_h8_extract_cell_size",
                 "First cell is not cuboide");

    assert(check);

    // Step 8: Assign the sizes to the respective dimensions
    sizes[0] = dx[0];
    sizes[1] = dy[0];
    sizes[2] = dz[0];
}

/**
 * Process each H8 cells of the mesh by reordering nodes, computing cell
 * centers, and performing checks.
 *
 * @param nb_cells Number of cells in the mesh.
 * @param sizes Array containing the cell sizes (dx, dy).
 * @param nodes Array containing the full mesh node coordinates.
 * @param cells Array containing the full node IDs composing each cell of the
 * mesh.
 * @param cells_center The array to store the computed cell centers of all the
 * cells.
 */
void mesh_h8_process_cells(const long nb_cells, const double sizes[3],
                           const double *nodes, long *cells,
                           double *cells_center)
{
    long loc_cell_nodes_id[H8_NODE_PER_ELEM];
    double loc_nodes[H8_NODE_PER_ELEM * H8_PHY_DIM];

    for (long id_cell = 0; id_cell < nb_cells; id_cell++) {
        // Step 1: Load the cell's node IDs
        for (int i = 0; i < H8_NODE_PER_ELEM; i++) {
            loc_cell_nodes_id[i] = cells[H8_NODE_PER_ELEM * id_cell + i];
        }

        // Step 2: Load the coordinates of the cell's nodes
        for (int i = 0; i < H8_NODE_PER_ELEM; i++) {
            long id_node = loc_cell_nodes_id[i];
            for (int k = 0; k < H8_PHY_DIM; k++) {
                loc_nodes[H8_PHY_DIM * i + k] = nodes[H8_PHY_DIM * id_node + k];
            }
        }

        /**
		 * Note: The following steps are intended to address the issue of node
		 * ID order being disrupted in the cell. This problem can occur when a
		 * face/edge has an incorrect orientation in the geometry. While the
		 * mesh may appear visually satisfactory, it cannot be utilized for
		 * finite element methods. The re-ordering process corrects the
		 * orientation of erroneous faces/edges
		 */

        // Step 3: Re-order the node IDs of the cell based on a lexical sort of
        // the coordinates
        h8_lexsort(loc_nodes, loc_cell_nodes_id);

        // Step 4: Re-order inplance from the lexical order to the proper H8
        // order
        for (int i = 0; i < H8_NODE_PER_ELEM; i++) {
            cells[H8_NODE_PER_ELEM * id_cell + h8_lex_order[i]] =
                loc_cell_nodes_id[i];
        }

        // Step 4: Re-order inplace from the lexical order to the proper Q8
        // order Take advantage to compute sum for later cells centers
        // computation
        double sum_x = 0;
        double sum_y = 0;
        double sum_z = 0;

        for (int i = 0; i < H8_NODE_PER_ELEM; i++) {
            long id_node = cells[H8_NODE_PER_ELEM * id_cell + i];
            for (int k = 0; k < H8_PHY_DIM; k++) {
                loc_nodes[H8_PHY_DIM * i + k] = nodes[H8_PHY_DIM * id_node + k];
            }
            sum_x += loc_nodes[H8_PHY_DIM * i + 0];
            sum_y += loc_nodes[H8_PHY_DIM * i + 1];
            sum_z += loc_nodes[H8_PHY_DIM * i + 2];
        }

        // Step 5: Check the current H8 cell
        bool check = h8_check_normals(loc_nodes, sizes);

        check_perror(check, "mesh_h8_process_cells",
                     "H8 cell control checking failed");

        assert(check);

        // Setp 6: Compute cell's center coordinates using true hexahedron
        // formula
        const double center_1[3] = { sum_x / 8, sum_y / 8, sum_z / 8 };

        // Step 7: Compute cell's centers coordinates using displacement from
        // first cell's node
        const double center_2[3] = { loc_nodes[0] + 0.5 * sizes[0],
                                     loc_nodes[1] + 0.5 * sizes[1],
                                     loc_nodes[2] + 0.5 * sizes[2] };

        // Step 8: Verify that both values are same
        check = check && (fabs(center_1[0] - center_2[0]) < MESH_TOL);
        check = check && (fabs(center_1[1] - center_2[1]) < MESH_TOL);
        check = check && (fabs(center_1[2] - center_2[2]) < MESH_TOL);

        check_perror(check, "mesh_h8_process_cells",
                     "H8 cell center checking failed");

        assert(check);

        // Step 9: Assign cell center coordinates
        cells_center[H8_PHY_DIM * id_cell + 0] = center_1[0];
        cells_center[H8_PHY_DIM * id_cell + 1] = center_1[1];
        cells_center[H8_PHY_DIM * id_cell + 2] = center_1[2];
    }
}

/**
 * Processes the nodes of each H8 cells by rounding their coordinates based on
 * the given cell size.
 *
 * @param nb_nodes Number of nodes in the mesh.
 * @param sizes Array containing the cell sizes (dx, dy, dz).
 * @param nodes Array containing the full mesh node coordinates.
 *
 * @remarks This function modifies the coordinates of the nodes in-place. The
 *          node coordinates are rounded to the nearest multiple of half the
 *          corresponding cell size. Assertion checks are performed to verify
 *          the accuracy of the rounding operation.
 *
 * @note The `nodes` array is assumed to have a layout where each node's
 *       coordinates are stored consecutively in memory. The stride between
 *       consecutive coordinates for a single node is given by `H8_PHY_DIM`. The
 *       coordinates for the i-th node can be accessed as follows:
 *       `nodes[H8_PHY_DIM * i + j]`, where `j` is the coordinate index (0, 1,
 *       2).
 */
void mesh_h8_process_nodes(const long nb_nodes, const double sizes[3],
                           double *nodes)
{
    // Calculate half cell sizes
    const double half_dx = 0.5 * sizes[0];
    const double half_dy = 0.5 * sizes[1];
    const double half_dz = 0.5 * sizes[2];

    // Process each node
    double old_coord[H8_PHY_DIM];
    bool check = true;

    for (long id_node = 0; id_node < nb_nodes; id_node++) {
        // Store the original coordinates
        old_coord[0] = nodes[H8_PHY_DIM * id_node + 0];
        old_coord[1] = nodes[H8_PHY_DIM * id_node + 1];
        old_coord[2] = nodes[H8_PHY_DIM * id_node + 2];

        // Round the x, y and z coordinates
        const double x =
            rint(nodes[H8_PHY_DIM * id_node + 0] / half_dx) * half_dx;
        const double y =
            rint(nodes[H8_PHY_DIM * id_node + 1] / half_dy) * half_dy;
        const double z =
            rint(nodes[H8_PHY_DIM * id_node + 2] / half_dz) * half_dz;

        // Update the node coordinates
        nodes[H8_PHY_DIM * id_node + 0] = x;
        nodes[H8_PHY_DIM * id_node + 1] = y;
        nodes[H8_PHY_DIM * id_node + 2] = z;

        // Verify the accuracy of the rounding operation for x y and z
        // coordinates
        check = check && (fabs(old_coord[0] - nodes[H8_PHY_DIM * id_node + 0]) <
                          MESH_TOL);
        check = check && (fabs(old_coord[1] - nodes[H8_PHY_DIM * id_node + 1]) <
                          MESH_TOL);
        check = check && (fabs(old_coord[2] - nodes[H8_PHY_DIM * id_node + 2]) <
                          MESH_TOL);

        check_perror(check, "mesh_h8_process_nodes",
                     "H8 nodes position checking failed");

        assert(check);
    }
}

/**
 * Builds the element-to-element connectivity for a H8 mesh.
 *
 * This function constructs the element-to-element connectivity for a
 * quadrilateral mesh. It uses a hashmap to store the faces of each cell and
 * their corresponding neighboring cell. The connectivity is computed based on
 * the node IDs of the faces in the mesh.
 *
 * @param nb_cells Number of cells in the mesh.
 * @param cells Array containing the full node IDs composing each cell of the
 * mesh.
 * @param elem2elem Array to store the computed element-to-element
 * connectivity.
 */
void mesh_h8_build_elem2elem(const long nb_cells, const long *cells,
                             long *elem2elem)
{
    // Hashmap container : key is a tuple of 4 long and the value is 1 long
    key4_t key;
#if defined(__USE_ABSL__)
    absl::flat_hash_map<key4_t, long> face_map;
    face_map.reserve(nb_cells);
#else
    std::map<key4_t, long> face_map;
#endif

    // Build the map using direct face orientation (node ID)
    for (long id_elem = 0; id_elem < nb_cells; id_elem++) {
        // std::cout << id_elem << std::endl;
        long offset = id_elem * H8_NODE_PER_ELEM;
        for (int id_face = 0; id_face < H8_FACE_PER_ELEM; id_face++) {
            // Get the node IDs of the face in direct orientation
            key = std::make_tuple(
                cells[offset + h8_face_to_loc_node[id_face][0]],
                cells[offset + h8_face_to_loc_node[id_face][1]],
                cells[offset + h8_face_to_loc_node[id_face][2]],
                cells[offset + h8_face_to_loc_node[id_face][3]]);
#if defined(__USE_ABSL__)
            auto res = face_map.try_emplace(key, id_elem);
#else
            auto res = face_map.emplace(key, id_elem);
#endif
            if (!(res.second)) {
                std::cout << "[WARNING]"
                          << " - mesh_h8_build_elem2elem"
                          << " - One or more cell are duplicated." << std::endl;
            }
        }
    }
    // Search corresponding faces using reverse face orientation (node ID)

    for (long id_elem = 0; id_elem < nb_cells; id_elem++) {
        long offset = id_elem * H8_NODE_PER_ELEM;
        for (int id_face = 0; id_face < H8_FACE_PER_ELEM; id_face++) {
            // Get the node IDs of the face in reverse orientation
            // (The permutation of H8 face swaps the 2nd and the last element)
            key = std::make_tuple(
                cells[offset + h8_face_to_loc_node[id_face][0]],
                cells[offset + h8_face_to_loc_node[id_face][3]],
                cells[offset + h8_face_to_loc_node[id_face][2]],
                cells[offset + h8_face_to_loc_node[id_face][1]]);

            auto res = face_map.find(key);

            if (res != face_map.end()) {
                // Store the neighboring element ID for the current face
                elem2elem[id_elem * H8_FACE_PER_ELEM + id_face] = res->second;
            }
        }
    }
    face_map.clear();
}

/**
 * Checks the correctness of the `elem2elem` array for H4 elements.
 *
 * @param nb_cells umber of cells in the mesh.
 * @param elem2elem Array representing the connectivity information between
 * elements.
 *
 * @remarks The `elem2elem` array stores the indices of the neighboring elements
 *          for each element in a mesh. Each element has H8_FACE_PER_ELEM
 *          neighbors, and the neighbors are organized in pairs. This function
 *          verifies that the neighbor of the neighbor is the element itself.
 *
 * @note The `elem2elem` array is assumed to have a layout where the neighbors
 *       of each element are stored consecutively in memory. The stride between
 *       consecutive neighbors for a single element is given by
 *       `H8_FACE_PER_ELEM`. The neighbors for the i-th element can be accessed
 *       as follows: `elem2elem[i * H8_FACE_PER_ELEM + j]`, where `j` is the
 *       neighbor index (0, 1, 2, ..., H8_FACE_PER_ELEM - 1). The value -1 is
 *       used to indicate a boundary face (no neighbor).
 */
void mesh_h8_check_elem2elem(const long nb_cells, const long *elem2elem)
{
    for (long id_elem = 0; id_elem < nb_cells; id_elem++) {
        for (int id_couple = 0; id_couple < H8_FACE_PER_ELEM / 2; id_couple++) {
            long e0 = elem2elem[id_elem * H8_FACE_PER_ELEM + 2 * id_couple + 0];

            // Skip boundary faces
            if (e0 != -1) {
                long e1 = elem2elem[e0 * H8_FACE_PER_ELEM + 2 * id_couple + 1];

                bool check = (id_elem == e1);
                check_perror(check, "mesh_h8_check_elem2elem",
                             "elem2elem connectivy is not valid");

                assert(check);
            }
        }
    }
}

/**
 * Build periodic mesh connectivity for H8 elements.
 *
 * This function assumes that the element connectivity (through faces) is
 * already built in the 'elem2elem' array. It modifies 'elem2elem' to ensure
 * periodic connectivity across boundary faces of the mesh.
 *
 * @param nb_cells Number of H8 elements in the mesh.
 * @param elem2elem Connectivity array representing adjacent elements.
 *                  It is modified to include periodic connectivity.
 */
void mesh_h8_build_periodic_mesh(const long nb_cells, long *elem2elem)
{
    for (long id_e = 0; id_e < nb_cells; id_e++) {
        for (int id_f = 0; id_f < H8_FACE_PER_ELEM; id_f++) {
            // On a boundary face
            if (elem2elem[id_e * H8_FACE_PER_ELEM + id_f] == -1) {
                // Find opposite face id
                long id_fo = h8_opp_face[id_f];
                long id_n = id_e;
                bool found = false;
                for (long k = 0; k < nb_cells; k++) {
                    // Next neighbour elem (through id_fo) is a boudary face
                    if (elem2elem[id_n * H8_FACE_PER_ELEM + id_fo] == -1) {
                        elem2elem[id_e * H8_FACE_PER_ELEM + id_f] = id_n;
                        elem2elem[id_n * H8_FACE_PER_ELEM + id_fo] = id_e;
                        found = true;
                        break;
                    }
                    // Jump on the next neighbour elem (through id_fo)
                    id_n = elem2elem[id_n * H8_FACE_PER_ELEM + id_fo];
                }
                check_perror(found, "mesh_h8_build_periodic_mesh",
                             "periodic matching element not found!");
                assert(found);
            }
        }
    }
}
