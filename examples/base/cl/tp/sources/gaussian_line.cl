#ifndef SRC_GAUSSIAN_LINE_CL
#define SRC_GAUSSIAN_LINE_CL

#ifdef USE_DOUBLE
#define SRC_OMEGA  (0.03)
#define SRC_SIGMA  (-10.)
#define SRC_VACCUM (0.)
#else
#define SRC_OMEGA  (0.03f)
#define SRC_SIGMA  (-10.f)
#define SRC_VACCUM (0.f)
#endif

static void tp_src_gaussian_line_source(const real_t t, const real_t x[DIM],
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

    const real_t omega2 = SRC_OMEGA * SRC_OMEGA;
    const real_t gauss = exp(SRC_SIGMA * d / omega2);

    w[0] = max(gauss, SRC_VACCUM);
}

#endif
