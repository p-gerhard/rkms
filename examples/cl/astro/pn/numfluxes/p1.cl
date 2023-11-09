#ifndef P1_CL
#define P1_CL

#ifdef USE_DOUBLE

#ifdef IS_2D

void num_flux_rus(const double wL[3], const double wR[3], const double vn[2],
                  double flux[3])
{
    const double x0 = 0.28867513459481287 * vn[0];
    const double x1 = 0.28867513459481287 * vn[1];
    const double x2 = 0.5 * C_WAVE;
    const double x3 = wL[0] + wR[0];
    flux[0] =
        -x0 * (wL[2] + wR[2]) - x1 * (wL[1] + wR[1]) - x2 * (-wL[0] + wR[0]);
    flux[1] = -x1 * x3 - x2 * (-wL[1] + wR[1]);
    flux[2] = -x0 * x3 - x2 * (-wL[2] + wR[2]);
}

#else

void num_flux_rus(const double wL[4], const double wR[4], const double vn[3],
                  double flux[4])
{
    const double x0 = 0.28867513459481287 * vn[0];
    const double x1 = 0.28867513459481287 * vn[1];
    const double x2 = 0.28867513459481287 * vn[2];
    const double x3 = 0.5 * C_WAVE;
    const double x4 = wL[0] + wR[0];
    flux[0] = -x0 * (wL[3] + wR[3]) - x1 * (wL[1] + wR[1]) +
              x2 * (wL[2] + wR[2]) - x3 * (-wL[0] + wR[0]);
    flux[1] = -x1 * x4 - x3 * (-wL[1] + wR[1]);
    flux[2] = x2 * x4 - x3 * (-wL[2] + wR[2]);
    flux[3] = -x0 * x4 - x3 * (-wL[3] + wR[3]);
}

#endif

#else

#ifdef IS_2D

void num_flux_rus(const float wL[3], const float wR[3], const float vn[2],
                  float flux[3])
{
    const float x0 = 0.288675135F * vn[0];
    const float x1 = 0.288675135F * vn[1];
    const float x2 = 0.5F * C_WAVE;
    const float x3 = wL[0] + wR[0];
    flux[0] =
        -x0 * (wL[2] + wR[2]) - x1 * (wL[1] + wR[1]) - x2 * (-wL[0] + wR[0]);
    flux[1] = -x1 * x3 - x2 * (-wL[1] + wR[1]);
    flux[2] = -x0 * x3 - x2 * (-wL[2] + wR[2]);
}

#else

void num_flux_rus(const float wL[4], const float wR[4], const float vn[3],
                  float flux[4])
{
    const float x0 = 0.288675135F * vn[0];
    const float x1 = 0.288675135F * vn[1];
    const float x2 = 0.288675135F * vn[2];
    const float x3 = 0.5F * C_WAVE;
    const float x4 = wL[0] + wR[0];
    flux[0] = -x0 * (wL[3] + wR[3]) - x1 * (wL[1] + wR[1]) +
              x2 * (wL[2] + wR[2]) - x3 * (-wL[0] + wR[0]);
    flux[1] = -x1 * x4 - x3 * (-wL[1] + wR[1]);
    flux[2] = x2 * x4 - x3 * (-wL[2] + wR[2]);
    flux[3] = -x0 * x4 - x3 * (-wL[3] + wR[3]);
}

#endif

#endif
#endif
