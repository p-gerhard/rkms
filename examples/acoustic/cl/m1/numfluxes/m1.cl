#ifndef NUMFLUX_M1_CL
#define NUMFLUX_M1_CL

#ifdef USE_DOUBLE
#define CST_ZERO         (0.)
#define CST_ONE_OVER_TWO (0.5)
#define CST_ONE          (1.)
#define CST_TWO          (2.)
#define CST_THREE        (3.)
#define CST_PI4          (12.5663706143591729)
#define CST_K_MAX        (70.)
#else
#define CST_ZERO         (0.f)
#define CST_ONE_OVER_TWO (0.5f)
#define CST_ONE          (1.f)
#define CST_TWO          (2.f)
#define CST_THREE        (3.f)
#define CST_PI4          (12.566370614f)
#define CST_K_MAX        (70.f)
#endif

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

inline real_t get_r(const real_t rho, const real_t norm)
{
#ifdef USE_DOUBLE
    return norm / max(rho, DBL_EPSILON);
#else
    return norm / max(rho, FLT_EPSILON);
#endif
}

// inline real_t get_chi(const real_t r)
// {
//     const real_t t0 = r * r;

// #ifdef USE_DOUBLE
//     // const double chi = (3. + 4. * t0) / (5. + 2. * sqrt(4. - 3. * t0));
//     const double chi = FIVE_OVER_THREE - TWO_OVER_THREE * sqrt(4. - 3. * t0);
// #else
//     // const float chi = (3.f + 4.f * t0) / (5.f + 2.f * sqrt(4.f - 3.f * t0));
//     const float chi = FIVE_OVER_THREE - TWO_OVER_THREE * sqrt(4.f - 3.f * t0);
// #endif
//     return chi;
// }

inline real_t get_chi(const real_t r)
{
#ifdef USE_DOUBLE
    const double a0 = 0.762066949972264;
    const double a2 = 0.219172080193380;
    const double a4 = -0.259725400168378;
    const double a6 = 0.457105130221120;
    const double b0 = 2.28620084991677;
    const double b2 = -2.10758208969840;
    const double chi_min = 0.33333333333;
    const double chi_max = 1.00000000000;
#else
    const float a0 = 0.762066949972264f;
    const float a2 = 0.219172080193380f;
    const float a4 = -0.259725400168378f;
    const float a6 = 0.457105130221120f;
    const float b0 = 2.28620084991677f;
    const float b2 = -2.10758208969840f;
    const float chi_min = 0.33333333333f;
    const float chi_max = 1.00000000000f;
#endif

    const real_t r2 = r * r;
    const real_t r4 = r2 * r2;
    const real_t r6 = r4 * r2;

    const real_t num = a6 * r6 + a4 * r4 + a2 * r2 + a0;
    const real_t den = r4 + b2 * r2 + b0;

    const real_t chi = num / den;

    return max(chi_min, min(chi_max, CST_ONE));
}

void get_k(const real_t wn[4], real_t k[3], real_t *kn)
{
    const real_t u[3] = { wn[1], wn[2], wn[3] };
    real_t norm;
    real_t un[3];
    safe_normalise(u, un, &norm);

    // Get closure value
    const real_t r = get_r(wn[0], norm);
    const real_t chi = get_chi(r);

    // See Eq 6.23
    *kn = min(CST_TWO * r / (CST_ONE - chi), CST_K_MAX);

    k[0] = *kn * un[0];
    k[1] = *kn * un[1];
    k[2] = *kn * un[2];
}

inline void get_k_s(const real_t k[3], const real_t vn[3], real_t k_s[3])
{
    const real_t k_dot_vn = k[0] * vn[0] + k[1] * vn[1] + k[2] * vn[2];
    const real_t t0 = CST_TWO * k_dot_vn;

    k_s[0] = k[0] - t0 * vn[0];
    k_s[1] = k[1] - t0 * vn[1];
    k_s[2] = k[2] - t0 * vn[2];
}

