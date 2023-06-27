#ifndef MESH_Q4_CHECKER
#define MESH_Q4_CHECKER

void mesh_q4_extract_cell_size(const float *nodes, long *cells,
							   float cell_size[2]);

void mesh_q4_process_cells(const long nb_cells, const float cell_size[2],
						   const float *nodes, long *cells,
						   float *cells_center);

void mesh_q4_process_nodes(const long nb_nodes, const float cell_size[2],
						   float *nodes);

void mesh_q4_build_elem2elem(const long nb_cells, const long *cells,
							 long *elem2elem);

void mesh_q4_check_elem2elem(const long nb_cells, const long *elem2elem);
#endif
