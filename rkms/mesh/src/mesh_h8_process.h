#ifndef MESH_H8_CHECKER
#define MESH_H8_CHECKER

void mesh_h8_extract_cell_size(const float *nodes, long *cells,
							   float cell_size[3]);

void mesh_h8_process_cells(const long nb_cells, const float cell_size[3],
						   const float *nodes, long *cells,
						   float *cells_center);

void mesh_h8_process_nodes(const long nb_nodes, const float cell_size[3],
						   float *nodes);

void mesh_h8_build_elem2elem(const long nb_cells, const long *cells,
							 long *elem2elem);

void mesh_h8_check_elem2elem(const long nb_cells, const long *elem2elem);
#endif