real_t get_a(const real_t rho, const real_t kn)
{
#ifdef USE_DOUBLE
    const double t0 = 1.;
    const double t1 = 0.1666666666666666666;
    const double t3 = 0.0194444444444444444;
    const double eps = 1e-6;
#else
    const float t0 = 1.f;
    const float t1 = 0.16666666666666666666f;
    const float t2 = 0.019444444444444444444f;
    const float eps = 1e-6f;
#endif

    if (kn < eps) {
        // Serie expension at 0
        const real_t kn2 = kn * kn;
        return rho * (t0 + t1 * kn2 + t2 * kn2 * kn2);
    } else {
        return rho * kn / sinh(kn);
    }
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

    const real_t t0 = CST_ONE_OVER_TWO;
    const real_t t1 = (CST_ONE - chi);
    const real_t t2 = (CST_THREE * chi - CST_ONE);

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

    flux[0] = CST_ONE_OVER_TWO * ((fL[0] + fR[0]) - (wR[0] - wL[0]));
    flux[1] = CST_ONE_OVER_TWO * ((fL[1] + fR[1]) - (wR[1] - wL[1]));
    flux[2] = CST_ONE_OVER_TWO * ((fL[2] + fR[2]) - (wR[2] - wL[2]));
    flux[3] = CST_ONE_OVER_TWO * ((fL[3] + fR[3]) - (wR[3] - wL[3]));
}

void m1_num_flux_kinetic(const real_t wL[4], const real_t wR[4],
                         const real_t vn[3], real_t flux[4])
{
    real_t kL[3];
    real_t kLn;
    get_k(wL, kL, &kLn);
    const real_t aL = get_a(wL[0], kLn);

    real_t kR[3];
    real_t kRn;
    get_k(wR, kR, &kRn);
    const real_t aR = get_a(wR[0], kRn);

    flux[0] = CST_ZERO;
    flux[1] = CST_ZERO;
    flux[2] = CST_ZERO;
    flux[3] = CST_ZERO;

    for (int k = 0; k < QUAD_NB_V; k++) {
        const real_t vx = quad_vi[3 * k + 0];
        const real_t vy = quad_vi[3 * k + 1];
        const real_t vz = quad_vi[3 * k + 2];
#ifdef USE_QUAD_TRIGAUSS
        const real_t wi = quad_wi[k] / CST_PI4;
#else
        const real_t wi = quad_wi[k];
#endif
        const real_t v_dot_n = vx * vn[0] + vy * vn[1] + vz * vn[2];

        if (v_dot_n > CST_ZERO) {
            const real_t t0 = kL[0] * vx + kL[1] * vy + kL[2] * vz;
            const real_t t1 = wi * aL * exp(t0) * v_dot_n;
            flux[0] += t1;
            flux[1] += t1 * vx;
            flux[2] += t1 * vy;
            flux[3] += t1 * vz;
        } else {
            const real_t t0 = kR[0] * vx + kR[1] * vy + kR[2] * vz;
            const real_t t1 = wi * aR * exp(t0) * v_dot_n;
            flux[0] += t1;
            flux[1] += t1 * vx;
            flux[2] += t1 * vy;
            flux[3] += t1 * vz;
        }
    }
}

