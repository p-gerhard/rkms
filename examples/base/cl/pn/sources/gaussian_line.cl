#ifndef SRC_GAUSSIAN_LINE_CL
#define SRC_GAUSSIAN_LINE_CL

#ifdef USE_DOUBLE
#define SRC_VACCUM 1e-4
#else
#define SRC_VACCUM 1e-4f
#endif

static inline void pn_src_null(const real_t t, const real_t x[DIM], real_t w[M])
{
    for (int k = 0; k < M; k++) {
        w[k] = SRC_VACCUM;
    }
}

static inline void pn_src_gaussian_line_source(const real_t t,
                                               const real_t x[DIM], real_t w[M])
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
    const double omega = 0.03;
    const double gauss = exp(-10. * d / (omega * omega));
#else
    const float omega = 0.03f;
    const float gauss = exp(-10.f * d / (omega * omega));
#endif
    pn_src_null(t, x, w);
    w[0] = max(gauss, SRC_VACCUM);
}

#endif