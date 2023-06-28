#ifndef P5_CL
#define P5_CL

#ifdef IS_2D

void src_beam(const float t, const float x[2], float w[21])
{
    float norm;
    float c0;
    float eps = 1e-8F;

    // Spatial coefficient for beam_1
    c0 = -0.5F / (0.00500000F * 0.00500000F);

    norm = (x[0] - 0.25000000F) * (x[0] - 0.25000000F) +
           (x[1] - 0.50000000F) * (x[1] - 0.50000000F);

    float p0 = eps + exp(c0 * norm);

    // Spatial coefficient for beam_2
    c0 = -0.5F / (0.00500000F * 0.00500000F);

    norm = (x[0] - 0.50000000F) * (x[0] - 0.50000000F) +
           (x[1] - 0.75000000F) * (x[1] - 0.75000000F);

    float p1 = eps + exp(c0 * norm);

    // Source values
    w[0] = +0.07500000F * p0 + 0.07500000F * p1;
    w[1] = -0.00000000F * p0 - 0.00000000F * p1;
    w[2] = -0.08981219F * p0 - 0.08981219F * p1;
    w[3] = -0.00000000F * p0 - 0.00000000F * p1;
    w[4] = -0.00000000F * p0 - 0.00000000F * p1;
    w[5] = +0.09385888F * p0 + 0.09385888F * p1;
    w[6] = -0.00000000F * p0 - 0.00000000F * p1;
    w[7] = -0.00000000F * p0 - 0.00000000F * p1;
    w[8] = -0.00000000F * p0 - 0.00000000F * p1;
    w[9] = -0.09059217F * p0 - 0.09059217F * p1;
    w[10] = -0.00000000F * p0 - 0.00000000F * p1;
    w[11] = -0.00000000F * p0 - 0.00000000F * p1;
    w[12] = -0.00000000F * p0 - 0.00000000F * p1;
    w[13] = -0.00000000F * p0 - 0.00000000F * p1;
    w[14] = +0.08208533F * p0 + 0.08208533F * p1;
    w[15] = -0.00000000F * p0 - 0.00000000F * p1;
    w[16] = -0.00000000F * p0 - 0.00000000F * p1;
    w[17] = -0.00000000F * p0 - 0.00000000F * p1;
    w[18] = -0.00000000F * p0 - 0.00000000F * p1;
    w[19] = -0.00000000F * p0 - 0.00000000F * p1;
    w[20] = -0.07031003F * p0 - 0.07031003F * p1;
}