static void m1_num_flux_kinetic_bd(const real_t wL[4], const real_t wR[4],
                                   const real_t vn[3], real_t flux[4])
{
    real_t kL[3];
    real_t kLn;
    get_k(wL, kL, &kLn);
    const real_t aL = get_a(wL[0], kLn);

    real_t kR[3];
    get_k_s(kL, vn, kR);

    real_t sum_vn = CST_ZERO;
    real_t int_fL = CST_ZERO;

    flux[0] = CST_ZERO;
    flux[1] = CST_ZERO;
    flux[2] = CST_ZERO;
    flux[3] = CST_ZERO;

    for (int k = 0; k < QUAD_NB_V; k++) {
        const real_t vx = quad_vi[3 * k + 0];
        const real_t vy = quad_vi[3 * k + 1];
        const real_t vz = quad_vi[3 * k + 2];
#ifdef USE_QUAD_TRIGAUSS
        const real_t wi = quad_wi[k] / CST_PI4;
#else
        const real_t wi = quad_wi[k];
#endif
        const real_t v_dot_n = vx * vn[0] + vy * vn[1] + vz * vn[2];

        if (v_dot_n > CST_ZERO) {
            const real_t t0 = kL[0] * vx + kL[1] * vy + kL[2] * vz;
            const real_t t1 = wi * aL * exp(t0) * v_dot_n;
            flux[0] += t1;
            flux[1] += t1 * vx;
            flux[2] += t1 * vy;
            flux[3] += t1 * vz;

            // Used below for diffusive part
            sum_vn += v_dot_n * wi;
            int_fL += t1;
        } else {
            const real_t t0 = kR[0] * vx + kR[1] * vy + kR[2] * vz;
            const real_t t1 = (CST_ONE - BETA) * wi * aL * exp(t0) * v_dot_n;
            flux[0] += t1;
            flux[1] += t1 * vx;
            flux[2] += t1 * vy;
            flux[3] += t1 * vz;
        }
    }

    /* Diffusive part */
    const real_t t0 = ALPHA * BETA * (int_fL / sum_vn);

    for (int k = 0; k < QUAD_NB_V; k++) {
        const real_t vx = quad_vi[3 * k + 0];
        const real_t vy = quad_vi[3 * k + 1];
        const real_t vz = quad_vi[3 * k + 2];
#ifdef USE_QUAD_TRIGAUSS
        const real_t wi = quad_wi[k] / CST_PI4;
#else
        const real_t wi = quad_wi[k];
#endif
        const real_t v_dot_n = vx * vn[0] + vy * vn[1] + vz * vn[2];

        if (v_dot_n <= CST_ZERO) {
            const real_t t1 = wi * t0 * v_dot_n;
            flux[0] += t1;
            flux[1] += t1 * vx;
            flux[2] += t1 * vy;
            flux[3] += t1 * vz;
        }
    }
}
#endif

// #ifdef USE_KINETIC_NUM_FLUX_SPLIT
// void static m1_num_flux_RL(const float wL[4], const float wR[4],
// 						   const float vn[3], float flux[4])
// {
// 	float kLn, kRn;
// 	float kL[3];
// 	float kR[3];

// 	get_kappa(wL, kL, &kLn);
// 	get_kappa(wR, kR, &kRn);

// 	float aL = get_a(wL[0], kLn);
// 	float aR = get_a(wR[0], kRn);

// 	float flux_o[4] = { 0.f, 0.f, 0.f, 0.f };
// 	float flux_i[4] = { 0.f, 0.f, 0.f, 0.f };

// 	/* R->L interface */

// 	for (int iv = 0; iv < QUAD_NB_V; iv++) {
// 		/* Integration on outer half-sphere */
// 		float vx = quad_vi_R[3 * iv + 0];
// 		float vy = quad_vi_R[3 * iv + 1];
// 		float vz = quad_vi_R[3 * iv + 2];
// 		float wi = quad_wi_half[iv] / (4.f * M_PI);

// 		float v_dot_n = vn[0] * vx;
// 		float tL = kL[0] * vx + kL[1] * vy + kL[2] * vz;
// 		float wifLvn = aL * wi * exp(tL) * v_dot_n;

// 		flux_o[0] += wifLvn;
// 		flux_o[1] += wifLvn * vx;
// 		flux_o[2] += wifLvn * vy;
// 		flux_o[3] += wifLvn * vz;

// 		/* Integration on inner half-sphere : (flip x,z coordinates) */
// 		vx = -vx;
// 		vz = -vz;
// 		v_dot_n = -v_dot_n;

// 		float tR = kR[0] * vx + kR[1] * vy + kR[2] * vz;
// 		float wifRvn = aR * wi * exp(tR) * v_dot_n;

// 		flux_i[0] += wifRvn;
// 		flux_i[1] += wifRvn * vx;
// 		flux_i[2] += wifRvn * vy;
// 		flux_i[3] += wifRvn * vz;
// 	}

// 	flux[0] = flux_o[0] + flux_i[0];
// 	flux[1] = flux_o[1] + flux_i[1];
// 	flux[2] = flux_o[2] + flux_i[2];
// 	flux[3] = flux_o[3] + flux_i[3];
// }

// void static m1_num_flux_FB(const float wL[4], const float wR[4],
// 						   const float vn[3], float flux[4])
// {
// 	float kLn, kRn;
// 	float kL[3];
// 	float kR[3];

// 	get_kappa(wL, kL, &kLn);
// 	get_kappa(wR, kR, &kRn);

