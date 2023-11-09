#ifndef P3_CL
#define P3_CL

#ifdef USE_DOUBLE

#ifdef IS_2D

void num_flux_rus(const double wL[10], const double wR[10], const double vn[2],
                  double flux[10])
{
    const double x0 = wL[2] + wR[2];
    const double x1 = 0.28867513459481287 * vn[0];
    const double x2 = wL[1] + wR[1];
    const double x3 = 0.28867513459481287 * vn[1];
    const double x4 = 0.5 * C_WAVE;
    const double x5 = wL[3] + wR[3];
    const double x6 = 0.22360679774997899 * x5;
    const double x7 = wL[0] + wR[0];
    const double x8 = wL[4] + wR[4];
    const double x9 = 0.12909944487358058 * x8;
    const double x10 = wL[5] + wR[5];
    const double x11 = 0.22360679774997899 * x10;
    const double x12 = 0.22360679774997899 * x2;
    const double x13 =
        0.23145502494313785 * wL[6] + 0.23145502494313785 * wR[6];
    const double x14 = wL[7] + wR[7];
    const double x15 = 0.059761430466719681 * vn[0];
    const double x16 = 0.22360679774997899 * x0;
    const double x17 = wL[8] + wR[8];
    const double x18 = 0.059761430466719681 * vn[1];
    const double x19 =
        0.23145502494313785 * wL[9] + 0.23145502494313785 * wR[9];
    const double x20 = 0.20701966780270625 * vn[0];
    const double x21 = 0.20701966780270625 * vn[1];
    const double x22 = 0.23145502494313785 * x5;
    const double x23 = 0.23145502494313785 * x10;
    flux[0] = -x0 * x1 - x2 * x3 - x4 * (-wL[0] + wR[0]);
    flux[1] = -vn[0] * x6 + vn[1] * x11 + vn[1] * x9 - x3 * x7 -
              x4 * (-wL[1] + wR[1]);
    flux[2] = -vn[0] * x11 + vn[0] * x9 - vn[1] * x6 - x1 * x7 -
              x4 * (-wL[2] + wR[2]);
    flux[3] = -vn[0] * x12 - vn[0] * x13 - vn[1] * x16 + vn[1] * x19 +
              x14 * x15 + x17 * x18 - x4 * (-wL[3] + wR[3]);
    flux[4] = 0.12909944487358058 * vn[0] * x0 +
              0.12909944487358058 * vn[1] * x2 - x14 * x21 - x17 * x20 -
              x4 * (-wL[4] + wR[4]);
    flux[5] = -vn[0] * x16 - vn[0] * x19 + vn[1] * x12 - vn[1] * x13 -
              x14 * x18 + x15 * x17 - x4 * (-wL[5] + wR[5]);
    flux[6] = -vn[0] * x22 - vn[1] * x23 - x4 * (-wL[6] + wR[6]);
    flux[7] = -x10 * x18 + x15 * x5 - x21 * x8 - x4 * (-wL[7] + wR[7]);
    flux[8] = x10 * x15 + x18 * x5 - x20 * x8 - x4 * (-wL[8] + wR[8]);
    flux[9] = -vn[0] * x23 + vn[1] * x22 - x4 * (-wL[9] + wR[9]);
}

#else

