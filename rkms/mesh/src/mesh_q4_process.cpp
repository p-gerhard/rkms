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

#include "mesh_q4_process.h"

/* GMSH quadrangle (Q4) loc_nodes_id:
 *
 *       v
 *       ^
 *       |
 * 3-----------2
 * |     |     |
 * |     |     |
 * |     +---- | --> u
 * |           |
 * |           |
 * 0-----------1
 */
#define Q4_ELEM_CODE     3
#define Q4_PHY_DIM       2
#define Q4_FACE_PER_ELEM 4
#define Q4_NODE_PER_ELEM 4
#define Q4_NODE_PER_FACE 2
#define MESH_TOL         1e-6

typedef std::tuple<long, long> key2_t;

static const int q4_face_to_loc_node[Q4_FACE_PER_ELEM][Q4_NODE_PER_FACE] = {
    {1, 2}, // Right
    {3, 0}, // Left
    {2, 3}, // North
    {0, 1}, // South
};

static const float q4_face_normals[Q4_FACE_PER_ELEM][2] = {
    { 1,  0}, // Right
    {-1,  0}, // Left
    { 0,  1}, // North
    { 0, -1}, // South
};

static const int q4_face_edge_len[Q4_FACE_PER_ELEM] = { 1, 0, 1,
                                                        0 }; // dy, dx, dy, dx

static const unsigned int q4_lex_order[Q4_NODE_PER_ELEM] = { 0, 3, 1, 2 };

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
 * Computes a 2D vector from two nodes in a given set of nodes.
 *
 * @param nodes Array of node coordinates.
 * @param n0_idx Index of the first node in the `nodes` array.
 * @param n1_idx Index of the second node in the `nodes` array.
 * @param vec Array to store the computed vector.
 */
static inline void get_vector(const float nodes[Q4_NODE_PER_ELEM * 2],
                              int n0_idx, int n1_idx, float vec[2])
{
    vec[0] = nodes[2 * n1_idx + 0] - nodes[2 * n0_idx + 0];
    vec[1] = nodes[2 * n1_idx + 1] - nodes[2 * n0_idx + 1];
}

/**
 * Calculates the dot product of two 2D vectors.
 *
 * @param x Array containing the coordinates of the first vector.
 * @param y Array containing the coordinates of the second vector.
 * @return The dot product of the two vectors.
 */
static inline float dot_product(const float x[2], const float y[2])
{
    return x[0] * y[0] + x[1] * y[1];
}

/**
 * Calculates the Euclidean norm (magnitude) of a 2D vector.
 *
 * @param x Array containing the coordinates of the vector.
 * @return The Euclidean norm of the vector.
 */
static inline float norm(const float x[2])
{
    return sqrt(x[0] * x[0] + x[1] * x[1]);
}

/**
 * Calculates the cross product of two 2D vectors.
 *
 * @param x Array containing the coordinates of the first vector.
 * @param y Array containing the coordinates of the second vector.
 * @param res Array to store the resulting cross product.
 */
static inline void cross_product(const float x[2], const float y[2],
                                 float res[2])
{
    res[0] = x[1] * y[2] - x[2] * y[1];
    res[1] = x[2] * y[0] - x[0] * y[2];
}

/**
 * Lexicographically sorts the coordinates of the nodes and their corresponding
 * IDs in a Q4 element.
 *
 * @param node_coords Array containing the coordinates of the nodes composing
 * the cell.
 * @param node_ids Array containing the IDs of the nodes composing the cell.
 */
