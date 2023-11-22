#ifndef SRC_STROMGREN_SPHERE_CL
#define SRC_STROMGREN_SPHERE_CL

#ifdef USE_DOUBLE
#define SRC_X      0.5
#define SRC_Y      0.5
#define SRC_Z      0.5
#define SRC_VACCUM 1e-8
#else
#define SRC_X      0.5f
#define SRC_Y      0.5f
#define SRC_Z      0.5f
#define SRC_VACCUM 1e-8f
#endif

static inline void m1_src_stromgren_sphere(const real_t t, const real_t x[DIM],
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

    const real_t t0 = SRC_VACCUM / PHY_W0_DIM;

#ifdef USE_DOUBLE
    const real_t t1 = 0.1;
    const real_t t2 = 0.;
    const real_t t3 = 1.;
#else
    const real_t t1 = 0.1f;
    const real_t t2 = 0.f;
    const real_t t3 = 1.f;
#endif
    const real_t t4 = t0 * t1;

    if (t < DT) {
        w[0] = t0;
        w[1] = t4;
        w[2] = t4;
#ifndef IS_2D
        w[3] = t4;
#endif
    } else {
        w[0] = t2;
        w[1] = t2;
        w[2] = t2;
#ifndef IS_2D
        w[3] = t2;
#endif
    }

    // WARNING: we assume that cells are cube or square (using only DX)
    if (d < DX * DX) {
        w[0] = t3;
        w[1] = t2;
        w[2] = t2;
#ifndef IS_2D
        w[3] = t2;
#endif
    }
}
#endif