void num_flux_rus(const double wL[16], const double wR[16], const double vn[3],
                  double flux[16])
{
    const double x0 = wL[3] + wR[3];
    const double x1 = 0.28867513459481287 * vn[0];
    const double x2 = wL[1] + wR[1];
    const double x3 = 0.28867513459481287 * vn[1];
    const double x4 = wL[2] + wR[2];
    const double x5 = 0.28867513459481287 * vn[2];
    const double x6 = 0.5 * C_WAVE;
    const double x7 = wL[4] + wR[4];
    const double x8 = 0.22360679774997899 * vn[0];
    const double x9 = wL[0] + wR[0];
    const double x10 = wL[6] + wR[6];
    const double x11 = 0.12909944487358058 * x10;
    const double x12 = wL[8] + wR[8];
    const double x13 = 0.22360679774997899 * vn[1];
    const double x14 = wL[5] + wR[5];
    const double x15 = 0.22360679774997899 * vn[2];
    const double x16 = wL[7] + wR[7];
    const double x17 = 0.25819888974716115 * vn[2];
    const double x18 = wL[11] + wR[11];
    const double x19 = 0.059761430466719681 * vn[0];
    const double x20 =
        0.23145502494313785 * wL[9] + 0.23145502494313785 * wR[9];
    const double x21 = wL[13] + wR[13];
    const double x22 = 0.059761430466719681 * vn[1];
    const double x23 =
        0.23145502494313785 * wL[15] + 0.23145502494313785 * wR[15];
    const double x24 =
        0.1889822365046136 * wL[10] + 0.1889822365046136 * wR[10];
    const double x25 = wL[12] + wR[12];
    const double x26 = 0.14638501094227996 * x25;
    const double x27 =
        0.1889822365046136 * wL[14] + 0.1889822365046136 * wR[14];
    const double x28 = 0.23904572186687872 * vn[2];
    const double x29 = 0.20701966780270625 * vn[0];
    const double x30 = 0.20701966780270625 * vn[1];
    const double x31 = 0.25354627641855498 * vn[2];
    const double x32 = 0.23145502494313785 * x7;
    const double x33 = 0.23145502494313785 * x12;
    const double x34 = 0.1889822365046136 * x14;
    const double x35 = 0.1889822365046136 * x16;
    const double x36 = 0.1889822365046136 * vn[2];
    flux[0] = -x0 * x1 - x2 * x3 + x4 * x5 - x6 * (-wL[0] + wR[0]);
    flux[1] = vn[1] * x11 + x12 * x13 + x14 * x15 - x3 * x9 -
              x6 * (-wL[1] + wR[1]) - x7 * x8;
    flux[2] =
        x10 * x17 - x13 * x14 - x16 * x8 + x5 * x9 - x6 * (-wL[2] + wR[2]);
    flux[3] = vn[0] * x11 - x1 * x9 - x12 * x8 - x13 * x7 + x15 * x16 -
              x6 * (-wL[3] + wR[3]);
    flux[4] = -vn[0] * x20 + vn[1] * x23 + vn[2] * x24 - x0 * x13 + x18 * x19 -
              x2 * x8 + x21 * x22 - x6 * (-wL[4] + wR[4]);
    flux[5] = -vn[0] * x24 + vn[1] * x26 + vn[1] * x27 - x13 * x4 + x15 * x2 +
              x18 * x28 - x6 * (-wL[5] + wR[5]);
    flux[6] = 0.12909944487358058 * vn[0] * x0 +
              0.12909944487358058 * vn[1] * x2 + x17 * x4 - x18 * x30 -
              x21 * x29 + x25 * x31 - x6 * (-wL[6] + wR[6]);
    flux[7] = vn[0] * x26 - vn[0] * x27 - vn[1] * x24 + x0 * x15 + x21 * x28 -
              x4 * x8 - x6 * (-wL[7] + wR[7]);
    flux[8] = -vn[0] * x23 - vn[1] * x20 + vn[2] * x27 - x0 * x8 + x13 * x2 -
              x18 * x22 + x19 * x21 - x6 * (-wL[8] + wR[8]);
    flux[9] = -vn[0] * x32 - vn[1] * x33 - x6 * (-wL[9] + wR[9]);
    flux[10] = -vn[0] * x34 - vn[1] * x35 + x36 * x7 - x6 * (-wL[10] + wR[10]);
    flux[11] =
        -x10 * x30 - x12 * x22 + x14 * x28 + x19 * x7 - x6 * (-wL[11] + wR[11]);
    flux[12] = 0.14638501094227996 * vn[0] * x16 +
               0.14638501094227996 * vn[1] * x14 + x10 * x31 -
               x6 * (-wL[12] + wR[12]);
    flux[13] =
        -x10 * x29 + x12 * x19 + x16 * x28 + x22 * x7 - x6 * (-wL[13] + wR[13]);
    flux[14] = -vn[0] * x35 + vn[1] * x34 + x12 * x36 - x6 * (-wL[14] + wR[14]);
    flux[15] = -vn[0] * x33 + vn[1] * x32 - x6 * (-wL[15] + wR[15]);
}