// 	float aL = get_a(wL[0], kLn);
// 	float aR = get_a(wR[0], kRn);

// 	float flux_o[4] = { 0.f, 0.f, 0.f, 0.f };
// 	float flux_i[4] = { 0.f, 0.f, 0.f, 0.f };

// 	/* R->L interface */
// 	for (int iv = 0; iv < QUAD_NB_V; iv++) {
// 		/* Integration on outer half-sphere */
// 		float vx = quad_vi_F[3 * iv + 0];
// 		float vy = quad_vi_F[3 * iv + 1];
// 		float vz = quad_vi_F[3 * iv + 2];
// 		float wi = quad_wi_half[iv] / (4.f * M_PI);

// 		float v_dot_n = vn[1] * vy;
// 		float tL = kL[0] * vx + kL[1] * vy + kL[2] * vz;
// 		float wifLvn = aL * wi * exp(tL) * v_dot_n;

// 		flux_o[0] += wifLvn;
// 		flux_o[1] += wifLvn * vx;
// 		flux_o[2] += wifLvn * vy;
// 		flux_o[3] += wifLvn * vz;

// 		/* Integration on inner half-sphere : (flip y,z coordinates) */
// 		vy = -vy;
// 		vz = -vz;
// 		v_dot_n = -v_dot_n;

// 		float tR = kR[0] * vx + kR[1] * vy + kR[2] * vz;
// 		float wifRvn = aR * wi * exp(tR) * v_dot_n;

// 		flux_i[0] += wifRvn;
// 		flux_i[1] += wifRvn * vx;
// 		flux_i[2] += wifRvn * vy;
// 		flux_i[3] += wifRvn * vz;
// 	}

// 	flux[0] = flux_o[0] + flux_i[0];
// 	flux[1] = flux_o[1] + flux_i[1];
// 	flux[2] = flux_o[2] + flux_i[2];
// 	flux[3] = flux_o[3] + flux_i[3];
// }

// void static m1_num_flux_NS(const float wL[4], const float wR[4],
// 						   const float vn[3], float flux[4])
// {
// 	float kLn, kRn;
// 	float kL[3];
// 	float kR[3];

// 	get_kappa(wL, kL, &kLn);
// 	get_kappa(wR, kR, &kRn);

// 	float aL = get_a(wL[0], kLn);
// 	float aR = get_a(wR[0], kRn);

// 	float flux_o[4] = { 0.f, 0.f, 0.f, 0.f };
// 	float flux_i[4] = { 0.f, 0.f, 0.f, 0.f };

// 	/* R->L interface */
// 	for (int iv = 0; iv < QUAD_NB_V; iv++) {
// 		/* Integration on outer half-sphere */
// 		float vx = quad_vi_N[3 * iv + 0];
// 		float vy = quad_vi_N[3 * iv + 1];
// 		float vz = quad_vi_N[3 * iv + 2];
// 		float wi = quad_wi_half[iv] / (4.f * M_PI);

// 		float v_dot_n = vn[2] * vz;
// 		float tL = kL[0] * vx + kL[1] * vy + kL[2] * vz;
// 		float wifLvn = aL * wi * exp(tL) * v_dot_n;

// 		flux_o[0] += wifLvn;
// 		flux_o[1] += wifLvn * vx;
// 		flux_o[2] += wifLvn * vy;
// 		flux_o[3] += wifLvn * vz;

// 		/* Integration on inner half-sphere : (flip x,y,z coordinates) */
// 		vx = -vx;
// 		vy = -vy;
// 		vz = -vz;
// 		v_dot_n = -v_dot_n;

// 		float tR = kR[0] * vx + kR[1] * vy + kR[2] * vz;
// 		float wifRvn = aR * wi * exp(tR) * v_dot_n;

// 		flux_i[0] += wifRvn;
// 		flux_i[1] += wifRvn * vx;
// 		flux_i[2] += wifRvn * vy;
// 		flux_i[3] += wifRvn * vz;
// 	}

// 	flux[0] = flux_o[0] + flux_i[0];
// 	flux[1] = flux_o[1] + flux_i[1];
// 	flux[2] = flux_o[2] + flux_i[2];
// 	flux[3] = flux_o[3] + flux_i[3];
// }
// #endif
// #endif