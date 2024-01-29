#ifndef SOURCE_CIRCLE_M1_CL
#define SOURCE_CIRCLE_M1_CL

static void m1_src_circle(const real_t t, const real_t x[DIM], real_t wn[M])
{
#ifdef USE_DOUBLE
    const double t0 = 0.;
    const double t1 = 1.;
    const double vaccum = 1e-6;
#else
    const float t0 = 0.f;
    const float t1 = 1.f;
    const float vaccum = 1e-4;
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
			wn[0] = vaccum;
			wn[1] = t0;
			wn[2] = t0;
#ifndef IS_2D
			wn[3] = t0;
#endif
		} else {
			wn[0] = t1;
			wn[1] = t0;
			wn[2] = t0;
#ifndef IS_2D
			wn[3] = t0;
#endif
		}
	} else {
		wn[0] = vaccum;
		wn[1] = t0;
		wn[2] = t0;
#ifndef IS_2D
		wn[3] = t0;
#endif
	}
}
#endif
 