#endif

#else

#ifdef IS_2D

void num_flux_rus(const float wL[10], const float wR[10], const float vn[2],
                  float flux[10])
{
    const float x0 = wL[2] + wR[2];
    const float x1 = 0.288675135F * vn[0];
    const float x2 = wL[1] + wR[1];
    const float x3 = 0.288675135F * vn[1];
    const float x4 = 0.5F * C_WAVE;
    const float x5 = wL[3] + wR[3];
    const float x6 = 0.223606798F * x5;
    const float x7 = wL[0] + wR[0];
    const float x8 = wL[4] + wR[4];
    const float x9 = 0.129099445F * x8;
    const float x10 = wL[5] + wR[5];
    const float x11 = 0.223606798F * x10;
    const float x12 = 0.223606798F * x2;
    const float x13 = 0.231455025F * wL[6] + 0.231455025F * wR[6];
    const float x14 = wL[7] + wR[7];
    const float x15 = 0.0597614305F * vn[0];
    const float x16 = 0.223606798F * x0;
    const float x17 = wL[8] + wR[8];
    const float x18 = 0.0597614305F * vn[1];
    const float x19 = 0.231455025F * wL[9] + 0.231455025F * wR[9];
    const float x20 = 0.207019668F * vn[0];
    const float x21 = 0.207019668F * vn[1];
    const float x22 = 0.231455025F * x5;
    const float x23 = 0.231455025F * x10;
    flux[0] = -x0 * x1 - x2 * x3 - x4 * (-wL[0] + wR[0]);
    flux[1] = -vn[0] * x6 + vn[1] * x11 + vn[1] * x9 - x3 * x7 -
              x4 * (-wL[1] + wR[1]);
    flux[2] = -vn[0] * x11 + vn[0] * x9 - vn[1] * x6 - x1 * x7 -
              x4 * (-wL[2] + wR[2]);
    flux[3] = -vn[0] * x12 - vn[0] * x13 - vn[1] * x16 + vn[1] * x19 +
              x14 * x15 + x17 * x18 - x4 * (-wL[3] + wR[3]);
    flux[4] = 0.129099445F * vn[0] * x0 + 0.129099445F * vn[1] * x2 -
              x14 * x21 - x17 * x20 - x4 * (-wL[4] + wR[4]);
    flux[5] = -vn[0] * x16 - vn[0] * x19 + vn[1] * x12 - vn[1] * x13 -
              x14 * x18 + x15 * x17 - x4 * (-wL[5] + wR[5]);
    flux[6] = -vn[0] * x22 - vn[1] * x23 - x4 * (-wL[6] + wR[6]);
    flux[7] = -x10 * x18 + x15 * x5 - x21 * x8 - x4 * (-wL[7] + wR[7]);
    flux[8] = x10 * x15 + x18 * x5 - x20 * x8 - x4 * (-wL[8] + wR[8]);
    flux[9] = -vn[0] * x23 + vn[1] * x22 - x4 * (-wL[9] + wR[9]);
}

#else

