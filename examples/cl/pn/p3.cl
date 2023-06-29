#ifndef P3_CL
#define P3_CL

#ifdef IS_2D

void src_beam(const float t, const float x[2], float w[10])
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
    w[3] = -0.00000000F * p0 - 0.00000000F * p1;
    w[4] = -0.00000000F * p0 - 0.00000000F * p1;
    w[5] = -0.06778408F * p0 + 0.06778408F * p1;
    w[6] = -0.00000000F * p0 - 0.00000000F * p1;
    w[7] = -0.00000000F * p0 - 0.00000000F * p1;
    w[8] = -0.00000000F * p0 - 0.00000000F * p1;
    w[9] = -0.00000000F * p0 + 0.07230568F * p1;
}

void num_flux_rus(const float wL[10], const float wR[10], const float vn[2],
                  float flux[10])
{
    const float x0 = wL[2] + wR[2];
    const float x1 = 0.288675135F * vn[0];
    const float x2 = wL[1] + wR[1];
    const float x3 = 0.288675135F * vn[1];
    const float x4 = wL[3] + wR[3];
    const float x5 = 0.223606798F * x4;
    const float x6 = wL[0] + wR[0];
    const float x7 = wL[4] + wR[4];
    const float x8 = wL[5] + wR[5];
    const float x9 = 0.231455025F * wL[6] + 0.231455025F * wR[6];
    const float x10 = wL[7] + wR[7];
    const float x11 = 0.223606798F * x0;
    const float x12 = wL[8] + wR[8];
    const float x13 = wL[9] + wR[9];
    const float x14 = 0.207019668F * vn[0];
    const float x15 = 0.207019668F * vn[1];
    const float x16 = 0.0597614305F * vn[1];
    const float x17 = 0.231455025F * x8;
    flux[0] = 0.5F * wL[0] - 0.5F * wR[0] - x0 * x1 - x2 * x3;
    flux[1] = -vn[0] * x5 + 0.129099445F * vn[1] * x7 +
              0.223606798F * vn[1] * x8 + 0.5F * wL[1] - 0.5F * wR[1] - x3 * x6;
    flux[2] = 0.129099445F * vn[0] * x7 - 0.223606798F * vn[0] * x8 -
              vn[1] * x5 + 0.5F * wL[2] - 0.5F * wR[2] - x1 * x6;
    flux[3] = 0.0597614305F * vn[0] * x10 - 0.223606798F * vn[0] * x2 -
              vn[0] * x9 - vn[1] * x11 + 0.0597614305F * vn[1] * x12 +
              0.231455025F * vn[1] * x13 + 0.5F * wL[3] - 0.5F * wR[3];
    flux[4] = 0.129099445F * vn[0] * x0 + 0.129099445F * vn[1] * x2 +
              0.5F * wL[4] - 0.5F * wR[4] - x10 * x15 - x12 * x14;
    flux[5] = -vn[0] * x11 + 0.0597614305F * vn[0] * x12 -
              0.231455025F * vn[0] * x13 + 0.223606798F * vn[1] * x2 -
              vn[1] * x9 + 0.5F * wL[5] - 0.5F * wR[5] - x10 * x16;
    flux[6] =
        -0.231455025F * vn[0] * x4 - vn[1] * x17 + 0.5F * wL[6] - 0.5F * wR[6];
    flux[7] = 0.0597614305F * vn[0] * x4 + 0.5F * wL[7] - 0.5F * wR[7] -
              x15 * x7 - x16 * x8;
    flux[8] = 0.0597614305F * vn[0] * x8 + 0.5F * wL[8] - 0.5F * wR[8] -
              x14 * x7 + x16 * x4;
    flux[9] =
        -vn[0] * x17 + 0.231455025F * vn[1] * x4 + 0.5F * wL[9] - 0.5F * wR[9];
}

#else

void src_beam(const float t, const float x[3], float w[16])
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
    w[4] = -0.00002989F * p0 + 0.00597732F * p1;
    w[5] = -0.00000000F * p0 - 0.00000000F * p1;
    w[6] = +0.00983438F * p0 - 0.00488022F * p1;
    w[7] = -0.00000000F * p0 - 0.00000000F * p1;
    w[8] = -0.00002989F * p0 + 0.00597732F * p1;
    w[9] = -0.00000000F * p0 - 0.00636028F * p1;
    w[10] = -0.00007848F * p0 - 0.00000000F * p1;
    w[11] = -0.00000000F * p0 + 0.00492616F * p1;
    w[12] = +0.01154968F * p0 - 0.00000000F * p1;
    w[13] = -0.00000000F * p0 - 0.00492616F * p1;
    w[14] = -0.00007848F * p0 - 0.00000000F * p1;
    w[15] = -0.00000000F * p0 + 0.00636028F * p1;
}

