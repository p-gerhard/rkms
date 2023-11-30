#ifndef M1_CL
#define M1_CL

// KEEP DEFINE BELOW
// Solver injected values
#define NGRID  __NGRID__
#define M      __M__
#define DT     __DT__
#define DX     __DX__
#define DY     __DY__
#define DIM    __DIM__
#define C_WAVE (1.0)
#if DIM == 2
#define IS_2D
#else
#undef IS_2D
#define DZ __DZ__
#endif
// KEEP DEFINE ABOVE

#include <solver/muscl_finite_volume.cl>

// Model injected values
#define PHY_C_DIM  __PHY_C_DIM__
#define PHY_DT_DIM __PHY_DT_DIM__
#define PHY_W0_DIM __PHY_W0_DIM__

#include "numfluxes/m1.cl"
#include "sources/stromgren_sphere.cl"
#include "../chemistry/hydrogen.cl"

void model_init_cond(const real_t t, const real_t x[DIM], real_t s[M])
{
    m1_src_stromgren_sphere(t, x, s);
}

void model_src(const real_t t, const real_t x[DIM], const real_t wn[M],
               real_t s[M])
{
    m1_src_stromgren_sphere(t, x, s);

    // WARNING: Divide by DT (adim) is required to fit test case
    for (int k = 0; k < M; k++) {
        s[k] = s[k] / DT;
    }
}

void model_flux_num(const real_t wL[M], const real_t wR[M],
                    const real_t vn[DIM], real_t flux[M])
{
    m1_num_flux_rusanov(wL, wR, vn, flux);
}

void model_flux_num_bd(const real_t wL[M], const real_t wR[M],
                       const real_t vn[DIM], real_t flux[M])
{
    m1_num_flux_rusanov(wL, wL, vn, flux);
}
#endif