static inline void q4_lexsort(float node_coords[Q4_NODE_PER_ELEM * Q4_PHY_DIM],
                              long node_ids[Q4_NODE_PER_ELEM])
{
    // Macro to swap the coordinates and IDs of two nodes
#define SWAP_NODE(i, j)                                                        \
    const float tmp_x = node_coords[2 * i + 0];                                \
    const float tmp_y = node_coords[2 * i + 1];                                \
    node_coords[2 * i + 0] = node_coords[2 * j + 0];                           \
    node_coords[2 * i + 1] = node_coords[2 * j + 1];                           \
    node_coords[2 * j + 0] = tmp_x;                                            \
    node_coords[2 * j + 1] = tmp_y;                                            \
    const long tmp_int = node_ids[i];                                          \
    node_ids[i] = node_ids[j];                                                 \
    node_ids[j] = tmp_int;

    // Macro to reorder two nodes based on their coordinates
#define REORDER(i, j)                                                          \
    if (node_coords[2 * j + 0] < node_coords[2 * i + 0]) {                     \
        SWAP_NODE(i, j)                                                        \
    }                                                                          \
    if (fabs(node_coords[2 * j + 0] - node_coords[2 * i + 0]) < MESH_TOL &&    \
        node_coords[2 * j + 1] < node_coords[2 * i + 1]) {                     \
        SWAP_NODE(i, j)                                                        \
    }

    // Bubble sort to lexicographically sort the nodes
    REORDER(0, 1);
    REORDER(2, 3);
    REORDER(0, 2);
    REORDER(1, 3);
    REORDER(1, 2);
#undef REORDER
#undef SWAP
}

/**
 * Checks the normals of the edge of a Q4 cell
 *
 * @param node_coords Array containing the coordinates of the nodes composing
 * the cell.
 * @param sizes Array containing the size of the cell (dx, dy).
 * 
 * @remarks This function verifies the edge length and the direction of the
 * computed normals for each face.
 */
static void q4_check_normals(float node_coords[Q4_NODE_PER_ELEM * Q4_PHY_DIM],
                             const float sizes[Q4_PHY_DIM])
{
    bool check = true;
    for (int id_face = 0; id_face < Q4_FACE_PER_ELEM; id_face++) {
        long n0 = q4_face_to_loc_node[id_face][0];
        long n1 = q4_face_to_loc_node[id_face][1];

        float e0[Q4_PHY_DIM];
        // Compute vector from node (n0) to node (n1)
        get_vector(node_coords, n0, n1, e0);

        // Check both edge lengths
        const float e0_ln = norm(e0);

        int edge_len_id = q4_face_edge_len[id_face];
        check = (check && (fabs(e0_ln - sizes[edge_len_id]) < MESH_TOL));

        check_perror(check, "q4_check_normals",
                     "One or more edge have wrong length");

        assert(check);

        // Check normal direction to the edge
        float n[Q4_PHY_DIM] = { e0[1], -e0[0] };

        const float n_ref[Q4_PHY_DIM] = {
            q4_face_normals[id_face][0],
            q4_face_normals[id_face][1],
        };

        check = check && (fabs(n_ref[0] - n[0] / e0_ln) < MESH_TOL);
        check = check && (fabs(n_ref[1] - n[1] / e0_ln) < MESH_TOL);

        check_perror(check, "q8_check_normals",
                     "One or more face have wrong normal vector orientation");
        assert(check);
    }
}

/**
 * Extracts the size (dx, dy, dz) of the first cell in the cells array.
 *
 * @param nodes Array containing the full mesh node coordinates.
 * @param cells Array containing the full node IDs composing each cell of the
 * mesh.
 * @param sizes Array containing the found cell sizes (dx, dy).
 */
