#ifndef TEST_MUSCL_CL
#define TEST_MUSCL_CL

#ifndef __RKMS_REMOVE_DUMMY_MACROS__
// Setting dummy macros to avoid IDE complaints. When OpenCL compiler will build
// the program '__RKMS_REMOVE_DUMMY_MACROS__' will be defined by passing
// '-D __RKMS_REMOVE_DUMMY_MACROS__' compilation options thus, these
// dummy macros will vanish.
#ifndef __OPENCL_VERSION__
#include <math.h>
#define __kernel
#define __global
#define __constant
#define get_global_id
#endif

#define USE_MUSCL
#define NGRID (1)
#define M	  (1)
#define DT	  (1.f)
#define DX	  (1.f)
#define DY	  (1.f)

#ifndef IS_2D
#define DZ			  (1.f)
#define DIM			  (3)
#define VOL			  (DX * DY * DZ)
#define FACE_PER_ELEM (6)
#else
#define DIM			  (2)
#define FACE_PER_ELEM (4)
#define VOL			  (DX * DY)
#endif
#endif

#include "solver.cl"

__kernel void test_load_fill_loc_solution_buf(const __global float *sol_ref,
											  __global float *sol_res)
{
	const long id_cur = get_global_id(0);

	float sol[M];
	load_loc_solution_buf(sol_ref, id_cur, sol);
	fill_glob_solution_buf(id_cur, sol, sol_res);
}

__kernel void test_load_fill_loc_coordinates_buf(const __global float *xyz_ref,
												 __global float *xyz_res)
{
	const long id_cur = get_global_id(0);

	float xyz[DIM];
	load_loc_solution_buf(xyz_ref, id_cur, xyz);
	fill_glob_solution_buf(id_cur, xyz, xyz_res);
}

__kernel void test_load_fill_loc_connectivity_buf(const __global long *ids_ref,
												  __global long *ids_res)
{
	const long id_cur = get_global_id(0);

	long ids[FACE_PER_ELEM];
	load_loc_connectivity_buf(ids_ref, id_cur, ids);
	fill_glob_connectivity_buf(id_cur, ids, ids_res);
}

__kernel void test_muscl_minmod(const __global float *alpha,
								const __global float *beta, __global float *res)
{
	// Get the global ID of the current work-item (index of the cell)
	const long id_cur = get_global_id(0);

	res[id_cur] = muscl_minmod(alpha[id_cur], beta[id_cur]);
}

#endif