void num_flux_rus(const float wL[16], const float wR[16], const float vn[3],
                  float flux[16])
{
    const float x0 = wL[3] + wR[3];
    const float x1 = 0.288675135F * vn[0];
    const float x2 = wL[1] + wR[1];
    const float x3 = 0.288675135F * vn[1];
    const float x4 = wL[2] + wR[2];
    const float x5 = 0.288675135F * vn[2];
    const float x6 = 0.5F * C_WAVE;
    const float x7 = wL[4] + wR[4];
    const float x8 = 0.223606798F * vn[0];
    const float x9 = wL[0] + wR[0];
    const float x10 = wL[6] + wR[6];
    const float x11 = 0.129099445F * x10;
    const float x12 = wL[8] + wR[8];
    const float x13 = 0.223606798F * vn[1];
    const float x14 = wL[5] + wR[5];
    const float x15 = 0.223606798F * vn[2];
    const float x16 = wL[7] + wR[7];
    const float x17 = 0.25819889F * vn[2];
    const float x18 = wL[11] + wR[11];
    const float x19 = 0.0597614305F * vn[0];
    const float x20 = 0.231455025F * wL[9] + 0.231455025F * wR[9];
    const float x21 = wL[13] + wR[13];
    const float x22 = 0.0597614305F * vn[1];
    const float x23 = 0.231455025F * wL[15] + 0.231455025F * wR[15];
    const float x24 = 0.188982236F * wL[10] + 0.188982236F * wR[10];
    const float x25 = wL[12] + wR[12];
    const float x26 = 0.146385011F * x25;
    const float x27 = 0.188982236F * wL[14] + 0.188982236F * wR[14];
    const float x28 = 0.239045722F * vn[2];
    const float x29 = 0.207019668F * vn[0];
    const float x30 = 0.207019668F * vn[1];
    const float x31 = 0.253546276F * vn[2];
    const float x32 = 0.231455025F * x7;
    const float x33 = 0.231455025F * x12;
    const float x34 = 0.188982236F * x14;
    const float x35 = 0.188982236F * x16;
    const float x36 = 0.188982236F * vn[2];
    flux[0] = -x0 * x1 - x2 * x3 + x4 * x5 - x6 * (-wL[0] + wR[0]);
    flux[1] = vn[1] * x11 + x12 * x13 + x14 * x15 - x3 * x9 -
              x6 * (-wL[1] + wR[1]) - x7 * x8;
    flux[2] =
        x10 * x17 - x13 * x14 - x16 * x8 + x5 * x9 - x6 * (-wL[2] + wR[2]);
    flux[3] = vn[0] * x11 - x1 * x9 - x12 * x8 - x13 * x7 + x15 * x16 -
              x6 * (-wL[3] + wR[3]);
    flux[4] = -vn[0] * x20 + vn[1] * x23 + vn[2] * x24 - x0 * x13 + x18 * x19 -
              x2 * x8 + x21 * x22 - x6 * (-wL[4] + wR[4]);
    flux[5] = -vn[0] * x24 + vn[1] * x26 + vn[1] * x27 - x13 * x4 + x15 * x2 +
              x18 * x28 - x6 * (-wL[5] + wR[5]);
    flux[6] = 0.129099445F * vn[0] * x0 + 0.129099445F * vn[1] * x2 + x17 * x4 -
              x18 * x30 - x21 * x29 + x25 * x31 - x6 * (-wL[6] + wR[6]);
    flux[7] = vn[0] * x26 - vn[0] * x27 - vn[1] * x24 + x0 * x15 + x21 * x28 -
              x4 * x8 - x6 * (-wL[7] + wR[7]);
    flux[8] = -vn[0] * x23 - vn[1] * x20 + vn[2] * x27 - x0 * x8 + x13 * x2 -
              x18 * x22 + x19 * x21 - x6 * (-wL[8] + wR[8]);
    flux[9] = -vn[0] * x32 - vn[1] * x33 - x6 * (-wL[9] + wR[9]);
    flux[10] = -vn[0] * x34 - vn[1] * x35 + x36 * x7 - x6 * (-wL[10] + wR[10]);
    flux[11] =
        -x10 * x30 - x12 * x22 + x14 * x28 + x19 * x7 - x6 * (-wL[11] + wR[11]);
    flux[12] = 0.146385011F * vn[0] * x16 + 0.146385011F * vn[1] * x14 +
               x10 * x31 - x6 * (-wL[12] + wR[12]);
    flux[13] =
        -x10 * x29 + x12 * x19 + x16 * x28 + x22 * x7 - x6 * (-wL[13] + wR[13]);
    flux[14] = -vn[0] * x35 + vn[1] * x34 + x12 * x36 - x6 * (-wL[14] + wR[14]);
    flux[15] = -vn[0] * x33 + vn[1] * x32 - x6 * (-wL[15] + wR[15]);
}

#endif

#endif
#endif
