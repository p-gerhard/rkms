#ifndef SRC_STROMGREN_SPHERE_CL
#define SRC_STROMGREN_SPHERE_CL

#ifdef USE_DOUBLE
#define SRC_X      (0.5)
#define SRC_Y      (0.5)
#define SRC_Z      (0.5)
#define SRC_VACCUM (DBL_EPSILON)
#else
#define SRC_X      (0.5f)
#define SRC_Y      (0.5f)
#define SRC_Z      (0.5f)
#define SRC_VACCUM (FLT_EPSILON)
#endif

static inline void pn_src_stromgren_sphere(const real_t t, const real_t x[DIM],
                                           real_t w[M])
{
    const real_t t0 = SRC_VACCUM;

#ifdef USE_DOUBLE
    const double t1 = 0.1;
    const double t2 = 0.;
    const double t3 = 1.;
    const double t4 = 0.5;
#else
    const float t1 = 0.1f;
    const float t2 = 0.f;
    const float t3 = 1.f;
    const double t4 = 0.5f;
#endif
    const real_t t5 = t0 * t1;

    if (t >= DT) {
        for (int k = 0; k < M; k++) {
            w[k] = t2;
        }
    } else {
        // Apply some vaccum (non zero) when initializing solution
        w[0] = t0;
        for (int k = 1; k < M; k++) {
            w[k] = t2;
        }
    }

    const real_t t6 = t4 * DX;
    const real_t t7 = t4 * DY;
    const real_t t8 = t4 * DZ;

    // Locate cell at the center of the geometry
    if ((x[0] >= SRC_X - t6) && (x[0] <= SRC_X + t6) && (x[1] >= SRC_Y - t7) &&
        (x[1] <= SRC_Y + t7) && (x[2] >= SRC_Z - t8) && (x[2] <= SRC_Z + t8)) {
        w[0] = t3;
        for (int k = 1; k < M; k++) {
            w[k] = t2;
        }
    }
}
#endif
