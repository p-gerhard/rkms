
#include <pybind11/pybind11.h>
#include <pybind11/numpy.h>

#include "mesh_q4_process.h"
#include "mesh_h8_process.h"

namespace py=pybind11;
/**
 * Python wrapper function to extract cell sizes from a mesh.
 *
 * @param np_nodes Numpy array representing the mesh nodes.
 * @param np_cells Numpy array representing the mesh cells.
 * @param np_cell_size Numpy array to store the computed cell sizes.
 * @param is_2d Boolean flag indicating whether the mesh is 2D or 3D. 
 */
void pybind11_wrapper_mesh_extract_cell_size(
	py::array_t<float> np_nodes, py::array_t<long> np_cells,
	py::array_t<float> np_cell_size, bool is_2d)
{
	// Unpack numpy C struct
	py::buffer_info info_nodes = np_nodes.request();
	py::buffer_info info_cells = np_cells.request();
	py::buffer_info info_cell_size = np_cell_size.request();

	float *nodes = static_cast<float *>(info_nodes.ptr);
	long *cells = static_cast<long *>(info_cells.ptr);
	float *cell_size = static_cast<float *>(info_cell_size.ptr);

	if (is_2d) {
		mesh_q4_extract_cell_size(nodes, cells, cell_size);
	} else {
		mesh_h8_extract_cell_size(nodes, cells, cell_size);
	}
}

/**
 * Python wrapper function to process each cells of the mesh by reordering
 * nodes, computing cell centers, and performing checks.
 *
 * @param nb_cells The number of cells in the mesh.
 * @param np_cell_size Numpy array representing the sizes of the cells in the
 * mesh.
 * @param np_nodes Numpy array representing the nodes of the mesh.
 * @param np_cells Numpy array representing the cells of the mesh.
 * @param np_cells_center Numpy array to store the computed cell centers.
 * @param is_2d Boolean flag indicating whether the mesh is 2D or 3D. 
 */
void pybind11_wrapper_mesh_process_cells(
	const long nb_cells, py::array_t<float> np_cell_size,
	py::array_t<float> np_nodes, py::array_t<long> np_cells,
	py::array_t<float> np_cells_center, bool is_2d)
{
	/* Unpack numpy C struct */
	py::buffer_info info_cell_size = np_cell_size.request();
	py::buffer_info info_nodes = np_nodes.request();
	py::buffer_info info_cells = np_cells.request();
	py::buffer_info info_cells_center = np_cells_center.request();

	float *cell_size = static_cast<float *>(info_cell_size.ptr);
	float *nodes = static_cast<float *>(info_nodes.ptr);
	long *cells = static_cast<long *>(info_cells.ptr);
	float *cells_center = static_cast<float *>(info_cells_center.ptr);

	if (is_2d) {
		mesh_q4_process_cells(nb_cells, cell_size, nodes, cells, cells_center);
	} else {
		mesh_h8_process_cells(nb_cells, cell_size, nodes, cells, cells_center);
	}
}

/**
 * Python wrapper function to prrocesses the nodes of each cells by rounding
 * their coordinates based on the given cell size.
 *
 * @param nb_nodes The number of nodes in the mesh.
 * @param np_cell_size Numpy array representing the sizes of the cells in the
 * mesh.
 * @param np_nodes Numpy array representing the nodes of the mesh.
 * @param is_2d Boolean flag indicating whether the mesh is 2D or 3D.
 */
void pybind11_wrapper_mesh_process_nodes(const long nb_nodes,
										 py::array_t<float> np_cell_size,
										 py::array_t<float> np_nodes,
										 bool is_2d)
{
	/* Unpack numpy C struct */
	py::buffer_info info_cell_size = np_cell_size.request();
	py::buffer_info info_nodes = np_nodes.request();

	float *cell_size = static_cast<float *>(info_cell_size.ptr);
	float *nodes = static_cast<float *>(info_nodes.ptr);
	if (is_2d) {
		mesh_q4_process_nodes(nb_nodes, cell_size, nodes);
	} else {
		mesh_h8_process_nodes(nb_nodes, cell_size, nodes);
	}
}

/**
 * Python wrapper function to build element-to-element connectivity for a mesh.
 *
 * @param nb_cells Number of cells in the mesh.
 * @param np_cells Numpy array representing the cells of the mesh.
 * @param np_elem2elem Numpy array to store the computed element-to-element connectivity.
 * @param is_2d Boolean flag indicating whether the mesh is 2D or 3D.
 */