void num_flux_rus(const float wL[21], const float wR[21], const float vn[2],
                  float flux[21])
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
    const float x9 = wL[6] + wR[6];
    const float x10 = 0.231455025F * x9;
    const float x11 = wL[7] + wR[7];
    const float x12 = 0.223606798F * x0;
    const float x13 = wL[8] + wR[8];
    const float x14 = wL[9] + wR[9];
    const float x15 = 0.207019668F * vn[0];
    const float x16 = 0.207019668F * vn[1];
    const float x17 = 0.0597614305F * vn[1];
    const float x18 = wL[10] + wR[10];
    const float x19 = 0.23570226F * x18;
    const float x20 = wL[11] + wR[11];
    const float x21 = wL[13] + wR[13];
    const float x22 = wL[14] + wR[14];
    const float x23 = 0.231455025F * x8;
    const float x24 = vn[0] * x20;
    const float x25 = wL[12] + wR[12];
    const float x26 = vn[0] * x21;
    const float x27 = vn[1] * x20;
    const float x28 = 0.238365647F * wL[15] + 0.238365647F * wR[15];
    const float x29 = wL[16] + wR[16];
    const float x30 = wL[19] + wR[19];
    const float x31 = wL[20] + wR[20];
    const float x32 = vn[1] * x14;
    const float x33 = wL[17] + wR[17];
    const float x34 = 0.17251639F * x11;
    const float x35 = wL[18] + wR[18];
    const float x36 = 0.17251639F * x13;
    const float x37 = 0.194624736F * vn[0];
    const float x38 = 0.194624736F * vn[1];
    const float x39 = vn[0] * x14;
    const float x40 = vn[1] * x29;
    const float x41 = vn[1] * x22;
    const float x42 = vn[1] * x21;
    const float x43 = vn[0] * x22;
    flux[0] = 0.5F * wL[0] - 0.5F * wR[0] - x0 * x1 - x2 * x3;
    flux[1] = -vn[0] * x5 + 0.129099445F * vn[1] * x7 +
              0.223606798F * vn[1] * x8 + 0.5F * wL[1] - 0.5F * wR[1] - x3 * x6;
    flux[2] = 0.129099445F * vn[0] * x7 - 0.223606798F * vn[0] * x8 -
              vn[1] * x5 + 0.5F * wL[2] - 0.5F * wR[2] - x1 * x6;
    flux[3] = -vn[0] * x10 + 0.0597614305F * vn[0] * x11 -
              0.223606798F * vn[0] * x2 - vn[1] * x12 +
              0.0597614305F * vn[1] * x13 + 0.231455025F * vn[1] * x14 +
              0.5F * wL[3] - 0.5F * wR[3];
    flux[4] = 0.129099445F * vn[0] * x0 + 0.129099445F * vn[1] * x2 +
              0.5F * wL[4] - 0.5F * wR[4] - x11 * x16 - x13 * x15;
    flux[5] = -vn[0] * x12 + 0.0597614305F * vn[0] * x13 -
              0.231455025F * vn[0] * x14 - vn[1] * x10 +
              0.223606798F * vn[1] * x2 + 0.5F * wL[5] - 0.5F * wR[5] -
              x11 * x17;
    flux[6] = -vn[0] * x19 + 0.0445435403F * vn[0] * x20 -
              0.231455025F * vn[0] * x4 + 0.0445435403F * vn[1] * x21 +
              0.23570226F * vn[1] * x22 - vn[1] * x23 + 0.5F * wL[6] -
              0.5F * wR[6];
    flux[7] = 0.0597614305F * vn[0] * x4 + 0.17251639F * vn[1] * x21 +
              0.15430335F * vn[1] * x25 + 0.5F * wL[7] - 0.5F * wR[7] -
              x16 * x7 - x17 * x8 - 0.17251639F * x24;
    flux[8] = 0.15430335F * vn[0] * x25 + 0.0597614305F * vn[0] * x8 +
              0.5F * wL[8] - 0.5F * wR[8] - x15 * x7 + x17 * x4 -
              0.17251639F * x26 - 0.17251639F * x27;
    flux[9] = 0.0445435403F * vn[0] * x21 - 0.23570226F * vn[0] * x22 -
              vn[0] * x23 - vn[1] * x19 + 0.231455025F * vn[1] * x4 +
              0.5F * wL[9] - 0.5F * wR[9] - 0.0445435403F * x27;
    flux[10] = -vn[0] * x28 + 0.0355334527F * vn[0] * x29 -
               0.23570226F * vn[0] * x9 + 0.0355334527F * vn[1] * x30 +
               0.238365647F * vn[1] * x31 + 0.5F * wL[10] - 0.5F * wR[10] -
               0.23570226F * x32;
    flux[11] = -0.188025358F * vn[0] * x29 + 0.087038828F * vn[0] * x33 -
               vn[0] * x34 + 0.0445435403F * vn[0] * x9 +
               0.188025358F * vn[1] * x30 + 0.087038828F * vn[1] * x35 -
               vn[1] * x36 + 0.5F * wL[11] - 0.5F * wR[11] -
               0.0445435403F * x32;
    flux[12] = 0.15430335F * vn[0] * x13 + 0.15430335F * vn[1] * x11 +
               0.5F * wL[12] - 0.5F * wR[12] - x33 * x38 - x35 * x37;
    flux[13] = -0.188025358F * vn[0] * x30 + 0.087038828F * vn[0] * x35 -
               vn[0] * x36 - 0.087038828F * vn[1] * x33 + vn[1] * x34 +
               0.0445435403F * vn[1] * x9 + 0.5F * wL[13] - 0.5F * wR[13] +
               0.0445435403F * x39 - 0.188025358F * x40;
    flux[14] = 0.0355334527F * vn[0] * x30 - 0.238365647F * vn[0] * x31 -
               vn[1] * x28 + 0.23570226F * vn[1] * x9 + 0.5F * wL[14] -
               0.5F * wR[14] - 0.23570226F * x39 - 0.0355334527F * x40;
    flux[15] = -0.238365647F * vn[0] * x18 + 0.5F * wL[15] - 0.5F * wR[15] -
               0.238365647F * x41;
    flux[16] = 0.0355334527F * vn[0] * x18 + 0.5F * wL[16] - 0.5F * wR[16] -
               0.188025358F * x24 - 0.0355334527F * x41 - 0.188025358F * x42;
    flux[17] = 0.087038828F * vn[0] * x20 + 0.5F * wL[17] - 0.5F * wR[17] -
               x25 * x38 - 0.087038828F * x42;
    flux[18] = 0.5F * wL[18] - 0.5F * wR[18] - x25 * x37 + 0.087038828F * x26 +
               0.087038828F * x27;
    flux[19] = 0.0355334527F * vn[1] * x18 + 0.5F * wL[19] - 0.5F * wR[19] -
               0.188025358F * x26 + 0.188025358F * x27 + 0.0355334527F * x43;
    flux[20] = 0.238365647F * vn[1] * x18 + 0.5F * wL[20] - 0.5F * wR[20] -
               0.238365647F * x43;
}

