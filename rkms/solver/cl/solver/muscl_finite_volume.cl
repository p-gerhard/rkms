#ifndef SOLVER_CL
#define SOLVER_CL

#if DIM == 2
#define FACE_PER_ELEM (4)
#define VOL           (DX * DY)
#else
#define VOL           (DX * DY * DZ)
#define FACE_PER_ELEM (6)
#endif

#ifdef USE_DOUBLE
#pragma OPENCL EXTENSION cl_khr_fp64 : enable
typedef double real_t;
#define ZERO         (0.)
#define ONE          (1.)
#define ONE_OVER_TWO (0.5)
#else
typedef float real_t;
#define ZERO         (0.f)
#define ONE          (1.f)
#define ONE_OVER_TWO (0.5f)
#endif

// Model dependent initial condition function
void model_init_cond(const real_t t, const real_t x[DIM], real_t w_cur[M]);

// Model dependent source function
void model_src(const real_t t, const real_t x[DIM], const real_t w_cur[M],
               real_t src[M]);

// Model dependent VF numerical flux function
void model_flux_num(const real_t w_cur[M], const real_t w_nei[M],
                    const real_t vn[DIM], real_t flux[M]);

// Model dependent VF numerical boundary flux function
void model_flux_num_bd(const real_t w_cur[M], const real_t w_nei[M],
                       const real_t vn[DIM], real_t flux[M]);

inline void load_loc_solution_buf(const __global real_t *sol_glob,
                                  const long id, real_t sol[M])
{
    for (int k = 0; k < M; k++) {
        long imem = id + k * NGRID;
        sol[k] = sol_glob[imem];
    }
}

inline void fill_glob_solution_buf(const long id, const real_t sol[M],
                                   __global real_t *sol_glob)
{
    for (int k = 0; k < M; k++) {
        long imem = id + k * NGRID;
        sol_glob[imem] = sol[k];
    }
}

inline void load_loc_coordinate_buf(const __global real_t *xyz_glob,
                                    const long id, real_t xyz[DIM])
{
#pragma unroll
    for (int k = 0; k < DIM; k++) {
        long imem = id * DIM + k;
        xyz[k] = xyz_glob[imem];
    }
}

inline void fill_glob_coordinate_buf(const long id, const real_t xyz[M],
                                     __global real_t *xyz_glob)
{
    for (int k = 0; k < M; k++) {
        long imem = id + k * NGRID;
        xyz_glob[imem] = xyz[k];
    }
}

inline void load_loc_connectivity_buf(const __global long *ids_glob,
                                      const long id, long ids[FACE_PER_ELEM])
{
#pragma unroll
    for (int k = 0; k < FACE_PER_ELEM; k++) {
        long imem = id * FACE_PER_ELEM + k;
        ids[k] = ids_glob[imem];
    }
}

inline void fill_glob_connectivity_buf(const long id, long ids[FACE_PER_ELEM],
                                       __global long *ids_glob)
{
#pragma unroll
    for (int k = 0; k < FACE_PER_ELEM; k++) {
        long imem = id * FACE_PER_ELEM + k;
        ids_glob[imem] = ids[k];
    }
}

#ifdef USE_MUSCL
inline real_t muscl_minmod(const real_t alpha, const real_t beta)
{
    real_t alpha_beta = alpha * beta;
    if (alpha_beta > 0) {
        real_t fabs_a = fabs(alpha);
        real_t fabs_b = fabs(beta);

        if (fabs_a < fabs_b) {
            return alpha;
        }
        if (fabs_a > fabs_b) {
            return beta;
        }
    }
    return 0.f;
}

static void muscl_get_slope(const __global real_t *wn,
                            const long ids_nei[FACE_PER_ELEM],
                            const real_t w_cur[M], real_t s_cur[DIM][M])
{
#pragma unroll
    for (int dim = 0; dim < DIM; dim++) {
        /* Load two-by-two complementary neighbour value (R-L), (F-B), (N-S) */
        long id_nei_1 = ids_nei[2 * dim + 0];
        long id_nei_2 = ids_nei[2 * dim + 1];

        for (int k = 0; k < M; k++) {
            long imem;

            // Compute the slope (-) between w_{i} and w_{i-1}:
            // 2D: (L: dir -nx) (S: dir -ny )
            // 3D: (L: dir -nx) (B: dir -ny) (S: dir -nz )
            imem = (id_nei_2 != -1) ? (id_nei_2 + k * NGRID) : -1;
            real_t sm = (imem != -1) ? (w_cur[k] - wn[imem]) : ZERO;
            // real_t sm = (imem != -1) ? (wn[imem] - w_cur[k]) : 0.f;

            // Compute the slope (+) between w_{i} and w_{i+1}:
            // 2D: (R: dir +nx) (F: dir +ny )
            // 3D: (L: dir +nx) (F: dir +ny) (N: dir +nz )
            imem = (id_nei_1 != -1) ? (id_nei_1 + k * NGRID) : -1;
            real_t sp = (imem != -1) ? (wn[imem] - w_cur[k]) : ZERO;
            // real_t sp = (imem != -1) ? (w_cur[k] - wn[imem]) : 0.f;

            // Compute slope value: s = muscl_minmod(sm, sp)
            s_cur[dim][k] = muscl_minmod(sm, sp);
        }
    }
}

