#ifndef NUMFLUX_M1_CL
#define NUMFLUX_M1_CL

#ifdef USE_DOUBLE
#define FIVE_OVER_THREE (1.66666666666666667)
#define TWO_OVER_THREE  (0.66666666666666667)
#else
#define FIVE_OVER_THREE (1.666666667f)
#define TWO_OVER_THREE  (0.666666667f)
#endif

inline static real_t get_r(const real_t rho, const real_t norm)
{
#ifdef USE_DOUBLE
    return norm / max(rho, DBL_EPSILON);
#else
    return norm / max(rho, FLT_EPSILON);
#endif
}

inline real_t get_chi(const real_t r)
{
    const real_t t0 = r * r;

#ifdef USE_DOUBLE
    // const double chi = (3. + 4. * t0) / (5. + 2. * sqrt(4. - 3. * t0));
    const double chi = FIVE_OVER_THREE - TWO_OVER_THREE * sqrt(4. - 3. * t0);
#else
    // const float chi = (3.f + 4.f * t0) / (5.f + 2.f * sqrt(4.f - 3.f * t0));
    const float chi = FIVE_OVER_THREE - TWO_OVER_THREE * sqrt(4.f - 3.f * t0);
#endif
    return chi;
}

inline void safe_normalise(const real_t u[3], real_t un[3], real_t *norm)
{
    const real_t t0 = sqrt(u[0] * u[0] + u[1] * u[1] + u[2] * u[2]);

#ifdef USE_DOUBLE
    const double t1 = 1. / max(t0, DBL_EPSILON);
#else
    const float t1 = 1.f / max(t0, FLT_EPSILON);
#endif
    un[0] = u[0] * t1;
    un[1] = u[1] * t1;
    un[2] = u[2] * t1;

    *norm = t0;
}

void phy_flux(const real_t wn[4], const real_t vn[3], real_t flux[4])
{
    const real_t u[3] = { wn[1], wn[2], wn[3] };
    real_t norm;
    real_t un[3];
    safe_normalise(u, un, &norm);

    // Get closure value
    const real_t r = get_r(wn[0], norm);
    const real_t chi = get_chi(r);

#ifdef USE_DOUBLE
    const double t0 = 0.5;
    const double t1 = (1. - chi);
    const double t2 = (3. * chi - 1.);
#else
    const float t0 = 0.5f;
    const float t1 = (1.f - chi);
    const float t2 = (3.f * chi - 1.f);
#endif

    // Diagonal terms
    const real_t Pxx = t1 + t2 * un[0] * un[0];
    const real_t Pyy = t1 + t2 * un[1] * un[1];
    const real_t Pzz = t1 + t2 * un[2] * un[2];

    // Off diagonal terms : Pxy = Pyz, Pxz = Pzx, Pyz = Pzy
    const real_t Pxy = t2 * un[0] * un[1];
    const real_t Pxz = t2 * un[0] * un[2];
    const real_t Pyz = t2 * un[1] * un[2];

    flux[0] = wn[1] * vn[0] + wn[2] * vn[1] + wn[3] * vn[2];
    flux[1] = t0 * wn[0] * (Pxx * vn[0] + Pxy * vn[1] + Pxz * vn[2]);
    flux[2] = t0 * wn[0] * (Pxy * vn[0] + Pyy * vn[1] + Pyz * vn[2]);
    flux[3] = t0 * wn[0] * (Pxz * vn[0] + Pyz * vn[1] + Pzz * vn[2]);
}

void m1_num_flux_rusanov(const real_t wL[4], const real_t wR[4],
                         const real_t vn[3], real_t flux[4])
{
    real_t fL[4];
    real_t fR[4];

    phy_flux(wL, vn, fL);
    phy_flux(wR, vn, fR);

#ifdef USE_DOUBLE
    const double t0 = 0.5;
#else
    const float t0 = 0.5f;
#endif
    flux[0] = t0 * ((fL[0] + fR[0]) - (wR[0] - wL[0]));
    flux[1] = t0 * ((fL[1] + fR[1]) - (wR[1] - wL[1]));
    flux[2] = t0 * ((fL[2] + fR[2]) - (wR[2] - wL[2]));
    flux[3] = t0 * ((fL[3] + fR[3]) - (wR[3] - wL[3]));
}
#endif