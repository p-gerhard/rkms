#ifndef MESH_H8_CHECKER
#define MESH_H8_CHECKER

void mesh_h8_extract_cell_size(const double *nodes, long *cells,
                               double cell_size[3]);

void mesh_h8_process_cells(const long nb_cells, const double cell_size[3],
                           const double *nodes, long *cells,
                           double *cells_center);

void mesh_h8_process_nodes(const long nb_nodes, const double cell_size[3],
                           double *nodes);

void mesh_h8_build_elem2elem(const long nb_cells, const long *cells,
                             long *elem2elem);

void mesh_h8_check_elem2elem(const long nb_cells, const long *elem2elem);

void mesh_h8_build_periodic_mesh(const long nb_cells, long *elem2elem);
#endif