static void muscl_reconstruct(const __global real_t *wn, const real_t vn[DIM],
                              const long id_cur, const real_t s_cur[DIM][M],
                              const long id_nei, const real_t s_nei[DIM][M],
                              real_t w_cur[M], real_t w_nei[M])
{
    for (int k = 0; k < M; k++) {
        long imem_cur = id_cur + k * NGRID;
        long imem_nei = id_nei + k * NGRID;

        // Reconstruct w(-) : w_{i} - 0.5 * s
        w_nei[k] = wn[imem_nei];
        w_nei[k] -= vn[0] * ONE_OVER_TWO * s_nei[0][k];
        w_nei[k] -= vn[1] * ONE_OVER_TWO * s_nei[1][k];
#ifndef IS_2D
        w_nei[k] -= vn[2] * ONE_OVER_TWO * s_nei[2][k];
#endif

        // Reconstruct w(+) : w_{i} + 0.5 * s
        w_cur[k] = wn[imem_cur];
        w_cur[k] += vn[0] * ONE_OVER_TWO * s_cur[0][k];
        w_cur[k] += vn[1] * ONE_OVER_TWO * s_cur[1][k];
#ifndef IS_2D
        w_cur[k] += vn[2] * ONE_OVER_TWO * s_cur[2][k];
#endif
    }
}

static void muscl_reconstruct_bd(const __global real_t *wn,
                                 const real_t vn[DIM], const long id_cur,
                                 const real_t s_cur[DIM][M], real_t w_cur[M])

{
    for (int k = 0; k < M; k++) {
        long imem_cur = id_cur + k * NGRID;

        w_cur[k] = wn[imem_cur];
        w_cur[k] += vn[0] * ONE_OVER_TWO * s_cur[0][k];
        w_cur[k] += vn[1] * ONE_OVER_TWO * s_cur[1][k];
#ifndef IS_2D
        w_cur[k] += vn[2] * ONE_OVER_TWO * s_cur[2][k];
#endif
    }
}
#endif

/**
 * Initialize Solution Kernel
 *
 * This kernel initializes the solution by calculating the initial values
 * based on the function mod_init_cond and store them in the output buffer.
 *
 * @param x Input buffer containing the input data (coordinates)
 * @param wn Output buffer for storing the initialized solution values
 */
__kernel void solver_init_sol(__global const real_t *x, __global real_t *wn)
{
    // Current cell: ID
    const long id_cur = get_global_id(0);

    // Current cell: solution values at t=0
    real_t w_cur[M];

    // Current cell: load center coordinates
    real_t xyz[DIM];
    load_loc_coordinate_buf(x, id_cur, xyz);

    // Current cell: compute source values
    model_init_cond(0.f, xyz, w_cur);

    // Fill global buffer wn with w_cur values
    fill_glob_solution_buf(id_cur, w_cur, wn);
}

