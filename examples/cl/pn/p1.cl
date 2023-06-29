#ifndef P1_CL
#define P1_CL

#ifdef IS_2D

void src_beam(const float t, const float x[2], float w[3])
{
    float norm;
    float c0;
    float eps = 1e-8F;

    // Spatial coefficient for beam_0
    c0 = -0.5F / (0.00500000F * 0.00500000F);

    norm = (x[0] - 0.25000000F) * (x[0] - 0.25000000F) +
           (x[1] - 0.50000000F) * (x[1] - 0.50000000F);

    float p0 = eps + exp(c0 * norm);

    // Spatial coefficient for beam_1
    c0 = -0.5F / (0.00500000F * 0.00500000F);

    norm = (x[0] - 0.50000000F) * (x[0] - 0.50000000F) +
           (x[1] - 0.75000000F) * (x[1] - 0.75000000F);

    float p1 = eps + exp(c0 * norm);

    // Source values
    w[0] = +0.05000000F * p0 + 0.05000000F * p1;
    w[1] = -0.00000000F * p0 - 0.00000000F * p1;
    w[2] = -0.00000000F * p0 + 0.06108434F * p1;
}

void num_flux_rus(const float wL[3], const float wR[3], const float vn[2],
                  float flux[3])
{
    const float x0 = 0.288675135F * vn[0];
    const float x1 = 0.288675135F * vn[1];
    const float x2 = wL[0] + wR[0];
    flux[0] = 0.5F * wL[0] - 0.5F * wR[0] - x0 * (wL[2] + wR[2]) -
              x1 * (wL[1] + wR[1]);
    flux[1] = 0.5F * wL[1] - 0.5F * wR[1] - x1 * x2;
    flux[2] = 0.5F * wL[2] - 0.5F * wR[2] - x0 * x2;
}

#else

void src_beam(const float t, const float x[3], float w[4])
{
    float norm;
    float c0;
    float eps = 1e-8F;

    // Spatial coefficient for beam_0
    c0 = -0.5F / (0.00500000F * 0.00500000F);

    norm = (x[0] - 0.25000000F) * (x[0] - 0.25000000F) +
           (x[1] - 0.50000000F) * (x[1] - 0.50000000F) +
           (x[2] - 0.50000000F) * (x[2] - 0.50000000F);

    float p0 = eps + exp(c0 * norm);

    // Spatial coefficient for beam_1
    c0 = -0.5F / (0.00500000F * 0.00500000F);

    norm = (x[0] - 0.50000000F) * (x[0] - 0.50000000F) +
           (x[1] - 0.75000000F) * (x[1] - 0.75000000F) +
           (x[2] - 0.50000000F) * (x[2] - 0.50000000F);

    float p1 = eps + exp(c0 * norm);

    // Source values
    w[0] = +0.00443113F * p0 + 0.00443113F * p1;
    w[1] = -0.00000000F * p0 - 0.00539994F * p1;
    w[2] = +0.00765579F * p0 - 0.00000000F * p1;
    w[3] = -0.00000000F * p0 + 0.00539994F * p1;
}

void num_flux_rus(const float wL[4], const float wR[4], const float vn[3],
                  float flux[4])
{
    const float x0 = 0.288675135F * vn[0];
    const float x1 = 0.288675135F * vn[1];
    const float x2 = wL[0] + wR[0];
    flux[0] = 0.288675135F * vn[2] * (wL[2] + wR[2]) + 0.5F * wL[0] -
              0.5F * wR[0] - x0 * (wL[3] + wR[3]) - x1 * (wL[1] + wR[1]);
    flux[1] = 0.5F * wL[1] - 0.5F * wR[1] - x1 * x2;
    flux[2] = 0.288675135F * vn[2] * x2 + 0.5F * wL[2] - 0.5F * wR[2];
    flux[3] = 0.5F * wL[3] - 0.5F * wR[3] - x0 * x2;
}

#endif
#endif