void mesh_q4_extract_cell_size(const float *nodes, long *cells, float sizes[2])
{
    // Step 1: Load the first cell's node IDs (Q4_NODE_PER_ELEM first node IDs)
    long loc_cell_nodes_id[Q4_NODE_PER_ELEM];
    for (int i = 0; i < Q4_NODE_PER_ELEM; i++) {
        loc_cell_nodes_id[i] = cells[i];
    }

    // Step 2: Load the coordinates of the first cell's nodes
    float loc_nodes[Q4_NODE_PER_ELEM * 2];
    for (int i = 0; i < Q4_NODE_PER_ELEM; i++) {
        long id_node = loc_cell_nodes_id[i];
        for (int k = 0; k < Q4_PHY_DIM; k++) {
            loc_nodes[Q4_PHY_DIM * i + k] = nodes[Q4_PHY_DIM * id_node + k];
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
    q4_lexsort(loc_nodes, loc_cell_nodes_id);

    // Step 4: Re-order from the lexical order to the proper Q4 order
    for (int i = 0; i < Q4_NODE_PER_ELEM; i++) {
        cells[q4_lex_order[i]] = loc_cell_nodes_id[i];
    }

    // Step 5: Reload cell node coordinates using the proper Q4 order
    for (int i = 0; i < Q4_NODE_PER_ELEM; i++) {
        long id_node = cells[i];
        for (int k = 0; k < Q4_PHY_DIM; k++) {
            loc_nodes[Q4_PHY_DIM * i + k] = nodes[Q4_PHY_DIM * id_node + k];
        }
    }

    // Step 6: Compute the length of each Q4 edge
    const int dx_edge[2][2] = {
        {0, 1},
        {3, 2}
    };
    const int dy_edge[2][2] = {
        {0, 3},
        {1, 2}
    };

    float v[2], dx[2], dy[2];
    for (int k = 0; k < 2; k++) {
        // Compute dx vector
        get_vector(loc_nodes, dx_edge[k][0], dx_edge[k][1], v);
        dx[k] = norm(v);

        // Compute dy vector
        get_vector(loc_nodes, dy_edge[k][0], dy_edge[k][1], v);
        dy[k] = norm(v);
    }

    bool check = true;
    // Step 7: Compare the lengths of each Q4 edge
    for (int k = 1; k < 2; k++) {
        check = check && (fabs(dx[k - 1] - dx[k]) < MESH_TOL);
        check = check && (fabs(dy[k - 1] - dy[k]) < MESH_TOL);
    }

    check_perror(check, "mesh_q4_extract_cell_size",
                 "First cell is not rectangle");

    assert(check);

    // Step 8: Assign the sizes to the respective dimensions
    sizes[0] = dx[0];
    sizes[1] = dy[0];
}

/**
 * Process each Q4 cells of the mesh by reordering nodes, computing cell
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
void mesh_q4_process_cells(const long nb_cells, const float sizes[2],
                           const float *nodes, long *cells, float *cells_center)
{
    long loc_cell_nodes_id[Q4_NODE_PER_ELEM];
    float loc_nodes[Q4_NODE_PER_ELEM * Q4_PHY_DIM];

    bool check = true;
    for (long id_cell = 0; id_cell < nb_cells; id_cell++) {
        // Step 1: Load the cell's node IDs
        for (int i = 0; i < Q4_NODE_PER_ELEM; i++) {
            loc_cell_nodes_id[i] = cells[Q4_NODE_PER_ELEM * id_cell + i];
        }

        // Step 2: Load the coordinates of the cell's nodes
        for (int i = 0; i < Q4_NODE_PER_ELEM; i++) {
            long id_node = loc_cell_nodes_id[i];
            for (int k = 0; k < Q4_PHY_DIM; k++) {
                loc_nodes[Q4_PHY_DIM * i + k] = nodes[Q4_PHY_DIM * id_node + k];
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
        q4_lexsort(loc_nodes, loc_cell_nodes_id);

        // Step 4: Re-order inplance from the lexical order to the proper Q4
        // order
        for (int i = 0; i < Q4_NODE_PER_ELEM; i++) {
            cells[Q4_NODE_PER_ELEM * id_cell + q4_lex_order[i]] =
                loc_cell_nodes_id[i];
        }

        // Step 4: Re-order inplace from the lexical order to the proper Q8
        // order Take advantage to compute sum for later cells centers
        // computation
        float sum_x = 0.f;
        float sum_y = 0.f;

        for (int i = 0; i < Q4_NODE_PER_ELEM; i++) {
            long id_node = cells[Q4_NODE_PER_ELEM * id_cell + i];
            for (int k = 0; k < Q4_PHY_DIM; k++) {
                loc_nodes[Q4_PHY_DIM * i + k] = nodes[Q4_PHY_DIM * id_node + k];
            }
            sum_x += loc_nodes[Q4_PHY_DIM * i + 0];
            sum_y += loc_nodes[Q4_PHY_DIM * i + 1];
        }

        // Step 5: Check the current Q4 cell
        q4_check_normals(loc_nodes, sizes);

        check_perror(check, "mesh_q4_process_cells",
                     "Q4 cell control checking failed");

        assert(check);

        // Setp 6: Compute cell's center coordinates using true rectangle
        // formula
        const float center_1[2] = { sum_x / 4.f, sum_y / 4.f };

        // Step 7: Compute cell's centers coordinates using displacement from
        // first cell's node
        const float center_2[2] = { loc_nodes[0] + 0.5f * sizes[0],
                                    loc_nodes[1] + 0.5f * sizes[1] };

        // Step 8: Verify that both values are same
        check = check && (fabs(center_1[0] - center_2[0]) < MESH_TOL);
        check = check && (fabs(center_1[1] - center_2[1]) < MESH_TOL);

        check_perror(check, "mesh_q4_process_cells",
                     "Q4 cell center checking failed");

        assert(check);

        // Step 9: Assign cell center coordinates
        cells_center[Q4_PHY_DIM * id_cell + 0] = center_1[0];
        cells_center[Q4_PHY_DIM * id_cell + 1] = center_1[1];
    }
}

/**
 * Processes the nodes of an Q4 mesh by rounding their coordinates based on the
 * given cell size.
 *
 * @param nb_nodes The number of nodes in the mesh.
 * @param sizes Array containing the cell sizes (dx, dy).
 * @param nodes Array containing the full mesh node coordinates.
 *
 * @remarks This function modifies the coordinates of the nodes in-place. The
 *          node coordinates are rounded to the nearest multiple of half the
 *          corresponding cell size. Assertion checks are performed to verify
 *          the accuracy of the rounding operation.
 *
 * @note The `nodes` array is assumed to have a layout where each node's
 *       coordinates are stored consecutively in memory. The stride between
 *       consecutive coordinates for a single node is given by `Q4_PHY_DIM`. The
 *       coordinates for the i-th node can be accessed as follows:
 *       `nodes[Q4_PHY_DIM * i + j]`, where `j` is the coordinate index (0, 1).
 */
void mesh_q4_process_nodes(const long nb_nodes, const float sizes[Q4_PHY_DIM],
                           float *nodes)
{
    // Calculate half cell sizes
    const float half_dx = 0.5f * sizes[0];
    const float half_dy = 0.5f * sizes[1];

    // Process each node
    float old_coord[Q4_PHY_DIM];
    bool check = true;
    for (long id_node = 0; id_node < nb_nodes; id_node++) {
        // Store the original coordinates
        old_coord[0] = nodes[Q4_PHY_DIM * id_node + 0];
        old_coord[1] = nodes[Q4_PHY_DIM * id_node + 1];

        // Round the x, y and z coordinates
        const float x =
            rint(nodes[Q4_PHY_DIM * id_node + 0] / half_dx) * half_dx;
        const float y =
            rint(nodes[Q4_PHY_DIM * id_node + 1] / half_dy) * half_dy;

        // Update the node coordinates
        nodes[Q4_PHY_DIM * id_node + 0] = x;
        nodes[Q4_PHY_DIM * id_node + 1] = y;

        // Verify the accuracy of the rounding operation for x and y coordinates
        check = check && (fabs(old_coord[0] - nodes[Q4_PHY_DIM * id_node + 0]) <
                          MESH_TOL);
        check = check && (fabs(old_coord[1] - nodes[Q4_PHY_DIM * id_node + 1]) <
                          MESH_TOL);

        check_perror(check, "mesh_q4_process_nodes",
                     "Q4 nodes position checking failed");
        assert(check);
    }
}

/**
 * Builds the element-to-element connectivity for a Q4 mesh.
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
void mesh_q4_build_elem2elem(const long nb_cells, const long *cells,
                             long *elem2elem)
{
    // Hashmap: key is a tuple of 2 long and the value is 1 long
    key2_t key;
#if defined(__USE_ABSL__)
    absl::flat_hash_map<key2_t, long> face_map;
    face_map.reserve(nb_cells);
#else
    std::map<key2_t, long> face_map;
#endif

    // Build the map using direct face orientation (node ID)
    for (long id_elem = 0; id_elem < nb_cells; id_elem++) {
        long offset = id_elem * Q4_NODE_PER_ELEM;
        for (int id_face = 0; id_face < Q4_FACE_PER_ELEM; id_face++) {
            // Get the node IDs of the face in direct orientation
            key = std::make_tuple(
                cells[offset + q4_face_to_loc_node[id_face][0]],
                cells[offset + q4_face_to_loc_node[id_face][1]]);

#if defined(__USE_ABSL__)
            auto res = face_map.try_emplace(key, id_elem);
#else
            auto res = face_map.emplace(key, id_elem);
#endif
            if (!(res.second)) {
                std::cout << "[WARNING]"
                          << " - mesh_q4_build_elem2elem"
                          << " - One or more cell are duplicated." << std::endl;
            }
        }
    }

    // Search corresponding faces using reverse face orientation (node ID)
    for (long id_elem = 0; id_elem < nb_cells; id_elem++) {
        long offset = id_elem * Q4_NODE_PER_ELEM;
        for (int id_face = 0; id_face < Q4_FACE_PER_ELEM; id_face++) {
            // Get the node IDs of the face in reverse orientation
            key = std::make_tuple(
                cells[offset + q4_face_to_loc_node[id_face][1]],
                cells[offset + q4_face_to_loc_node[id_face][0]]);

            auto res = face_map.find(key);

            if (res != face_map.end()) {
                // Store the neighboring element ID for the current face
                elem2elem[id_elem * Q4_FACE_PER_ELEM + id_face] = res->second;
            }
        }
    }
    face_map.clear();
}

/**
 * Checks the correctness of the `elem2elem` array for Q4 elements.
 *
 * @param nb_cells The number of cells in the mesh.
 * @param elem2elem Array representing the connectivity information between
 * elements.
 *
 * @remarks The `elem2elem` array stores the indices of the neighboring elements
 *          for each element in a mesh. Each element has Q4_FACE_PER_ELEM
 *          neighbors, and the neighbors are organized in pairs. This function
 *          verifies that the neighbor of the neighbor is the element itself.
 *
 * @note The `elem2elem` array is assumed to have a layout where the neighbors
 *       of each element are stored consecutively in memory. The stride between
 *       consecutive neighbors for a single element is given by
 *       `Q4_FACE_PER_ELEM`. The neighbors for the i-th element can be accessed
 *       as follows: `elem2elem[i * Q4_FACE_PER_ELEM + j]`, where `j` is the
 *       neighbor index (0, 1, 2, ..., Q4_FACE_PER_ELEM - 1). The value -1 is
 *       used to indicate a boundary face (no neighbor).
 */
void mesh_q4_check_elem2elem(const long nb_cells, const long *elem2elem)
{
    for (long id_elem = 0; id_elem < nb_cells; id_elem++) {
        for (int id_couple = 0; id_couple < Q4_FACE_PER_ELEM / 2; id_couple++) {
            long e0 = elem2elem[id_elem * Q4_FACE_PER_ELEM + 2 * id_couple + 0];

            // Skip boundary faces
            if (e0 != -1) {
                long e1 = elem2elem[e0 * Q4_FACE_PER_ELEM + 2 * id_couple + 1];

                bool check = (id_elem == e1);
                check_perror(check, "mesh_q4_check_elem2elem",
                             "elem2elem connectivy is not valid");

                assert(check);
            }
        }
    }
}