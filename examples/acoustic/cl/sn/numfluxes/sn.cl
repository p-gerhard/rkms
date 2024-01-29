#ifndef NUMFLUXES_SN_CL
#define NUMFLUXES_SN_CL

void sn_num_flux_upwind(const real_t wL[M], const real_t wR[M],
                        const real_t vn[DIM], real_t flux[M])
{
#ifdef USE_DOUBLE
    const double t0 = 0.;
#else
    const float t0 = 0.f;
#endif

    for (int k = 0; k < M; k++) {
#ifdef IS_2D
        const real_t v_dot_n =
            vn[0] * quad_vi[2 * k + 0] + vn[1] * quad_vi[2 * k + 1];
#else
        const real_t v_dot_n = vn[0] * quad_vi[3 * k + 0] +
                               vn[1] * quad_vi[3 * k + 1] +
                               vn[2] * quad_vi[3 * k + 2];
#endif

        const real_t vp = v_dot_n > t0 ? v_dot_n : t0;
        const real_t vm = v_dot_n - vp;
        flux[k] = vp * wL[k] + vm * wR[k];
    }
}

void sn_num_flux_boundary(const real_t wL[M], const real_t wR[M],
                          const real_t vn[DIM], real_t flux[M])
{
#ifdef USE_DOUBLE
    const double t0 = 0.;
    const double t1 = 1.
#else
    const float t0 = 0.f;
    const float t1 = 1.f;
#endif

    real_t sum_v_dot_n = t0;
    real_t sum_flux_out = t0;

    /* Compute outgoing flux */
    for (int k = 0; k < M; k++) {
#ifdef IS_2D
        const real_t v_dot_n =
            vn[0] * quad_vi[2 * k + 0] + vn[1] * quad_vi[2 * k + 1];
#else
        const real_t v_dot_n = vn[0] * quad_vi[3 * k + 0] +
                               vn[1] * quad_vi[3 * k + 1] +
                               vn[2] * quad_vi[3 * k + 2];
#endif
        if (v_dot_n > t0) {
            flux[k] = v_dot_n * wL[k];
#ifdef USE_QUAD_UNIFORM
            const real_t c0 = QUAD_WI * v_dot_n;
#else
            const real_t c0 = quad_wi[k] * v_dot_n;
#endif
            sum_flux_out += c0 * wL[k];
            sum_v_dot_n += c0;
        } else {
            flux[k] = t0;
        }
    }
    
    const real_t c1 = sum_flux_out / sum_v_dot_n;

    /* Compute ingoing flux */
    for (int k = 0; k < M; k++) {
#ifdef IS_2D
        const real_t v_dot_n =
            vn[0] * quad_vi[2 * k + 0] + vn[1] * quad_vi[2 * k + 1];
#else
        const real_t v_dot_n = vn[0] * quad_vi[3 * k + 0] +
                               vn[1] * quad_vi[3 * k + 1] +
                               vn[2] * quad_vi[3 * k + 2];
#endif
        if (v_dot_n < t0) {
            /* Multiplication by the normal's component to avoid branching.
             * Assuming normal vector component is always 1 or 0.
             */
#ifdef IS_2D
            real_t flux_spec = v_dot_n * wL[quad_spec[0][k]] * fabs(vn[0]) +
                               v_dot_n * wL[quad_spec[1][k]] * fabs(vn[1]);
#else
            real_t flux_spec = v_dot_n * wL[quad_spec[0][k]] * fabs(vn[0]) +
                               v_dot_n * wL[quad_spec[1][k]] * fabs(vn[1]) +
                               v_dot_n * wL[quad_spec[2][k]] * fabs(vn[2]);
#endif
            real_t flux_diff = v_dot_n * c1;

            flux[k] = ALPHA * (BETA * flux_diff + (t1 - BETA) * flux_spec);
        }
    }
}
#endif
