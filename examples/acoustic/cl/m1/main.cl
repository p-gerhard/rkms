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

#define BETA     (1.)
#define ALPHA    (0.80)
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

#ifdef USE_QUAD_LEBEDEV
#undef USE_QUAD_TRIGAUSS
#define USE_QUAD_LEBEDEV_NB_V_302
#include <common/quad_lebedev.cl>
#endif

#ifdef USE_QUAD_TRIGAUSS
#undef USE_QUAD_LEBEDEV
#include <common/quad_trigauss.cl>
#endif

#ifdef USE_DOUBLE
#define CST_ZERO (0.)
#else
#define CST_ZERO (0.f)
#endif

#include <m1/numfluxes/m1.cl>
#include <m1/sources/circle.cl>


void model_init_cond(const real_t t, const real_t x[DIM], real_t s[M])
{
    m1_src_circle(t, x, s);
}

void model_src(const real_t t, const real_t x[DIM], const real_t wn[M],
               real_t s[M])
{
    m1_src_circle(t, x, s);
}

void model_flux_num(const real_t wL[M], const real_t wR[M],
                    const real_t vn[DIM], real_t flux[M])
{
    m1_num_flux_rusanov(wL, wR, vn, flux);
    // m1_num_flux_kinetic(wL, wR, vn, flux);
}

void model_flux_num_bd(const real_t wL[M], const real_t wR[M],
                       const real_t vn[DIM], real_t flux[M])
{
    m1_num_flux_kinetic_bd(wL, wL, vn, flux);
    // m1_num_flux_rusanov(wL, wR, vn, flux);
}

#endif