#else

void src_beam(const float t, const float x[3], float w[36])
{
    float norm;
    float c0;
    float eps = 1e-8F;

    // Spatial coefficient for beam_1
    c0 = -0.5F / (0.00500000F * 0.00500000F);

    norm = (x[0] - 0.25000000F) * (x[0] - 0.25000000F) +
           (x[1] - 0.50000000F) * (x[1] - 0.50000000F) +
           (x[2] - 0.50000000F) * (x[2] - 0.50000000F);

    float p0 = eps + exp(c0 * norm);

    // Spatial coefficient for beam_2
    c0 = -0.5F / (0.00500000F * 0.00500000F);

    norm = (x[0] - 0.50000000F) * (x[0] - 0.50000000F) +
           (x[1] - 0.75000000F) * (x[1] - 0.75000000F) +
           (x[2] - 0.50000000F) * (x[2] - 0.50000000F);

    float p1 = eps + exp(c0 * norm);

    // Source values
    w[0] = +0.03988021F * p0 + 0.01994011F * p1;
    w[1] = +0.04669387F * p0 + 0.00398147F * p1;
    w[2] = -0.00000000F * p0 + 0.03376887F * p1;
    w[3] = -0.04669387F * p0 - 0.00398147F * p1;
    w[4] = +0.04776039F * p0 + 0.00107388F * p1;
    w[5] = -0.00000000F * p0 + 0.00851397F * p1;
    w[6] = -0.03883105F * p0 + 0.04170924F * p1;
    w[7] = -0.00000000F * p0 - 0.00851397F * p1;
    w[8] = +0.04776039F * p0 + 0.00107388F * p1;
    w[9] = +0.04515972F * p0 + 0.00033573F * p1;
    w[10] = -0.00000000F * p0 + 0.00265847F * p1;
    w[11] = -0.03468426F * p0 + 0.01334059F * p1;
    w[12] = -0.00000000F * p0 + 0.04627203F * p1;
    w[13] = +0.03468426F * p0 - 0.01334059F * p1;
    w[14] = -0.00000000F * p0 + 0.00265847F * p1;
    w[15] = -0.04515972F * p0 - 0.00033573F * p1;
    w[16] = +0.04011992F * p0 + 0.00011444F * p1;
    w[17] = -0.00000000F * p0 + 0.00092234F * p1;
    w[18] = -0.02992813F * p0 + 0.00478678F * p1;
    w[19] = -0.00000000F * p0 + 0.01793334F * p1;
    w[20] = +0.02830258F * p0 + 0.04832107F * p1;
    w[21] = -0.00000000F * p0 - 0.01793334F * p1;
    w[22] = -0.02992813F * p0 + 0.00478678F * p1;
    w[23] = -0.00000000F * p0 - 0.00092234F * p1;
    w[24] = +0.04011992F * p0 + 0.00011444F * p1;
    w[25] = +0.03371954F * p0 + 0.00004116F * p1;
    w[26] = -0.00000000F * p0 + 0.00034031F * p1;
    w[27] = -0.02465997F * p0 + 0.00183119F * p1;
    w[28] = -0.00000000F * p0 + 0.00727286F * p1;
    w[29] = +0.02270051F * p0 + 0.02191161F * p1;
    w[30] = -0.00000000F * p0 + 0.04847037F * p1;
    w[31] = -0.02270051F * p0 - 0.02191161F * p1;
    w[32] = -0.00000000F * p0 + 0.00727286F * p1;
    w[33] = +0.02465997F * p0 - 0.00183119F * p1;
    w[34] = -0.00000000F * p0 + 0.00034031F * p1;
    w[35] = -0.03371954F * p0 - 0.00004116F * p1;
}