__kernel void solver_time_step(const real_t tnow, __global const real_t *x,
                               __global const long *elem2elem,
                               __global const real_t *wn, __global real_t *wnp1)
{
    // Current cell: ID
    const long id_cur = get_global_id(0);

    // Current cell: center coordinates
    real_t xyz[DIM];

    // Current cell: neighbours IDs
    long ids_nei_cur[FACE_PER_ELEM];

    // VF-scheme: numerical flux values
    real_t flux[M];

    // Current cell: source value at t_n
    real_t src[M];

    // Current cell: solution values at t_n
    real_t w_cur[M];

    // Current cell: solution values in t_{n+1}
    real_t w_nxt[M];

    // Neighbour cell: solution values at t_n
    real_t w_nei[M];

#ifdef USE_MUSCL
    // Neighbour cell: neighbour IDs
    long ids_nei_nei[FACE_PER_ELEM];

    // Current cell: MUSCL slope
    real_t s_cur[DIM][M];

    // Neighbour cell: MUSCL slope
    real_t s_nei[DIM][M];
#endif

    // Constant across all cells: normal vectors to the face
#ifdef IS_2D
    const real_t vns[4][2] = {
        { ONE, ZERO},
        {-ONE, ZERO},
        {ZERO,  ONE},
        {ZERO, -ONE}
    };
#else
    const real_t vns[6][3] = {
        { ONE, ZERO, ZERO},
        {-ONE, ZERO, ZERO},
        {ZERO,  ONE, ZERO},
        {ZERO, -ONE, ZERO},
        {ZERO, ZERO,  ONE},
        {ZERO, ZERO, -ONE}
    };
#endif

    // Constant across all cells: surface values of the face
#ifdef IS_2D
    // const real_t dt_mult_ds_over_vol[4] = { DT * DY / VOL, DT * DY / VOL,
    //                                         DT * DX / VOL, DT * DX / VOL };
                                            
    const real_t dt_mult_ds_over_vol[4] = { DT / DX, DT / DX,
                                            DT / DY, DT  / DY };
#else
    // const real_t dt_mult_ds_over_vol[6] = {
    //     DT * (DY * DZ) / VOL, DT * (DY * DZ) / VOL, DT * (DX * DY) / VOL,
    //     DT * (DX * DY) / VOL, DT * (DZ * DY) / VOL, DT * (DZ * DY) / VOL
    // };

    const real_t dt_mult_ds_over_vol[6] = { DT / DX, DT / DX, DT / DZ,
                                            DT / DZ, DT / DX, DT / DX };

#endif

    // Current cell: load center coordinates
    load_loc_coordinate_buf(x, id_cur, xyz);

    // Current cell: load solution values
    load_loc_solution_buf(wn, id_cur, w_cur);

    // Current cell: load neigbours IDs
    load_loc_connectivity_buf(elem2elem, id_cur, ids_nei_cur);

    // Current cell: recopy solution value w_cur into w_next buffer
    for (int k = 0; k < M; k++) {
        w_nxt[k] = w_cur[k];
    }

#ifdef USE_MUSCL
    // Current cell: compute MUSCL slope
    muscl_get_slope(wn, ids_nei_cur, w_cur, s_cur);
#endif

// Loop over each directions (faces)
#pragma unroll
    for (int idx_face = 0; idx_face < FACE_PER_ELEM; idx_face++) {
        // Load current neighbour ID through the current face
        const long id_nei = ids_nei_cur[idx_face];

        // Case: non-boundary face
        if (id_nei != -1) {
            // Current neighbour: load its solution values
            load_loc_solution_buf(wn, id_nei, w_nei);

#ifdef USE_MUSCL
            // Current neighbour: load its neigbours IDs
            load_loc_connectivity_buf(elem2elem, id_nei, ids_nei_nei);

            // Current neighbour: compute its MUSCL slopes
            muscl_get_slope(wn, ids_nei_nei, w_nei, s_nei);

            // Current Cell + Current neighbout: compute their MUSCL
            // reconstruction
            muscl_reconstruct(wn, vns[idx_face], id_cur, s_cur, id_nei, s_nei,
                              w_cur, w_nei);
#endif
            // VF-scheme: compute the numerical flux across the current face
            model_flux_num(w_cur, w_nei, vns[idx_face], flux);

        } else {
            // Case: boundary face
#ifdef USE_MUSCL
            // Current cell : compute its MUSCL reconstruction
            // muscl_reconstruct_bd(wn, vns[idx_face], id_cur, s_cur, w_cur);
            load_loc_solution_buf(wn, id_cur, w_cur);
#endif
            // VF-scheme: compute the boundary numerical flux across the current
            // face
            model_flux_num_bd(w_cur, w_cur, vns[idx_face], flux);
        }

        // VF-scheme: add contribution across the current face
        for (int k = 0; k < M; k++) {
            w_nxt[k] -= dt_mult_ds_over_vol[idx_face] * flux[k];
        }
    }

    // VF-scheme: add source volume contribution
    model_src(tnow, xyz, w_cur, src);
    for (int k = 0; k < M; k++) {
        w_nxt[k] += src[k] * DT;
    }

    // VF-scheme: Update global buffer at t_{n+1} using w_nxt value.
    fill_glob_solution_buf(id_cur, w_nxt, wnp1);
}

#endif