void pybind11_wrapper_mesh_build_elem2elem(
	const long nb_cells, py::array_t<long> np_cells,
	py::array_t<long> np_elem2elem, bool is_2d)
{
	// Unpack numpy C struct
	py::buffer_info info_cells = np_cells.request();
	py::buffer_info info_elem2elem = np_elem2elem.request();

	long *cells = static_cast<long *>(info_cells.ptr);
	long *elem2elem = static_cast<long *>(info_elem2elem.ptr);

	if (is_2d) {
		mesh_q4_build_elem2elem(nb_cells, cells, elem2elem);
	} else {
		mesh_h8_build_elem2elem(nb_cells, cells, elem2elem);
	}
}

/**
 * Python wrapper function to check the element-to-element connectivity of a
 * mesh.
 *
 * @param nb_cells Number of cells in the mesh.
 * @param np_elem2elem Numpy array representing the element-to-element
 * connectivity of the mesh.
 * @param is_2d Boolean flag indicating whether the mesh is 2D or 3D.
 */
void pybind11_wrapper_mesh_check_elem2elem(
	const long nb_cells, py::array_t<long> np_elem2elem, bool is_2d)
{
	/* Unpack numpy C struct */
	py::buffer_info info_elem2elem = np_elem2elem.request();

	long *elem2elem = static_cast<long *>(info_elem2elem.ptr);
	if (is_2d) {
		mesh_q4_check_elem2elem(nb_cells, elem2elem);
	} else {
		mesh_h8_check_elem2elem(nb_cells, elem2elem);
	}
}

PYBIND11_MODULE(libmesh, m)
{
    m.def("extract_cell_size", &pybind11_wrapper_mesh_extract_cell_size,
          R"pbdoc(
          Extracts the size of cells in the mesh.

          This function takes numpy arrays representing the nodes, cells, and 
		  cell sizes of the mesh, and computes the size of each cell. 
		  The is_2d parameter indicates whether the mesh is 2D or 3D.

          Args:
              np_nodes: Numpy array representing the nodes of the mesh.
              np_cells: Numpy array representing the cells of the mesh.
              np_cell_size: Numpy array to store the computed cell sizes.
              is_2d: Boolean flag indicating whether the mesh is 2D or 3D.

          Returns:
              None
          )pbdoc");

    m.def("build_elem2elem", &pybind11_wrapper_mesh_build_elem2elem,
          R"pbdoc(
          Builds the element-to-element connectivity of the mesh.

          This function takes the number of cells and numpy arrays representing
		  the cells and element-to-element connectivity of the mesh. 
		  The is_2d parameter indicates whether the mesh is 2D or 3D.

          Args:
              nb_cells: The number of cells in the mesh.
              np_cells: Numpy array representing the cells of the mesh.
              np_elem2elem: Numpy array to store the computed 
			  element-to-element connectivity.
              is_2d: Boolean flag indicating whether the mesh is 2D or 3D.

          Returns:
              None
          )pbdoc");

    m.def("process_cells", &pybind11_wrapper_mesh_process_cells,
          R"pbdoc(
          Processes the cells of the mesh.

          This function takes the number of cells, numpy arrays representing 
		  the cell size, nodes, cells, and cell centers of the mesh, 
		  and processes the cells. The is_2d parameter indicates
          whether the mesh is 2D or 3D.

          Args:
              nb_cells: The number of cells in the mesh.
              np_cell_size: Numpy array representing the cell size of the mesh.
              np_nodes: Numpy array representing the nodes of the mesh.
              np_cells: Numpy array representing the cells of the mesh.
              np_cells_center: Numpy array to store the computed cell centers.
              is_2d: Boolean flag indicating whether the mesh is 2D or 3D.

          Returns:
              None
          )pbdoc");

    m.def("process_nodes", &pybind11_wrapper_mesh_process_nodes,
          R"pbdoc(
          Processes the nodes of the mesh.

          This function takes the number of nodes, a numpy array representing 
		  the cell size, and a numpy array representing the nodes of the mesh. 
		  The is_2d parameter indicates whether the mesh is 2D or 3D.

          Args:
              nb_nodes: The number of nodes in the mesh.
              np_cell_size: Numpy array representing the cell size of the mesh.
              np_nodes: Numpy array representing the nodes of the mesh.
              is_2d: Boolean flag indicating whether the mesh is 2D or 3D.

          Returns:
              None
          )pbdoc");

    m.def("check_elem2elem", &pybind11_wrapper_mesh_check_elem2elem,
          R"pbdoc(
          Checks the element-to-element connectivity of the mesh.

          This function takes the number of cells, a numpy array representing 
		  the element-to-element connectivity of the mesh, and a boolean flag 
		  indicating whether the mesh is 2D or 3D.

          Args:
              nb_cells: The number of cells in the mesh.
              np_elem2elem: Numpy array representing the element-to-element 
			  connectivity of the mesh.
              is_2d: Boolean flag indicating whether the mesh is 2D or 3D.

          Returns:
              None
          )pbdoc");
}