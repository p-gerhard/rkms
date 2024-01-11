#ifndef TP_CL
#define TP_CL

// KEEP DEFINE BELOW
// Solver injected values
#define NGRID  __NGRID__
#define M      __M__
#define DT     __DT__
#define DX     __DX__
#define DY     __DY__
#define DIM    __DIM__
#define C_WAVE __C_WAVE__

#if DIM == 2
#define IS_2D
#else
#undef IS_2D
#define DZ __DZ__
#endif
// KEEP DEFINE ABOVE

#include <solver/muscl_finite_volume.cl>

// Model injected values
#define SRC_X __SRC_X__
#define SRC_Y __SRC_Y__
#define SRC_Z __SRC_Z__
#define VX    __VX__
#define VY    __VY__
#define VZ    __VZ__

#include "numfluxes/upwind.cl"
#include "sources/gaussian_line.cl"

void model_init_cond(const real_t t, const real_t x[DIM], real_t s[M])
{
    tp_src_gaussian_line_source(t, x, s);
}

void model_src(const real_t t, const real_t x[DIM], const real_t wn[M],
               real_t s[M])
{
    // tp_src_gaussian_line_source(t, x, s);
    s[0] = 0.f;
}

void model_flux_num(const real_t wL[M], const real_t wR[M],
                    const real_t vn[DIM], real_t flux[M])
{
    tp_num_flux_upwind(wL, wR, vn, flux);
}

void model_flux_num_bd(const real_t wL[M], const real_t wR[M],
                       const real_t vn[DIM], real_t flux[M])
{
    tp_num_flux_upwind(wL, wL, vn, flux);
}

#endif