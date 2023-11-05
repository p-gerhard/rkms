#ifndef PN_CL
#define PN_CL

// VF Solver injected values (DO NOT REMOVE)
#define NGRID __NGRID__
#define M     __M__
#define DT    __DT__
#define DX    __DX__
#define DY    __DY__
#define DIM   __DIM__

#if DIM == 2
#define IS_2D
#else
#undef IS_2D
#define DZ __DZ__
#endif

#include <solver/muscl_finite_volume.cl>

#ifdef USE_SPHERICAL_HARMONICS_P1
#include "p1.cl"
#endif

#ifdef USE_SPHERICAL_HARMONICS_P3
#include "p3.cl"
#endif

#ifdef USE_SPHERICAL_HARMONICS_P5
#include "p5.cl"
#endif

#ifdef USE_SPHERICAL_HARMONICS_P7
#include "p7.cl"
#endif

#ifdef USE_SPHERICAL_HARMONICS_P9
#include "p9.cl"
#endif

#ifdef USE_SPHERICAL_HARMONICS_P11
#include "p11.cl"
#endif

#include <chemistry.cl>

void model_init_cond(const float t, const float x[DIM], float s[M])
{
    src_beam(t, x, s);
}

void model_src(const float t, const float x[DIM], const float wn[M], float s[M])
{
    src_beam(t, x, s);
}

void model_flux_num(const float wL[M], const float wR[M], const float vn[DIM],
                    float flux[M])
{
    num_flux_rus(wL, wR, vn, flux);
}

void model_flux_num_bd(const float wL[M], const float wR[M],
                       const float vn[DIM], float flux[M])
{
    num_flux_rus(wL, wL, vn, flux);
}

#endif