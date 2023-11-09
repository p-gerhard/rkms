static inline void pn_src_null(const real_t t, const real_t x[DIM], real_t w[M])
{
    for (int k = 0; k < M; k++) {
        w[k] = 0.f;
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

    const real_t vaccum = 0.f;
    const real_t omega = 0.03f;
    const real_t omega2 = omega * omega;
    const real_t gauss = exp(-10 * d / (omega2));

    pn_src_null(t, x, w);

    w[0] = max(gauss, vaccum);
}
