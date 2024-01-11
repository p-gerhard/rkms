#ifndef TP_UPWIND_CL
#define TP_UPWIND_CL

#ifdef USE_DOUBLE
#define TP_FLUX_ZERO (0.)
#else
#define TP_FLUX_ZERO (0.f)
#endif

void tp_num_flux_upwind(const real_t wL[M], const real_t wR[M],
                        const real_t vn[DIM], real_t flux[M])
{
#ifdef IS_2D
    const real_t v_dot_n = vn[0] * VX + vn[1] * VY;
#else
    const real_t v_dot_n = vn[0] * VX + vn[1] * VY + vn[2] * VZ;
#endif

    const real_t vp = v_dot_n > TP_FLUX_ZERO ? v_dot_n : TP_FLUX_ZERO;
    const real_t vm = v_dot_n - vp;

    flux[0] = vp * wL[0] + vm * wR[0];
}

#endif