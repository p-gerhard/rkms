#ifndef SRC_GAUSSIAN_LINE_CL
#define SRC_GAUSSIAN_LINE_CL

#ifdef USE_DOUBLE
#define SRC_VACCUM 1e-5
#else
#define SRC_VACCUM 1e-5f
#endif

static inline void m1_src_null(const real_t t, const real_t x[DIM], real_t w[M])
{
#ifdef USE_DOUBLE
    const double t0 = 0.;
#else
    const double t0 = 0.f;
#endif
    w[0] = SRC_VACCUM;
    w[1] = t0;
    w[2] = t0;
#ifndef IS_2D
    w[3] = t0;
#endif
}

static void m1_src_gaussian_line_source(const real_t t, const real_t x[DIM],
                                        real_t w[M])
{
#ifdef IS_2D
    const real_t d =
        (x[0] - SRC_X) * (x[0] - SRC_X) + (x[1] - SRC_Y) * (x[1] - SRC_Y);
#else
    const real_t d = (x[0] - SRC_X) * (x[0] - SRC_X) +
                     (x[1] - SRC_Y) * (x[1] - SRC_Y) +
                     (x[2] - SRC_Z) * (x[2] - SRC_Z);
#endif

#ifdef USE_DOUBLE
    const double t0 = 0.;
    const double omega = 0.03;
    const double gauss = exp(-10. * d / (omega * omega));
#else
    const float t0 = 0.f;
    const float omega = 0.03f;
    const float gauss = exp(-10.f * d / (omega * omega));
#endif

    w[0] = max(gauss, SRC_VACCUM);
    w[1] = t0;
    w[2] = t0;

#ifndef IS_2D
    w[3] = t0;
#endif
}

#endif