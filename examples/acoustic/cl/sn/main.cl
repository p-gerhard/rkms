#ifndef SN_CL
#define SN_CL

// KEEP DEFINE BELOW
// Solver injected values
#define NGRID    __NGRID__
#define M        __M__
#define DT       __DT__
#define DX       __DX__
#define DY       __DY__
#define DIM      __DIM__
#define C_WAVE   __C_WAVE__

#define BETA     (0.)
#define ALPHA    (1.)
#define SRC_X    (0.5)
#define SRC_Y    (0.5)
#define SRC_Z    (0.5)
#define SRC_R    (0.1)
#define SRC_TOFF (1.)

#if DIM == 2
#define IS_2D
#else
#undef IS_2D
#define DZ __DZ__
#endif
// KEEP DEFINE ABOVE

#include <solver/muscl_finite_volume.cl>

#if defined(USE_QUAD_UNIFORM) && DIM == 2
#if M == 4
#define USE_QUAD_UNIFORM_NB_V_4
#elif M == 8
#define USE_QUAD_UNIFORM_NB_V_8
#elif M == 16
#define USE_QUAD_UNIFORM_NB_V_16
#elif M == 32
#define USE_QUAD_UNIFORM_NB_V_32
#elif M == 64
#define USE_QUAD_UNIFORM_NB_V_64
#elif M == 128
#define USE_QUAD_UNIFORM_NB_V_128
#elif M == 256
#define USE_QUAD_UNIFORM_NB_V_256
#elif M == 512
#define USE_QUAD_UNIFORM_NB_V_512
#endif
#include <common/quad_uniform.cl>
#endif

#if defined(USE_QUAD_LEBEDEV) && DIM == 3
#if M == 6
#define USE_QUAD_LEBEDEV_NB_V_6
#elif M == 14
#define USE_QUAD_LEBEDEV_NB_V_14
#elif M == 26
#define USE_QUAD_LEBEDEV_NB_V_26
#elif M == 38
#define USE_QUAD_LEBEDEV_NB_V_38
#elif M == 50
#define USE_QUAD_LEBEDEV_NB_V_50
#elif M == 74
#define USE_QUAD_LEBEDEV_NB_V_74
#elif M == 86
#define USE_QUAD_LEBEDEV_NB_V_86
#elif M == 110
#define USE_QUAD_LEBEDEV_NB_V_110
#elif M == 146
#define USE_QUAD_LEBEDEV_NB_V_146
#elif M == 170
#define USE_QUAD_LEBEDEV_NB_V_170
#elif M == 194
#define USE_QUAD_LEBEDEV_NB_V_194
#elif M == 230
#define USE_QUAD_LEBEDEV_NB_V_230
#elif M == 266
#define USE_QUAD_LEBEDEV_NB_V_266
#elif M == 302
#define USE_QUAD_LEBEDEV_NB_V_302
#elif M == 350
#define USE_QUAD_LEBEDEV_NB_V_350
#elif M == 434
#define USE_QUAD_LEBEDEV_NB_V_434
#elif M == 590
#define USE_QUAD_LEBEDEV_NB_V_590
#elif M == 770
#define USE_QUAD_LEBEDEV_NB_V_770
#endif
#include <common/quad_lebedev.cl>
#endif

#ifdef USE_DOUBLE
#define CST_ZERO (0.)
#else
#define CST_ZERO (0.f)
#endif

#include <sn/numfluxes/sn.cl>
#include <sn/sources/circle.cl>

__kernel void sn_reconstruct_macro_field(__global const real_t *wn,
                                         __global real_t *wn_rec)
{
    const long id = get_global_id(0);

    // Recopy buffer localy
    real_t w_loc[M];
    for (int k = 0; k < M; k++) {
        w_loc[k] = wn[id + k * NGRID];
    }

    real_t w = CST_ZERO;
    real_t i_x = CST_ZERO;
    real_t i_y = CST_ZERO;

#ifndef IS_2D
    real_t i_z = CST_ZERO;
#endif

/* Integration over S1 or S2 */
#pragma unroll
    for (int k = 0; k < M; k++) {
#ifdef USE_QUAD_UNIFORM
        real_t c0 = QUAD_WI * w_loc[k];
#else
        real_t c0 = quad_wi[k] * w_loc[k];
#endif
        w += c0;
        i_x += c0 * quad_vi[DIM * k + 0];
        i_y += c0 * quad_vi[DIM * k + 1];
#ifndef IS_2D
        i_z += c0 * quad_vi[DIM * k + 2];
#endif
    }

    wn_rec[id + 0 * NGRID] = w;
    wn_rec[id + 1 * NGRID] = i_x;
    wn_rec[id + 2 * NGRID] = i_y;

#ifndef IS_2D
    wn_rec[id + 3 * NGRID] = i_z;
#endif
}

void model_init_cond(const real_t t, const real_t x[DIM], real_t s[M])
{
    sn_src_circle(t, x, s);
}

void model_src(const real_t t, const real_t x[DIM], const real_t wn[M],
               real_t s[M])
{
    sn_src_circle(t, x, s);
}

void model_flux_num(const real_t wL[M], const real_t wR[M],
                    const real_t vn[DIM], real_t flux[M])
{
    sn_num_flux_upwind(wL, wR, vn, flux);
}

void model_flux_num_bd(const real_t wL[M], const real_t wR[M],
                       const real_t vn[DIM], real_t flux[M])
{
    sn_num_flux_boundary(wL, wL, vn, flux);
}

#endif