void num_flux_rus(const float wL[36], const float wR[36], const float vn[3],
                  float flux[36])
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
    const float x16 = wL[9] + wR[9];
    const float x17 = 0.231455025F * x16;
    const float x18 = wL[13] + wR[13];
    const float x19 = 0.0597614305F * vn[1];
    const float x20 = wL[15] + wR[15];
    const float x21 = 0.231455025F * x20;
    const float x22 = wL[10] + wR[10];
    const float x23 = 0.188982236F * x22;
    const float x24 = wL[12] + wR[12];
    const float x25 = 0.146385011F * x24;
    const float x26 = wL[14] + wR[14];
    const float x27 = 0.188982236F * x26;
    const float x28 = 0.239045722F * vn[2];
    const float x29 = 0.207019668F * vn[0];
    const float x30 = 0.207019668F * vn[1];
    const float x31 = 0.253546276F * vn[2];
    const float x32 = wL[16] + wR[16];
    const float x33 = 0.23570226F * x32;
    const float x34 = wL[18] + wR[18];
    const float x35 = vn[0] * x34;
    const float x36 = wL[22] + wR[22];
    const float x37 = vn[1] * x36;
    const float x38 = wL[24] + wR[24];
    const float x39 = 0.23570226F * x38;
    const float x40 = 0.231455025F * x9;
    const float x41 = wL[17] + wR[17];
    const float x42 = 0.166666667F * vn[2];
    const float x43 = 0.204124145F * x41;
    const float x44 = wL[19] + wR[19];
    const float x45 = 0.077151675F * vn[0];
    const float x46 = 0.188982236F * x11;
    const float x47 = wL[21] + wR[21];
    const float x48 = 0.077151675F * vn[1];
    const float x49 = wL[23] + wR[23];
    const float x50 = 0.204124145F * x49;
    const float x51 = 0.188982236F * x13;
    const float x52 = 0.21821789F * vn[2];
    const float x53 = 0.188982236F * vn[2];
    const float x54 = wL[20] + wR[20];
    const float x55 = 0.15430335F * x54;
    const float x56 = 0.243975018F * vn[2];
    const float x57 = 0.199204768F * vn[0];
    const float x58 = 0.199204768F * vn[1];
    const float x59 = 0.251976315F * vn[2];
    const float x60 = vn[0] * x36;
    const float x61 = vn[1] * x34;
    const float x62 = 0.238365647F * wL[25] + 0.238365647F * wR[25];
    const float x63 = wL[27] + wR[27];
    const float x64 = vn[0] * x63;
    const float x65 = vn[0] * x16;
    const float x66 = vn[1] * x20;
    const float x67 = wL[33] + wR[33];
    const float x68 = vn[1] * x67;
    const float x69 = 0.238365647F * wL[35] + 0.238365647F * wR[35];
    const float x70 = wL[26] + wR[26];
    const float x71 = 0.150755672F * vn[2];
    const float x72 = 0.213200716F * x70;
    const float x73 = wL[28] + wR[28];
    const float x74 = vn[0] * x73;
    const float x75 = 0.204124145F * x26;
    const float x76 = wL[32] + wR[32];
    const float x77 = vn[1] * x76;
    const float x78 = wL[34] + wR[34];
    const float x79 = 0.213200716F * x78;
    const float x80 = 0.201007563F * vn[2];
    const float x81 = 0.17251639F * x14;
    const float x82 = wL[29] + wR[29];
    const float x83 = 0.087038828F * vn[0];
    const float x84 = 0.17251639F * x18;
    const float x85 = wL[31] + wR[31];
    const float x86 = 0.087038828F * vn[1];
    const float x87 = 0.230283093F * vn[2];
    const float x88 = wL[30] + wR[30];
    const float x89 = 0.158910432F * x88;
    const float x90 = 0.246182982F * vn[2];
    const float x91 = 0.194624736F * vn[0];
    const float x92 = 0.194624736F * vn[1];
    const float x93 = 0.251259454F * vn[2];
    const float x94 = vn[1] * x73;
    const float x95 = vn[0] * x20;
    const float x96 = vn[1] * x63;
    const float x97 = vn[1] * x38;
    const float x98 = vn[1] * x49;
    const float x99 = 0.162834737F * x44;
    const float x100 = 0.162834737F * x47;
    const float x101 = vn[0] * x49;
    const float x102 = vn[1] * x41;
    const float x103 = vn[0] * x38;
    flux[0] = 0.288675135F * vn[2] * x4 + 0.5F * wL[0] - 0.5F * wR[0] -
              x0 * x1 - x2 * x3;
    flux[1] = 0.129099445F * vn[1] * x8 + 0.5F * wL[1] - 0.5F * wR[1] +
              x10 * x9 + x11 * x12 - x3 * x7 - x5 * x6;
    flux[2] = 0.288675135F * vn[2] * x7 + 0.25819889F * vn[2] * x8 +
              0.5F * wL[2] - 0.5F * wR[2] - x10 * x11 - x13 * x6;
    flux[3] = 0.129099445F * vn[0] * x8 + 0.223606798F * vn[2] * x13 +
              0.5F * wL[3] - 0.5F * wR[3] - x1 * x7 - x10 * x5 - x6 * x9;
    flux[4] = -vn[0] * x17 + vn[1] * x21 + vn[2] * x23 + 0.5F * wL[4] -
              0.5F * wR[4] - x0 * x10 + x14 * x15 + x18 * x19 - x2 * x6;
    flux[5] = -vn[0] * x23 + vn[1] * x25 + vn[1] * x27 + 0.5F * wL[5] -
              0.5F * wR[5] - x10 * x4 + x12 * x2 + x14 * x28;
    flux[6] = 0.129099445F * vn[0] * x0 + 0.129099445F * vn[1] * x2 +
              0.25819889F * vn[2] * x4 + 0.5F * wL[6] - 0.5F * wR[6] -
              x14 * x30 - x18 * x29 + x24 * x31;
    flux[7] = vn[0] * x25 - vn[0] * x27 - vn[1] * x23 + 0.5F * wL[7] -
              0.5F * wR[7] + x0 * x12 + x18 * x28 - x4 * x6;
    flux[8] = 0.0597614305F * vn[0] * x18 - vn[0] * x21 - vn[1] * x17 +
              0.223606798F * vn[1] * x2 + 0.188982236F * vn[2] * x26 +
              0.5F * wL[8] - 0.5F * wR[8] - x0 * x6 - x14 * x19;
    flux[9] = -vn[0] * x33 - 0.231455025F * vn[0] * x5 + vn[1] * x39 -
              vn[1] * x40 + 0.5F * wL[9] - 0.5F * wR[9] + 0.0445435403F * x35 +
              0.0445435403F * x37 + x41 * x42;
    flux[10] = -vn[0] * x43 - vn[0] * x46 + vn[1] * x50 - vn[1] * x51 +
               0.5F * wL[10] - 0.5F * wR[10] + x34 * x52 + x44 * x45 +
               x47 * x48 + x5 * x53;
    flux[11] = vn[1] * x55 + 0.5F * wL[11] - 0.5F * wR[11] + x11 * x28 +
               x15 * x5 - x19 * x9 - x30 * x8 - 0.17251639F * x35 +
               0.17251639F * x37 + x44 * x56;
    flux[12] = 0.146385011F * vn[0] * x13 + 0.146385011F * vn[1] * x11 +
               0.5F * wL[12] - 0.5F * wR[12] + x31 * x8 - x44 * x58 -
               x47 * x57 + x54 * x59;
    flux[13] = vn[0] * x55 + 0.5F * wL[13] - 0.5F * wR[13] + x13 * x28 +
               x15 * x9 + x19 * x5 - x29 * x8 + x47 * x56 - 0.17251639F * x60 -
               0.17251639F * x61;
    flux[14] = -vn[0] * x50 - vn[0] * x51 - vn[1] * x43 + vn[1] * x46 +
               0.5F * wL[14] - 0.5F * wR[14] + x36 * x52 - x44 * x48 +
               x45 * x47 + x53 * x9;
    flux[15] = 0.0445435403F * vn[0] * x36 - vn[0] * x39 - vn[0] * x40 -
               vn[1] * x33 + 0.231455025F * vn[1] * x5 +
               0.166666667F * vn[2] * x49 + 0.5F * wL[15] - 0.5F * wR[15] -
               0.0445435403F * x61;
    flux[16] = -vn[0] * x62 + vn[1] * x69 + 0.5F * wL[16] - 0.5F * wR[16] +
               0.0355334527F * x64 - 0.23570226F * x65 - 0.23570226F * x66 +
               0.0355334527F * x68 + x70 * x71;
    flux[17] = -0.204124145F * vn[0] * x22 - vn[0] * x72 - vn[1] * x75 +
               vn[1] * x79 + 0.5F * wL[17] - 0.5F * wR[17] + x16 * x42 +
               x63 * x80 + 0.0615457455F * x74 + 0.0615457455F * x77;
    flux[18] = -vn[0] * x81 - vn[1] * x84 + 0.5F * wL[18] - 0.5F * wR[18] +
               x22 * x52 - 0.188025358F * x64 + 0.0445435403F * x65 -
               0.0445435403F * x66 + 0.188025358F * x68 + x73 * x87 +
               x82 * x83 + x85 * x86;
    flux[19] = vn[1] * x89 + 0.5F * wL[19] - 0.5F * wR[19] + x14 * x56 +
               x22 * x45 - x24 * x58 - x26 * x48 - 0.162834737F * x74 +
               0.162834737F * x77 + x82 * x90;
    flux[20] = 0.15430335F * vn[0] * x18 + 0.15430335F * vn[1] * x14 +
               0.5F * wL[20] - 0.5F * wR[20] + x24 * x59 - x82 * x92 -
               x85 * x91 + x88 * x93;
    flux[21] = -0.162834737F * vn[0] * x76 + vn[0] * x89 + 0.5F * wL[21] -
               0.5F * wR[21] + x18 * x56 + x22 * x48 - x24 * x57 + x26 * x45 +
               x85 * x90 - 0.162834737F * x94;
    flux[22] = -0.188025358F * vn[0] * x67 - vn[0] * x84 +
               0.0445435403F * vn[1] * x16 + vn[1] * x81 + 0.5F * wL[22] -
               0.5F * wR[22] + x26 * x52 + x76 * x87 - x82 * x86 + x83 * x85 +
               0.0445435403F * x95 - 0.188025358F * x96;
    flux[23] = -vn[0] * x75 + 0.0615457455F * vn[0] * x76 - vn[0] * x79 +
               0.204124145F * vn[1] * x22 - vn[1] * x72 +
               0.166666667F * vn[2] * x20 + 0.201007563F * vn[2] * x67 +
               0.5F * wL[23] - 0.5F * wR[23] - 0.0615457455F * x94;
    flux[24] = 0.0355334527F * vn[0] * x67 - vn[0] * x69 +
               0.23570226F * vn[1] * x16 - vn[1] * x62 +
               0.150755672F * vn[2] * x78 + 0.5F * wL[24] - 0.5F * wR[24] -
               0.23570226F * x95 - 0.0355334527F * x96;
    flux[25] = -0.238365647F * vn[0] * x32 + 0.5F * wL[25] - 0.5F * wR[25] -
               0.238365647F * x97;
    flux[26] = -0.213200716F * vn[0] * x41 + 0.150755672F * vn[2] * x32 +
               0.5F * wL[26] - 0.5F * wR[26] - 0.213200716F * x98;
    flux[27] = 0.0355334527F * vn[0] * x32 + 0.201007563F * vn[2] * x41 +
               0.5F * wL[27] - 0.5F * wR[27] - 0.188025358F * x35 -
               0.188025358F * x37 - 0.0355334527F * x97;
    flux[28] = 0.0615457455F * vn[0] * x41 - vn[0] * x99 - vn[1] * x100 +
               0.230283093F * vn[2] * x34 + 0.5F * wL[28] - 0.5F * wR[28] -
               0.0615457455F * x98;
    flux[29] = 0.5F * wL[29] - 0.5F * wR[29] + 0.087038828F * x35 -
               0.087038828F * x37 + x44 * x90 - x54 * x92;
    flux[30] = 0.158910432F * vn[0] * x47 + 0.158910432F * vn[1] * x44 +
               0.5F * wL[30] - 0.5F * wR[30] + x54 * x93;
    flux[31] = 0.5F * wL[31] - 0.5F * wR[31] + x47 * x90 - x54 * x91 +
               0.087038828F * x60 + 0.087038828F * x61;
    flux[32] = -vn[0] * x100 + vn[1] * x99 + 0.5F * wL[32] - 0.5F * wR[32] +
               0.0615457455F * x101 + 0.0615457455F * x102 + x36 * x87;
    flux[33] = 0.0355334527F * vn[1] * x32 + 0.5F * wL[33] - 0.5F * wR[33] +
               0.0355334527F * x103 + x49 * x80 - 0.188025358F * x60 +
               0.188025358F * x61;
    flux[34] = 0.5F * wL[34] - 0.5F * wR[34] - 0.213200716F * x101 +
               0.213200716F * x102 + x38 * x71;
    flux[35] = 0.238365647F * vn[1] * x32 + 0.5F * wL[35] - 0.5F * wR[35] -
               0.238365647F * x103;
}

#endif
#endif