void num_flux_rus(const float wL[16], const float wR[16], const float vn[3],
                  float flux[16])
{
    const float x0 = wL[3] + wR[3];
    const float x1 = 0.288675135F * vn[0];
    const float x2 = wL[1] + wR[1];
    const float x3 = 0.288675135F * vn[1];
    const float x4 = wL[2] + wR[2];
    const float x5 = wL[4] + wR[4];
    const float x6 = 0.223606798F * vn[0];
    const float x7 = wL[0] + wR[0];
    const float x8 = wL[6] + wR[6];
    const float x9 = wL[8] + wR[8];
    const float x10 = 0.223606798F * vn[1];
    const float x11 = wL[5] + wR[5];
    const float x12 = 0.223606798F * vn[2];
    const float x13 = wL[7] + wR[7];
    const float x14 = wL[11] + wR[11];
    const float x15 = 0.0597614305F * vn[0];
    const float x16 = 0.231455025F * wL[9] + 0.231455025F * wR[9];
    const float x17 = wL[13] + wR[13];
    const float x18 = 0.0597614305F * vn[1];
    const float x19 = 0.231455025F * wL[15] + 0.231455025F * wR[15];
    const float x20 = 0.188982236F * wL[10] + 0.188982236F * wR[10];
    const float x21 = wL[12] + wR[12];
    const float x22 = 0.146385011F * x21;
    const float x23 = wL[14] + wR[14];
    const float x24 = 0.188982236F * x23;
    const float x25 = 0.239045722F * vn[2];
    const float x26 = 0.207019668F * vn[0];
    const float x27 = 0.207019668F * vn[1];
    const float x28 = 0.253546276F * vn[2];
    const float x29 = 0.231455025F * x9;
    const float x30 = 0.188982236F * x11;
    const float x31 = 0.188982236F * x13;
    flux[0] = 0.288675135F * vn[2] * x4 + 0.5F * wL[0] - 0.5F * wR[0] -
              x0 * x1 - x2 * x3;
    flux[1] = 0.129099445F * vn[1] * x8 + 0.5F * wL[1] - 0.5F * wR[1] +
              x10 * x9 + x11 * x12 - x3 * x7 - x5 * x6;
    flux[2] = 0.288675135F * vn[2] * x7 + 0.25819889F * vn[2] * x8 +
              0.5F * wL[2] - 0.5F * wR[2] - x10 * x11 - x13 * x6;
    flux[3] = 0.129099445F * vn[0] * x8 + 0.223606798F * vn[2] * x13 +
              0.5F * wL[3] - 0.5F * wR[3] - x1 * x7 - x10 * x5 - x6 * x9;
    flux[4] = -vn[0] * x16 + vn[1] * x19 + vn[2] * x20 + 0.5F * wL[4] -
              0.5F * wR[4] - x0 * x10 + x14 * x15 + x17 * x18 - x2 * x6;
    flux[5] = -vn[0] * x20 + vn[1] * x22 + vn[1] * x24 + 0.5F * wL[5] -
              0.5F * wR[5] - x10 * x4 + x12 * x2 + x14 * x25;
    flux[6] = 0.129099445F * vn[0] * x0 + 0.129099445F * vn[1] * x2 +
              0.25819889F * vn[2] * x4 + 0.5F * wL[6] - 0.5F * wR[6] -
              x14 * x27 - x17 * x26 + x21 * x28;
    flux[7] = vn[0] * x22 - vn[0] * x24 - vn[1] * x20 + 0.5F * wL[7] -
              0.5F * wR[7] + x0 * x12 + x17 * x25 - x4 * x6;
    flux[8] = 0.0597614305F * vn[0] * x17 - vn[0] * x19 - vn[1] * x16 +
              0.223606798F * vn[1] * x2 + 0.188982236F * vn[2] * x23 +
              0.5F * wL[8] - 0.5F * wR[8] - x0 * x6 - x14 * x18;
    flux[9] =
        -0.231455025F * vn[0] * x5 - vn[1] * x29 + 0.5F * wL[9] - 0.5F * wR[9];
    flux[10] = -vn[0] * x30 - vn[1] * x31 + 0.188982236F * vn[2] * x5 +
               0.5F * wL[10] - 0.5F * wR[10];
    flux[11] = 0.5F * wL[11] - 0.5F * wR[11] + x11 * x25 + x15 * x5 - x18 * x9 -
               x27 * x8;
    flux[12] = 0.146385011F * vn[0] * x13 + 0.146385011F * vn[1] * x11 +
               0.5F * wL[12] - 0.5F * wR[12] + x28 * x8;
    flux[13] = 0.5F * wL[13] - 0.5F * wR[13] + x13 * x25 + x15 * x9 + x18 * x5 -
               x26 * x8;
    flux[14] = -vn[0] * x31 + vn[1] * x30 + 0.188982236F * vn[2] * x9 +
               0.5F * wL[14] - 0.5F * wR[14];
    flux[15] = -vn[0] * x29 + 0.231455025F * vn[1] * x5 + 0.5F * wL[15] -
               0.5F * wR[15];
}

#endif
#endif
