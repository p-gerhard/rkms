#ifndef SOURCE_CIRCLE_SN_CL
#define SOURCE_CIRCLE_SN_CL

static void sn_src_circle(const real_t t, const real_t x[DIM], real_t wn[M])
{
#ifdef USE_DOUBLE
    const double t0 = 0.;
#else
    const float t0 = 0.f;
#endif

#ifdef IS_2D
    const real_t d =
        (x[0] - SRC_X) * (x[0] - SRC_X) + (x[1] - SRC_Y) * (x[1] - SRC_Y);
#else
    const real_t d = (x[0] - SRC_X) * (x[0] - SRC_X) +
                     (x[1] - SRC_Y) * (x[1] - SRC_Y) +
                     (x[2] - SRC_Z) * (x[2] - SRC_Z);
#endif

    if (t < SRC_TOFF) {
        if (d > SRC_R * SRC_R) {
            for (int iw = 0; iw < M; iw++) {
                wn[iw] = t0;
            }
        } else {
            for (int iw = 0; iw < M; iw++) {
                wn[iw] = quad_wi[iw];
                // wn[iw] = 1.0;
            }
        }
    } else {
        for (int iw = 0; iw < M; iw++) {
            wn[iw] = t0;
        }
    }
}

#endif