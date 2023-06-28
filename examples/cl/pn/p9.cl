#ifndef P9_CL
#define P9_CL

#ifdef IS_2D

void src_beam(const float t, const float x[2], float w[55])
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
    w[21] = -0.00000000F * p0 - 0.00000000F * p1;
    w[22] = -0.00000000F * p0 - 0.00000000F * p1;
    w[23] = -0.00000000F * p0 - 0.00000000F * p1;
    w[24] = -0.00000000F * p0 - 0.00000000F * p1;
    w[25] = -0.00000000F * p0 - 0.00000000F * p1;
    w[26] = -0.00000000F * p0 - 0.00000000F * p1;
    w[27] = +0.05713608F * p0 + 0.05713608F * p1;
    w[28] = -0.00000000F * p0 - 0.00000000F * p1;
    w[29] = -0.00000000F * p0 - 0.00000000F * p1;
    w[30] = -0.00000000F * p0 - 0.00000000F * p1;
    w[31] = -0.00000000F * p0 - 0.00000000F * p1;
    w[32] = -0.00000000F * p0 - 0.00000000F * p1;
    w[33] = -0.00000000F * p0 - 0.00000000F * p1;
    w[34] = -0.00000000F * p0 - 0.00000000F * p1;
    w[35] = -0.04414290F * p0 - 0.04414290F * p1;
    w[36] = -0.00000000F * p0 - 0.00000000F * p1;
    w[37] = -0.00000000F * p0 - 0.00000000F * p1;
    w[38] = -0.00000000F * p0 - 0.00000000F * p1;
    w[39] = -0.00000000F * p0 - 0.00000000F * p1;
    w[40] = -0.00000000F * p0 - 0.00000000F * p1;
    w[41] = -0.00000000F * p0 - 0.00000000F * p1;
    w[42] = -0.00000000F * p0 - 0.00000000F * p1;
    w[43] = -0.00000000F * p0 - 0.00000000F * p1;
    w[44] = +0.03246766F * p0 + 0.03246766F * p1;
    w[45] = -0.00000000F * p0 - 0.00000000F * p1;
    w[46] = -0.00000000F * p0 - 0.00000000F * p1;
    w[47] = -0.00000000F * p0 - 0.00000000F * p1;
    w[48] = -0.00000000F * p0 - 0.00000000F * p1;
    w[49] = -0.00000000F * p0 - 0.00000000F * p1;
    w[50] = -0.00000000F * p0 - 0.00000000F * p1;
    w[51] = -0.00000000F * p0 - 0.00000000F * p1;
    w[52] = -0.00000000F * p0 - 0.00000000F * p1;
    w[53] = -0.00000000F * p0 - 0.00000000F * p1;
    w[54] = -0.02275485F * p0 - 0.02275485F * p1;
}

void num_flux_rus(const float wL[55], const float wR[55], const float vn[2],
                  float flux[55])
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
    const float x28 = wL[15] + wR[15];
    const float x29 = 0.238365647F * x28;
    const float x30 = wL[16] + wR[16];
    const float x31 = wL[19] + wR[19];
    const float x32 = wL[20] + wR[20];
    const float x33 = vn[1] * x14;
    const float x34 = vn[0] * x30;
    const float x35 = wL[17] + wR[17];
    const float x36 = 0.17251639F * x11;
    const float x37 = wL[18] + wR[18];
    const float x38 = 0.17251639F * x13;
    const float x39 = 0.194624736F * vn[0];
    const float x40 = 0.194624736F * vn[1];
    const float x41 = vn[0] * x31;
    const float x42 = vn[0] * x14;
    const float x43 = vn[1] * x30;
    const float x44 = vn[0] * x18;
    const float x45 = wL[21] + wR[21];
    const float x46 = 0.240192231F * x45;
    const float x47 = wL[22] + wR[22];
    const float x48 = vn[1] * x22;
    const float x49 = wL[26] + wR[26];
    const float x50 = wL[27] + wR[27];
    const float x51 = vn[0] * x47;
    const float x52 = wL[23] + wR[23];
    const float x53 = vn[0] * x52;
    const float x54 = vn[1] * x21;
    const float x55 = wL[25] + wR[25];
    const float x56 = vn[1] * x55;
    const float x57 = vn[1] * x49;
    const float x58 = wL[24] + wR[24];
    const float x59 = vn[0] * x55;
    const float x60 = vn[1] * x52;
    const float x61 = vn[0] * x49;
    const float x62 = vn[1] * x47;
    const float x63 = vn[0] * x28;
    const float x64 = wL[28] + wR[28];
    const float x65 = 0.241522946F * x64;
    const float x66 = wL[29] + wR[29];
    const float x67 = vn[1] * x32;
    const float x68 = wL[34] + wR[34];
    const float x69 = wL[35] + wR[35];
    const float x70 = vn[0] * x66;
    const float x71 = wL[30] + wR[30];
    const float x72 = vn[0] * x71;
    const float x73 = vn[1] * x31;
    const float x74 = wL[33] + wR[33];
    const float x75 = vn[1] * x74;
    const float x76 = vn[1] * x68;
    const float x77 = wL[31] + wR[31];
    const float x78 = 0.156446555F * x37;
    const float x79 = wL[32] + wR[32];
    const float x80 = 0.0980580676F * vn[1];
    const float x81 = 0.189466187F * vn[0];
    const float x82 = 0.189466187F * vn[1];
    const float x83 = vn[0] * x74;
    const float x84 = vn[1] * x71;
    const float x85 = vn[0] * x68;
    const float x86 = vn[1] * x66;
    const float x87 = vn[0] * x45;
    const float x88 = wL[36] + wR[36];
    const float x89 = 0.242535625F * x88;
    const float x90 = wL[37] + wR[37];
    const float x91 = vn[1] * x50;
    const float x92 = wL[43] + wR[43];
    const float x93 = wL[44] + wR[44];
    const float x94 = vn[0] * x90;
    const float x95 = wL[38] + wR[38];
    const float x96 = vn[0] * x95;
    const float x97 = wL[42] + wR[42];
    const float x98 = vn[1] * x97;
    const float x99 = vn[1] * x92;
    const float x100 = wL[39] + wR[39];
    const float x101 = vn[0] * x100;
    const float x102 = wL[41] + wR[41];
    const float x103 = vn[1] * x102;
    const float x104 = wL[40] + wR[40];
    const float x105 = vn[0] * x102;
    const float x106 = vn[1] * x100;
    const float x107 = vn[0] * x97;
    const float x108 = vn[1] * x95;
    const float x109 = vn[0] * x92;
    const float x110 = vn[1] * x90;
    const float x111 = vn[0] * x64;
    const float x112 = 0.243332132F * wL[45] + 0.243332132F * wR[45];
    const float x113 = wL[46] + wR[46];
    const float x114 = vn[1] * x69;
    const float x115 = wL[53] + wR[53];
    const float x116 = wL[54] + wR[54];
    const float x117 = wL[47] + wR[47];
    const float x118 = vn[0] * x117;
    const float x119 = wL[52] + wR[52];
    const float x120 = vn[1] * x119;
    const float x121 = wL[48] + wR[48];
    const float x122 = vn[0] * x121;
    const float x123 = wL[51] + wR[51];
    const float x124 = vn[1] * x123;
    const float x125 = wL[49] + wR[49];
    const float x126 = 0.148522131F * x79;
    const float x127 = wL[50] + wR[50];
    const float x128 = 0.104095693F * vn[1];
    const float x129 = 0.186627226F * vn[0];
    const float x130 = 0.186627226F * vn[1];
    const float x131 = vn[1] * x121;
    const float x132 = vn[1] * x117;
    const float x133 = vn[1] * x113;
    const float x134 = vn[1] * x93;
    const float x135 = vn[0] * x93;
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
    flux[10] = -vn[0] * x29 + 0.0355334527F * vn[0] * x30 -
               0.23570226F * vn[0] * x9 + 0.0355334527F * vn[1] * x31 +
               0.238365647F * vn[1] * x32 + 0.5F * wL[10] - 0.5F * wR[10] -
               0.23570226F * x33;
    flux[11] = 0.087038828F * vn[0] * x35 - vn[0] * x36 +
               0.0445435403F * vn[0] * x9 + 0.188025358F * vn[1] * x31 +
               0.087038828F * vn[1] * x37 - vn[1] * x38 + 0.5F * wL[11] -
               0.5F * wR[11] - 0.0445435403F * x33 - 0.188025358F * x34;
    flux[12] = 0.15430335F * vn[0] * x13 + 0.15430335F * vn[1] * x11 +
               0.5F * wL[12] - 0.5F * wR[12] - x35 * x40 - x37 * x39;
    flux[13] = 0.087038828F * vn[0] * x37 - vn[0] * x38 -
               0.087038828F * vn[1] * x35 + vn[1] * x36 +
               0.0445435403F * vn[1] * x9 + 0.5F * wL[13] - 0.5F * wR[13] -
               0.188025358F * x41 + 0.0445435403F * x42 - 0.188025358F * x43;
    flux[14] = 0.0355334527F * vn[0] * x31 - 0.238365647F * vn[0] * x32 -
               vn[1] * x29 + 0.23570226F * vn[1] * x9 + 0.5F * wL[14] -
               0.5F * wR[14] - 0.23570226F * x42 - 0.0355334527F * x43;
    flux[15] = -vn[0] * x46 + 0.0295656198F * vn[0] * x47 +
               0.0295656198F * vn[1] * x49 + 0.240192231F * vn[1] * x50 +
               0.5F * wL[15] - 0.5F * wR[15] - 0.238365647F * x44 -
               0.238365647F * x48;
    flux[16] = 0.5F * wL[16] - 0.5F * wR[16] - 0.188025358F * x24 +
               0.0355334527F * x44 - 0.0355334527F * x48 - 0.198332207F * x51 +
               0.0724206824F * x53 - 0.188025358F * x54 + 0.0724206824F * x56 +
               0.198332207F * x57;
    flux[17] = 0.161937569F * vn[1] * x58 + 0.5F * wL[17] - 0.5F * wR[17] +
               0.087038828F * x24 - x25 * x40 - 0.156446555F * x53 -
               0.087038828F * x54 + 0.156446555F * x56;
    flux[18] = 0.087038828F * vn[0] * x21 + 0.161937569F * vn[0] * x58 +
               0.087038828F * vn[1] * x20 + 0.5F * wL[18] - 0.5F * wR[18] -
               x25 * x39 - 0.156446555F * x59 - 0.156446555F * x60;
    flux[19] = 0.0355334527F * vn[0] * x22 + 0.0724206824F * vn[0] * x55 +
               0.0355334527F * vn[1] * x18 + 0.188025358F * vn[1] * x20 +
               0.5F * wL[19] - 0.5F * wR[19] - 0.188025358F * x26 -
               0.0724206824F * x60 - 0.198332207F * x61 - 0.198332207F * x62;
    flux[20] = -0.238365647F * vn[0] * x22 + 0.0295656198F * vn[0] * x49 -
               0.240192231F * vn[0] * x50 + 0.238365647F * vn[1] * x18 -
               vn[1] * x46 + 0.5F * wL[20] - 0.5F * wR[20] -
               0.0295656198F * x62;
    flux[21] = -vn[0] * x65 + 0.0253184842F * vn[0] * x66 +
               0.0253184842F * vn[1] * x68 + 0.241522946F * vn[1] * x69 +
               0.5F * wL[21] - 0.5F * wR[21] - 0.240192231F * x63 -
               0.240192231F * x67;
    flux[22] = 0.5F * wL[22] - 0.5F * wR[22] - 0.198332207F * x34 +
               0.0295656198F * x63 - 0.0295656198F * x67 - 0.205688338F * x70 +
               0.0620173673F * x72 - 0.198332207F * x73 + 0.0620173673F * x75 +
               0.205688338F * x76;
    flux[23] = -0.156446555F * vn[0] * x35 + 0.0980580676F * vn[0] * x77 -
               vn[1] * x78 + 0.5F * wL[23] - 0.5F * wR[23] +
               0.0724206824F * x34 - 0.169841555F * x72 - 0.0724206824F * x73 +
               0.169841555F * x75 + x79 * x80;
    flux[24] = 0.161937569F * vn[0] * x37 + 0.161937569F * vn[1] * x35 +
               0.5F * wL[24] - 0.5F * wR[24] - x77 * x82 - x79 * x81;
    flux[25] = 0.0724206824F * vn[0] * x31 - vn[0] * x78 +
               0.0980580676F * vn[0] * x79 + 0.0724206824F * vn[1] * x30 +
               0.156446555F * vn[1] * x35 + 0.5F * wL[25] - 0.5F * wR[25] -
               x77 * x80 - 0.169841555F * x83 - 0.169841555F * x84;
    flux[26] = 0.0295656198F * vn[0] * x32 + 0.0620173673F * vn[0] * x74 +
               0.0295656198F * vn[1] * x28 + 0.198332207F * vn[1] * x30 +
               0.5F * wL[26] - 0.5F * wR[26] - 0.198332207F * x41 -
               0.0620173673F * x84 - 0.205688338F * x85 - 0.205688338F * x86;
    flux[27] = -0.240192231F * vn[0] * x32 + 0.0253184842F * vn[0] * x68 -
               0.241522946F * vn[0] * x69 + 0.240192231F * vn[1] * x28 -
               vn[1] * x65 + 0.5F * wL[27] - 0.5F * wR[27] -
               0.0253184842F * x86;
    flux[28] = -vn[0] * x89 + 0.0221403721F * vn[0] * x90 +
               0.0221403721F * vn[1] * x92 + 0.242535625F * vn[1] * x93 +
               0.5F * wL[28] - 0.5F * wR[28] - 0.241522946F * x87 -
               0.241522946F * x91;
    flux[29] = 0.5F * wL[29] - 0.5F * wR[29] - 0.205688338F * x51 -
               0.205688338F * x57 + 0.0253184842F * x87 - 0.0253184842F * x91 -
               0.211205689F * x94 + 0.0542326145F * x96 + 0.0542326145F * x98 +
               0.211205689F * x99;
    flux[30] = 0.5F * wL[30] - 0.5F * wR[30] + 0.0857492926F * x101 +
               0.0857492926F * x103 + 0.0620173673F * x51 - 0.169841555F * x53 -
               0.169841555F * x56 - 0.0620173673F * x57 - 0.179869234F * x96 +
               0.179869234F * x98;
    flux[31] = 0.165683374F * vn[1] * x104 + 0.5F * wL[31] - 0.5F * wR[31] -
               0.148522131F * x101 + 0.148522131F * x103 + 0.0980580676F * x53 -
               0.0980580676F * x56 - x58 * x82;
    flux[32] = 0.165683374F * vn[0] * x104 + 0.0980580676F * vn[0] * x55 +
               0.0980580676F * vn[1] * x52 + 0.5F * wL[32] - 0.5F * wR[32] -
               0.148522131F * x105 - 0.148522131F * x106 - x58 * x81;
    flux[33] = 0.0857492926F * vn[0] * x102 + 0.0620173673F * vn[0] * x49 +
               0.0620173673F * vn[1] * x47 + 0.169841555F * vn[1] * x52 +
               0.5F * wL[33] - 0.5F * wR[33] - 0.0857492926F * x106 -
               0.179869234F * x107 - 0.179869234F * x108 - 0.169841555F * x59;
    flux[34] = 0.0253184842F * vn[0] * x50 + 0.0542326145F * vn[0] * x97 +
               0.0253184842F * vn[1] * x45 + 0.205688338F * vn[1] * x47 +
               0.5F * wL[34] - 0.5F * wR[34] - 0.0542326145F * x108 -
               0.211205689F * x109 - 0.211205689F * x110 - 0.205688338F * x61;
    flux[35] = -0.241522946F * vn[0] * x50 + 0.0221403721F * vn[0] * x92 -
               0.242535625F * vn[0] * x93 + 0.241522946F * vn[1] * x45 -
               vn[1] * x89 + 0.5F * wL[35] - 0.5F * wR[35] -
               0.0221403721F * x110;
    flux[36] = -vn[0] * x112 + 0.0196722369F * vn[0] * x113 +
               0.0196722369F * vn[1] * x115 + 0.243332132F * vn[1] * x116 +
               0.5F * wL[36] - 0.5F * wR[36] - 0.242535625F * x111 -
               0.242535625F * x114;
    flux[37] = -0.215498558F * vn[0] * x113 + 0.215498558F * vn[1] * x115 +
               0.5F * wL[37] - 0.5F * wR[37] + 0.0221403721F * x111 -
               0.0221403721F * x114 + 0.0481869425F * x118 +
               0.0481869425F * x120 - 0.211205689F * x70 - 0.211205689F * x76;
    flux[38] = 0.5F * wL[38] - 0.5F * wR[38] - 0.187661179F * x118 +
               0.187661179F * x120 + 0.0761902458F * x122 +
               0.0761902458F * x124 + 0.0542326145F * x70 - 0.179869234F * x72 -
               0.179869234F * x75 - 0.0542326145F * x76;
    flux[39] = 0.104095693F * vn[0] * x125 - 0.148522131F * vn[0] * x77 -
               vn[1] * x126 + 0.5F * wL[39] - 0.5F * wR[39] -
               0.159818008F * x122 + 0.159818008F * x124 + x127 * x128 +
               0.0857492926F * x72 - 0.0857492926F * x75;
    flux[40] = 0.165683374F * vn[0] * x79 + 0.165683374F * vn[1] * x77 +
               0.5F * wL[40] - 0.5F * wR[40] - x125 * x130 - x127 * x129;
    flux[41] = -0.159818008F * vn[0] * x123 - vn[0] * x126 +
               0.104095693F * vn[0] * x127 + 0.0857492926F * vn[0] * x74 +
               0.0857492926F * vn[1] * x71 + 0.148522131F * vn[1] * x77 +
               0.5F * wL[41] - 0.5F * wR[41] - x125 * x128 -
               0.159818008F * x131;
    flux[42] = -0.187661179F * vn[0] * x119 + 0.0761902458F * vn[0] * x123 +
               0.0542326145F * vn[0] * x68 + 0.0542326145F * vn[1] * x66 +
               0.179869234F * vn[1] * x71 + 0.5F * wL[42] - 0.5F * wR[42] -
               0.0761902458F * x131 - 0.187661179F * x132 - 0.179869234F * x83;
    flux[43] = -0.215498558F * vn[0] * x115 + 0.0481869425F * vn[0] * x119 +
               0.0221403721F * vn[0] * x69 + 0.0221403721F * vn[1] * x64 +
               0.211205689F * vn[1] * x66 + 0.5F * wL[43] - 0.5F * wR[43] -
               0.0481869425F * x132 - 0.215498558F * x133 - 0.211205689F * x85;
    flux[44] = 0.0196722369F * vn[0] * x115 - 0.243332132F * vn[0] * x116 -
               0.242535625F * vn[0] * x69 - vn[1] * x112 +
               0.242535625F * vn[1] * x64 + 0.5F * wL[44] - 0.5F * wR[44] -
               0.0196722369F * x133;
    flux[45] = -0.243332132F * vn[0] * x88 + 0.5F * wL[45] - 0.5F * wR[45] -
               0.243332132F * x134;
    flux[46] = 0.0196722369F * vn[0] * x88 + 0.5F * wL[46] - 0.5F * wR[46] -
               0.0196722369F * x134 - 0.215498558F * x94 - 0.215498558F * x99;
    flux[47] = 0.0481869425F * vn[0] * x90 + 0.5F * wL[47] - 0.5F * wR[47] -
               0.187661179F * x96 - 0.187661179F * x98 - 0.0481869425F * x99;
    flux[48] = 0.0761902458F * vn[0] * x95 + 0.5F * wL[48] - 0.5F * wR[48] -
               0.159818008F * x101 - 0.159818008F * x103 - 0.0761902458F * x98;
    flux[49] = 0.104095693F * vn[0] * x100 + 0.5F * wL[49] - 0.5F * wR[49] -
               0.104095693F * x103 - x104 * x130;
    flux[50] = 0.5F * wL[50] - 0.5F * wR[50] - x104 * x129 +
               0.104095693F * x105 + 0.104095693F * x106;
    flux[51] = 0.5F * wL[51] - 0.5F * wR[51] - 0.159818008F * x105 +
               0.159818008F * x106 + 0.0761902458F * x107 +
               0.0761902458F * x108;
    flux[52] = 0.5F * wL[52] - 0.5F * wR[52] - 0.187661179F * x107 +
               0.187661179F * x108 + 0.0481869425F * x109 +
               0.0481869425F * x110;
    flux[53] = 0.0196722369F * vn[1] * x88 + 0.5F * wL[53] - 0.5F * wR[53] -
               0.215498558F * x109 + 0.215498558F * x110 + 0.0196722369F * x135;
    flux[54] = 0.243332132F * vn[1] * x88 + 0.5F * wL[54] - 0.5F * wR[54] -
               0.243332132F * x135;
}

#else

void src_beam(const float t, const float x[3], float w[100])
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
    w[36] = +0.02690635F * p0 + 0.00001530F * p1;
    w[37] = -0.00000000F * p0 + 0.00013031F * p1;
    w[38] = -0.01935741F * p0 + 0.00072772F * p1;
    w[39] = -0.00000000F * p0 + 0.00304029F * p1;
    w[40] = +0.01752882F * p0 + 0.00989075F * p1;
    w[41] = -0.00000000F * p0 + 0.02505424F * p1;
    w[42] = -0.01708007F * p0 + 0.04726992F * p1;
    w[43] = -0.00000000F * p0 - 0.02505424F * p1;
    w[44] = +0.01752882F * p0 + 0.00989075F * p1;
    w[45] = -0.00000000F * p0 - 0.00304029F * p1;
    w[46] = -0.01935741F * p0 + 0.00072772F * p1;
    w[47] = -0.00000000F * p0 - 0.00013031F * p1;
    w[48] = +0.02690635F * p0 + 0.00001530F * p1;
    w[49] = +0.02042545F * p0 + 0.00000580F * p1;
    w[50] = -0.00000000F * p0 + 0.00005098F * p1;
    w[51] = -0.01446610F * p0 + 0.00029559F * p1;
    w[52] = -0.00000000F * p0 + 0.00129391F * p1;
    w[53] = +0.01294732F * p0 + 0.00447912F * p1;
    w[54] = -0.00000000F * p0 + 0.01242414F * p1;
    w[55] = -0.01243504F * p0 + 0.02728988F * p1;
    w[56] = -0.00000000F * p0 + 0.04521479F * p1;
    w[57] = +0.01243504F * p0 - 0.02728988F * p1;
    w[58] = -0.00000000F * p0 + 0.01242414F * p1;
    w[59] = -0.01294732F * p0 - 0.00447912F * p1;
    w[60] = -0.00000000F * p0 + 0.00129391F * p1;
    w[61] = +0.01446610F * p0 - 0.00029559F * p1;
    w[62] = -0.00000000F * p0 + 0.00005098F * p1;
    w[63] = -0.02042545F * p0 - 0.00000580F * p1;
    w[64] = +0.01477047F * p0 + 0.00000222F * p1;
    w[65] = -0.00000000F * p0 + 0.00002015F * p1;
    w[66] = -0.01028841F * p0 + 0.00012134F * p1;
    w[67] = -0.00000000F * p0 + 0.00055529F * p1;
    w[68] = +0.00912149F * p0 + 0.00203012F * p1;
    w[69] = -0.00000000F * p0 + 0.00604771F * p1;
    w[70] = -0.00868475F * p0 + 0.01470145F * p1;
    w[71] = -0.00000000F * p0 + 0.02866726F * p1;
    w[72] = +0.00856805F * p0 + 0.04272062F * p1;
    w[73] = -0.00000000F * p0 - 0.02866726F * p1;
    w[74] = -0.00868475F * p0 + 0.01470145F * p1;
    w[75] = -0.00000000F * p0 - 0.00604771F * p1;
    w[76] = +0.00912149F * p0 + 0.00203012F * p1;
    w[77] = -0.00000000F * p0 - 0.00055529F * p1;
    w[78] = -0.01028841F * p0 + 0.00012134F * p1;
    w[79] = -0.00000000F * p0 - 0.00002015F * p1;
    w[80] = +0.01477047F * p0 + 0.00000222F * p1;
    w[81] = +0.01018352F * p0 - 0.00000000F * p1;
    w[82] = -0.00000000F * p0 + 0.00000798F * p1;
    w[83] = -0.00696094F * p0 + 0.00004993F * p1;
    w[84] = -0.00000000F * p0 + 0.00023853F * p1;
    w[85] = +0.00611860F * p0 + 0.00091700F * p1;
    w[86] = -0.00000000F * p0 + 0.00290419F * p1;
    w[87] = -0.00579409F * p0 + 0.00763850F * p1;
    w[88] = -0.00000000F * p0 + 0.01661361F * p1;
    w[89] = +0.00567674F * p0 + 0.02931393F * p1;
    w[90] = -0.00000000F * p0 + 0.04010411F * p1;
    w[91] = -0.00567674F * p0 - 0.02931393F * p1;
    w[92] = -0.00000000F * p0 + 0.01661361F * p1;
    w[93] = +0.00579409F * p0 - 0.00763850F * p1;
    w[94] = -0.00000000F * p0 + 0.00290419F * p1;
    w[95] = -0.00611860F * p0 - 0.00091700F * p1;
    w[96] = -0.00000000F * p0 + 0.00023853F * p1;
    w[97] = +0.00696094F * p0 - 0.00004993F * p1;
    w[98] = -0.00000000F * p0 + 0.00000798F * p1;
    w[99] = -0.01018352F * p0 - 0.00000000F * p1;
}

void num_flux_rus(const float wL[100], const float wR[100], const float vn[3],
                  float flux[100])
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
    const float x62 = wL[25] + wR[25];
    const float x63 = 0.238365647F * x62;
    const float x64 = wL[27] + wR[27];
    const float x65 = vn[0] * x64;
    const float x66 = vn[0] * x16;
    const float x67 = vn[1] * x20;
    const float x68 = wL[33] + wR[33];
    const float x69 = vn[1] * x68;
    const float x70 = wL[35] + wR[35];
    const float x71 = 0.238365647F * x70;
    const float x72 = wL[26] + wR[26];
    const float x73 = 0.150755672F * vn[2];
    const float x74 = 0.213200716F * x72;
    const float x75 = wL[28] + wR[28];
    const float x76 = vn[0] * x75;
    const float x77 = 0.204124145F * x26;
    const float x78 = wL[32] + wR[32];
    const float x79 = vn[1] * x78;
    const float x80 = wL[34] + wR[34];
    const float x81 = 0.213200716F * x80;
    const float x82 = 0.201007563F * vn[2];
    const float x83 = 0.17251639F * x14;
    const float x84 = wL[29] + wR[29];
    const float x85 = 0.087038828F * vn[0];
    const float x86 = 0.17251639F * x18;
    const float x87 = wL[31] + wR[31];
    const float x88 = 0.087038828F * vn[1];
    const float x89 = 0.230283093F * vn[2];
    const float x90 = wL[30] + wR[30];
    const float x91 = 0.158910432F * x90;
    const float x92 = 0.246182982F * vn[2];
    const float x93 = 0.194624736F * vn[0];
    const float x94 = 0.194624736F * vn[1];
    const float x95 = 0.251259454F * vn[2];
    const float x96 = vn[0] * x78;
    const float x97 = vn[1] * x75;
    const float x98 = vn[0] * x20;
    const float x99 = vn[0] * x68;
    const float x100 = vn[1] * x64;
    const float x101 = vn[0] * x32;
    const float x102 = wL[36] + wR[36];
    const float x103 = 0.240192231F * x102;
    const float x104 = wL[38] + wR[38];
    const float x105 = vn[0] * x104;
    const float x106 = vn[1] * x38;
    const float x107 = wL[46] + wR[46];
    const float x108 = vn[1] * x107;
    const float x109 = wL[48] + wR[48];
    const float x110 = 0.240192231F * x109;
    const float x111 = wL[37] + wR[37];
    const float x112 = 0.138675049F * vn[2];
    const float x113 = vn[0] * x41;
    const float x114 = 0.219264505F * x111;
    const float x115 = wL[39] + wR[39];
    const float x116 = vn[0] * x115;
    const float x117 = vn[1] * x49;
    const float x118 = wL[45] + wR[45];
    const float x119 = vn[1] * x118;
    const float x120 = wL[47] + wR[47];
    const float x121 = 0.219264505F * x120;
    const float x122 = 0.186989398F * vn[2];
    const float x123 = wL[40] + wR[40];
    const float x124 = vn[0] * x123;
    const float x125 = wL[44] + wR[44];
    const float x126 = vn[1] * x125;
    const float x127 = 0.217262047F * vn[2];
    const float x128 = 0.162834737F * x44;
    const float x129 = wL[41] + wR[41];
    const float x130 = 0.093494699F * vn[0];
    const float x131 = 0.162834737F * x47;
    const float x132 = wL[43] + wR[43];
    const float x133 = 0.093494699F * vn[1];
    const float x134 = 0.236524958F * vn[2];
    const float x135 = wL[42] + wR[42];
    const float x136 = 0.161937569F * x135;
    const float x137 = 0.247363722F * vn[2];
    const float x138 = 0.191607115F * vn[0];
    const float x139 = 0.191607115F * vn[1];
    const float x140 = 0.250872603F * vn[2];
    const float x141 = vn[0] * x125;
    const float x142 = vn[1] * x123;
    const float x143 = vn[0] * x49;
    const float x144 = vn[0] * x118;
    const float x145 = vn[1] * x115;
    const float x146 = vn[0] * x38;
    const float x147 = vn[0] * x107;
    const float x148 = vn[1] * x104;
    const float x149 = vn[0] * x62;
    const float x150 = wL[49] + wR[49];
    const float x151 = 0.241522946F * x150;
    const float x152 = wL[51] + wR[51];
    const float x153 = vn[0] * x152;
    const float x154 = vn[1] * x70;
    const float x155 = wL[61] + wR[61];
    const float x156 = vn[1] * x155;
    const float x157 = wL[63] + wR[63];
    const float x158 = 0.241522946F * x157;
    const float x159 = wL[50] + wR[50];
    const float x160 = 0.129099445F * vn[2];
    const float x161 = vn[0] * x72;
    const float x162 = wL[52] + wR[52];
    const float x163 = vn[0] * x162;
    const float x164 = vn[1] * x80;
    const float x165 = wL[60] + wR[60];
    const float x166 = vn[1] * x165;
    const float x167 = wL[62] + wR[62];
    const float x168 = 0.175411604F * vn[2];
    const float x169 = wL[53] + wR[53];
    const float x170 = vn[0] * x169;
    const float x171 = wL[59] + wR[59];
    const float x172 = vn[1] * x171;
    const float x173 = 0.205688338F * vn[2];
    const float x174 = wL[54] + wR[54];
    const float x175 = vn[0] * x174;
    const float x176 = wL[58] + wR[58];
    const float x177 = vn[1] * x176;
    const float x178 = 0.226455407F * vn[2];
    const float x179 = 0.156446555F * x84;
    const float x180 = wL[55] + wR[55];
    const float x181 = 0.0980580676F * vn[0];
    const float x182 = 0.156446555F * x87;
    const float x183 = wL[57] + wR[57];
    const float x184 = 0.0980580676F * vn[1];
    const float x185 = 0.240192231F * vn[2];
    const float x186 = wL[56] + wR[56];
    const float x187 = 0.164082531F * x186;
    const float x188 = 0.248069469F * vn[2];
    const float x189 = 0.189466187F * vn[0];
    const float x190 = 0.189466187F * vn[1];
    const float x191 = 0.250640206F * vn[2];
    const float x192 = vn[0] * x176;
    const float x193 = vn[1] * x174;
    const float x194 = vn[0] * x171;
    const float x195 = vn[1] * x169;
    const float x196 = vn[0] * x80;
    const float x197 = vn[0] * x165;
    const float x198 = vn[1] * x162;
    const float x199 = vn[0] * x70;
    const float x200 = vn[0] * x155;
    const float x201 = vn[1] * x152;
    const float x202 = vn[0] * x102;
    const float x203 = wL[64] + wR[64];
    const float x204 = 0.242535625F * x203;
    const float x205 = wL[66] + wR[66];
    const float x206 = vn[0] * x205;
    const float x207 = vn[1] * x109;
    const float x208 = wL[78] + wR[78];
    const float x209 = vn[1] * x208;
    const float x210 = wL[80] + wR[80];
    const float x211 = 0.242535625F * x210;
    const float x212 = wL[65] + wR[65];
    const float x213 = 0.121267813F * vn[2];
    const float x214 = 0.226871303F * x212;
    const float x215 = wL[67] + wR[67];
    const float x216 = vn[0] * x215;
    const float x217 = wL[77] + wR[77];
    const float x218 = vn[1] * x217;
    const float x219 = wL[79] + wR[79];
    const float x220 = 0.226871303F * x219;
    const float x221 = 0.165683374F * vn[2];
    const float x222 = wL[68] + wR[68];
    const float x223 = vn[0] * x222;
    const float x224 = wL[76] + wR[76];
    const float x225 = vn[1] * x224;
    const float x226 = 0.195538472F * x215;
    const float x227 = 0.043852901F * vn[0];
    const float x228 = wL[69] + wR[69];
    const float x229 = vn[0] * x228;
    const float x230 = 0.043852901F * vn[1];
    const float x231 = wL[75] + wR[75];
    const float x232 = vn[1] * x231;
    const float x233 = 0.216930458F * vn[2];
    const float x234 = wL[70] + wR[70];
    const float x235 = vn[0] * x234;
    const float x236 = wL[74] + wR[74];
    const float x237 = vn[1] * x236;
    const float x238 = 0.232210182F * vn[2];
    const float x239 = 0.151910905F * x129;
    const float x240 = wL[71] + wR[71];
    const float x241 = 0.101459931F * vn[0];
    const float x242 = 0.151910905F * x132;
    const float x243 = wL[73] + wR[73];
    const float x244 = 0.101459931F * vn[1];
    const float x245 = 0.242535625F * vn[2];
    const float x246 = wL[72] + wR[72];
    const float x247 = 0.165683374F * x246;
    const float x248 = 0.248525061F * vn[2];
    const float x249 = 0.187867287F * vn[0];
    const float x250 = 0.187867287F * vn[1];
    const float x251 = 0.250489716F * vn[2];
    const float x252 = vn[0] * x236;
    const float x253 = vn[1] * x234;
    const float x254 = vn[0] * x231;
    const float x255 = vn[1] * x228;
    const float x256 = vn[0] * x224;
    const float x257 = vn[1] * x222;
    const float x258 = 0.195538472F * x217;
    const float x259 = vn[0] * x109;
    const float x260 = vn[0] * x208;
    const float x261 = vn[1] * x205;
    const float x262 = 0.0383482494F * vn[1];
    const float x263 = vn[0] * x150;
    const float x264 = 0.243332132F * wL[81] + 0.243332132F * wR[81];
    const float x265 = wL[83] + wR[83];
    const float x266 = vn[0] * x265;
    const float x267 = vn[1] * x157;
    const float x268 = wL[97] + wR[97];
    const float x269 = vn[1] * x268;
    const float x270 = 0.243332132F * wL[99] + 0.243332132F * wR[99];
    const float x271 = wL[82] + wR[82];
    const float x272 = 0.114707867F * vn[2];
    const float x273 = 0.229415734F * x271;
    const float x274 = wL[84] + wR[84];
    const float x275 = vn[0] * x274;
    const float x276 = 0.226871303F * x167;
    const float x277 = wL[96] + wR[96];
    const float x278 = vn[1] * x277;
    const float x279 = wL[98] + wR[98];
    const float x280 = 0.229415734F * x279;
    const float x281 = 0.157377895F * vn[2];
    const float x282 = wL[85] + wR[85];
    const float x283 = vn[0] * x282;
    const float x284 = wL[95] + wR[95];
    const float x285 = vn[1] * x284;
    const float x286 = 0.186627226F * vn[2];
    const float x287 = 0.0383482494F * vn[0];
    const float x288 = wL[86] + wR[86];
    const float x289 = vn[0] * x288;
    const float x290 = wL[94] + wR[94];
    const float x291 = vn[1] * x290;
    const float x292 = 0.195538472F * vn[2];
    const float x293 = 0.208191386F * vn[2];
    const float x294 = wL[87] + wR[87];
    const float x295 = vn[0] * x294;
    const float x296 = wL[93] + wR[93];
    const float x297 = vn[1] * x296;
    const float x298 = 0.224298011F * vn[2];
    const float x299 = wL[88] + wR[88];
    const float x300 = vn[0] * x299;
    const float x301 = wL[92] + wR[92];
    const float x302 = vn[1] * x301;
    const float x303 = 0.236066843F * vn[2];
    const float x304 = 0.148522131F * x180;
    const float x305 = wL[89] + wR[89];
    const float x306 = 0.104095693F * vn[0];
    const float x307 = 0.148522131F * x183;
    const float x308 = wL[91] + wR[91];
    const float x309 = 0.104095693F * vn[1];
    const float x310 = 0.24412604F * vn[2];
    const float x311 = wL[90] + wR[90];
    const float x312 = 0.166924465F * x311;
    const float x313 = 0.248836301F * vn[2];
    const float x314 = 0.186627226F * vn[0];
    const float x315 = 0.186627226F * vn[1];
    const float x316 = 0.250386698F * vn[2];
    const float x317 = vn[0] * x301;
    const float x318 = vn[1] * x299;
    const float x319 = vn[0] * x296;
    const float x320 = vn[1] * x294;
    const float x321 = vn[0] * x290;
    const float x322 = vn[1] * x288;
    const float x323 = vn[0] * x284;
    const float x324 = vn[1] * x282;
    const float x325 = vn[1] * x274;
    const float x326 = vn[0] * x157;
    const float x327 = vn[1] * x265;
    const float x328 = vn[1] * x210;
    const float x329 = vn[1] * x219;
    const float x330 = 0.145893213F * x240;
    const float x331 = 0.145893213F * x243;
    const float x332 = vn[0] * x217;
    const float x333 = vn[1] * x215;
    const float x334 = vn[0] * x219;
    const float x335 = vn[1] * x212;
    const float x336 = vn[0] * x210;
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
    flux[16] = -vn[0] * x63 + vn[1] * x71 + 0.5F * wL[16] - 0.5F * wR[16] +
               0.0355334527F * x65 - 0.23570226F * x66 - 0.23570226F * x67 +
               0.0355334527F * x69 + x72 * x73;
    flux[17] = -0.204124145F * vn[0] * x22 - vn[0] * x74 - vn[1] * x77 +
               vn[1] * x81 + 0.5F * wL[17] - 0.5F * wR[17] + x16 * x42 +
               x64 * x82 + 0.0615457455F * x76 + 0.0615457455F * x79;
    flux[18] = -vn[0] * x83 - vn[1] * x86 + 0.5F * wL[18] - 0.5F * wR[18] +
               x22 * x52 - 0.188025358F * x65 + 0.0445435403F * x66 -
               0.0445435403F * x67 + 0.188025358F * x69 + x75 * x89 +
               x84 * x85 + x87 * x88;
    flux[19] = vn[1] * x91 + 0.5F * wL[19] - 0.5F * wR[19] + x14 * x56 +
               x22 * x45 - x24 * x58 - x26 * x48 - 0.162834737F * x76 +
               0.162834737F * x79 + x84 * x92;
    flux[20] = 0.15430335F * vn[0] * x18 + 0.15430335F * vn[1] * x14 +
               0.5F * wL[20] - 0.5F * wR[20] + x24 * x59 - x84 * x94 -
               x87 * x93 + x90 * x95;
    flux[21] = vn[0] * x91 + 0.5F * wL[21] - 0.5F * wR[21] + x18 * x56 +
               x22 * x48 - x24 * x57 + x26 * x45 + x87 * x92 -
               0.162834737F * x96 - 0.162834737F * x97;
    flux[22] = -vn[0] * x86 + 0.0445435403F * vn[1] * x16 + vn[1] * x83 +
               0.5F * wL[22] - 0.5F * wR[22] - 0.188025358F * x100 + x26 * x52 +
               x78 * x89 - x84 * x88 + x85 * x87 + 0.0445435403F * x98 -
               0.188025358F * x99;
    flux[23] = -vn[0] * x77 + 0.0615457455F * vn[0] * x78 - vn[0] * x81 +
               0.204124145F * vn[1] * x22 - vn[1] * x74 +
               0.166666667F * vn[2] * x20 + 0.201007563F * vn[2] * x68 +
               0.5F * wL[23] - 0.5F * wR[23] - 0.0615457455F * x97;
    flux[24] = 0.0355334527F * vn[0] * x68 - vn[0] * x71 +
               0.23570226F * vn[1] * x16 - vn[1] * x63 +
               0.150755672F * vn[2] * x80 + 0.5F * wL[24] - 0.5F * wR[24] -
               0.0355334527F * x100 - 0.23570226F * x98;
    flux[25] = -vn[0] * x103 + vn[1] * x110 + 0.5F * wL[25] - 0.5F * wR[25] -
               0.238365647F * x101 + 0.0295656198F * x105 -
               0.238365647F * x106 + 0.0295656198F * x108 + x111 * x112;
    flux[26] = -vn[0] * x114 + vn[1] * x121 + 0.5F * wL[26] - 0.5F * wR[26] +
               x104 * x122 - 0.213200716F * x113 + 0.0512091557F * x116 -
               0.213200716F * x117 + 0.0512091557F * x119 + x32 * x73;
    flux[27] = 0.5F * wL[27] - 0.5F * wR[27] + 0.0355334527F * x101 -
               0.198332207F * x105 - 0.0355334527F * x106 +
               0.198332207F * x108 + x115 * x127 + 0.0724206824F * x124 +
               0.0724206824F * x126 - 0.188025358F * x35 - 0.188025358F * x37 +
               x41 * x82;
    flux[28] = -vn[0] * x128 - vn[1] * x131 + 0.5F * wL[28] - 0.5F * wR[28] +
               0.0615457455F * x113 - 0.177393719F * x116 -
               0.0615457455F * x117 + 0.177393719F * x119 + x123 * x134 +
               x129 * x130 + x132 * x133 + x34 * x89;
    flux[29] = vn[1] * x136 + 0.5F * wL[29] - 0.5F * wR[29] -
               0.156446555F * x124 + 0.156446555F * x126 + x129 * x137 +
               0.087038828F * x35 - 0.087038828F * x37 + x44 * x92 - x54 * x94;
    flux[30] = 0.158910432F * vn[0] * x47 + 0.158910432F * vn[1] * x44 +
               0.5F * wL[30] - 0.5F * wR[30] - x129 * x139 - x132 * x138 +
               x135 * x140 + x54 * x95;
    flux[31] = vn[0] * x136 + 0.5F * wL[31] - 0.5F * wR[31] + x132 * x137 -
               0.156446555F * x141 - 0.156446555F * x142 + x47 * x92 -
               x54 * x93 + 0.087038828F * x60 + 0.087038828F * x61;
    flux[32] = -vn[0] * x131 + vn[1] * x128 + 0.0615457455F * vn[1] * x41 +
               0.5F * wL[32] - 0.5F * wR[32] + x125 * x134 - x129 * x133 +
               x130 * x132 + 0.0615457455F * x143 - 0.177393719F * x144 -
               0.177393719F * x145 + x36 * x89;
    flux[33] = 0.0355334527F * vn[1] * x32 + 0.5F * wL[33] - 0.5F * wR[33] +
               x118 * x127 + 0.0724206824F * x141 - 0.0724206824F * x142 +
               0.0355334527F * x146 - 0.198332207F * x147 -
               0.198332207F * x148 + x49 * x82 - 0.188025358F * x60 +
               0.188025358F * x61;
    flux[34] = 0.0512091557F * vn[0] * x118 - vn[0] * x121 - vn[1] * x114 +
               0.213200716F * vn[1] * x41 + 0.186989398F * vn[2] * x107 +
               0.150755672F * vn[2] * x38 + 0.5F * wL[34] - 0.5F * wR[34] -
               0.213200716F * x143 - 0.0512091557F * x145;
    flux[35] = 0.0295656198F * vn[0] * x107 - vn[0] * x110 - vn[1] * x103 +
               0.238365647F * vn[1] * x32 + 0.138675049F * vn[2] * x120 +
               0.5F * wL[35] - 0.5F * wR[35] - 0.238365647F * x146 -
               0.0295656198F * x148;
    flux[36] = -vn[0] * x151 + vn[1] * x158 + 0.5F * wL[36] - 0.5F * wR[36] -
               0.240192231F * x149 + 0.0253184842F * x153 -
               0.240192231F * x154 + 0.0253184842F * x156 + x159 * x160;
    flux[37] = 0.5F * wL[37] - 0.5F * wR[37] + x10 * x167 + x112 * x62 +
               x152 * x168 - x159 * x6 - 0.219264505F * x161 +
               0.043852901F * x163 - 0.219264505F * x164 + 0.043852901F * x166;
    flux[38] = 0.5F * wL[38] - 0.5F * wR[38] + x122 * x72 +
               0.0295656198F * x149 - 0.205688338F * x153 -
               0.0295656198F * x154 + 0.205688338F * x156 + x162 * x173 +
               0.0620173673F * x170 + 0.0620173673F * x172 -
               0.198332207F * x65 - 0.198332207F * x69;
    flux[39] = 0.5F * wL[39] - 0.5F * wR[39] + x127 * x64 +
               0.0512091557F * x161 - 0.187766904F * x163 -
               0.0512091557F * x164 + 0.187766904F * x166 + x169 * x178 +
               0.0800640769F * x175 + 0.0800640769F * x177 -
               0.177393719F * x76 - 0.177393719F * x79;
    flux[40] = -vn[0] * x179 - vn[1] * x182 + 0.5F * wL[40] - 0.5F * wR[40] +
               x134 * x75 - 0.169841555F * x170 + 0.169841555F * x172 +
               x174 * x185 + x180 * x181 + x183 * x184 + 0.0724206824F * x65 -
               0.0724206824F * x69;
    flux[41] = vn[1] * x187 + 0.5F * wL[41] - 0.5F * wR[41] + x137 * x84 -
               x139 * x90 - 0.151910905F * x175 + 0.151910905F * x177 +
               x180 * x188 + 0.093494699F * x76 - 0.093494699F * x79;
    flux[42] = 0.161937569F * vn[0] * x87 + 0.161937569F * vn[1] * x84 +
               0.5F * wL[42] - 0.5F * wR[42] + x140 * x90 - x180 * x190 -
               x183 * x189 + x186 * x191;
    flux[43] = vn[0] * x187 + 0.5F * wL[43] - 0.5F * wR[43] + x137 * x87 -
               x138 * x90 + x183 * x188 - 0.151910905F * x192 -
               0.151910905F * x193 + 0.093494699F * x96 + 0.093494699F * x97;
    flux[44] = -vn[0] * x182 + vn[1] * x179 + 0.5F * wL[44] - 0.5F * wR[44] +
               0.0724206824F * x100 + x134 * x78 + x176 * x185 - x180 * x184 +
               x181 * x183 - 0.169841555F * x194 - 0.169841555F * x195 +
               0.0724206824F * x99;
    flux[45] = 0.0512091557F * vn[1] * x72 + 0.5F * wL[45] - 0.5F * wR[45] +
               x127 * x68 + x171 * x178 + 0.0800640769F * x192 -
               0.0800640769F * x193 + 0.0512091557F * x196 -
               0.187766904F * x197 - 0.187766904F * x198 - 0.177393719F * x96 +
               0.177393719F * x97;
    flux[46] = 0.0295656198F * vn[1] * x62 + 0.5F * wL[46] - 0.5F * wR[46] +
               0.198332207F * x100 + x122 * x80 + x165 * x173 +
               0.0620173673F * x194 - 0.0620173673F * x195 +
               0.0295656198F * x199 - 0.205688338F * x200 -
               0.205688338F * x201 - 0.198332207F * x99;
    flux[47] = 0.043852901F * vn[0] * x165 + 0.219264505F * vn[1] * x72 +
               0.175411604F * vn[2] * x155 + 0.138675049F * vn[2] * x70 +
               0.5F * wL[47] - 0.5F * wR[47] - x10 * x159 - x167 * x6 -
               0.219264505F * x196 - 0.043852901F * x198;
    flux[48] = 0.0253184842F * vn[0] * x155 - vn[0] * x158 - vn[1] * x151 +
               0.240192231F * vn[1] * x62 + 0.129099445F * vn[2] * x167 +
               0.5F * wL[48] - 0.5F * wR[48] - 0.240192231F * x199 -
               0.0253184842F * x201;
    flux[49] = -vn[0] * x204 + vn[1] * x211 + 0.5F * wL[49] - 0.5F * wR[49] -
               0.241522946F * x202 + 0.0221403721F * x206 -
               0.241522946F * x207 + 0.0221403721F * x209 + x212 * x213;
    flux[50] = -vn[0] * x214 + vn[1] * x220 + 0.5F * wL[50] - 0.5F * wR[50] -
               x10 * x120 + x102 * x160 - x111 * x6 + x205 * x221 +
               0.0383482494F * x216 + 0.0383482494F * x218;
    flux[51] = vn[2] * x226 + 0.5F * wL[51] - 0.5F * wR[51] -
               0.205688338F * x105 - 0.205688338F * x108 + x111 * x168 +
               0.0253184842F * x202 - 0.211205689F * x206 -
               0.0253184842F * x207 + 0.211205689F * x209 +
               0.0542326145F * x223 + 0.0542326145F * x225;
    flux[52] = 0.5F * wL[52] - 0.5F * wR[52] + x104 * x173 + x111 * x227 -
               0.187766904F * x116 - 0.187766904F * x119 - x120 * x230 -
               0.195538472F * x216 + 0.195538472F * x218 + x222 * x233 +
               0.0700140042F * x229 + 0.0700140042F * x232;
    flux[53] = 0.5F * wL[53] - 0.5F * wR[53] + 0.0620173673F * x105 -
               0.0620173673F * x108 + x115 * x178 - 0.169841555F * x124 -
               0.169841555F * x126 - 0.179869234F * x223 + 0.179869234F * x225 +
               x228 * x238 + 0.0857492926F * x235 + 0.0857492926F * x237;
    flux[54] = -vn[0] * x239 - vn[1] * x242 + 0.5F * wL[54] - 0.5F * wR[54] +
               0.0800640769F * x116 - 0.0800640769F * x119 + x123 * x185 -
               0.164197394F * x229 + 0.164197394F * x232 + x234 * x245 +
               x240 * x241 + x243 * x244;
    flux[55] = vn[1] * x247 + 0.5F * wL[55] - 0.5F * wR[55] +
               0.0980580676F * x124 - 0.0980580676F * x126 + x129 * x188 -
               x135 * x190 - 0.148522131F * x235 + 0.148522131F * x237 +
               x240 * x248;
    flux[56] = 0.164082531F * vn[0] * x132 + 0.164082531F * vn[1] * x129 +
               0.5F * wL[56] - 0.5F * wR[56] + x135 * x191 - x240 * x250 -
               x243 * x249 + x246 * x251;
    flux[57] = vn[0] * x247 + 0.5F * wL[57] - 0.5F * wR[57] + x132 * x188 -
               x135 * x189 + 0.0980580676F * x141 + 0.0980580676F * x142 +
               x243 * x248 - 0.148522131F * x252 - 0.148522131F * x253;
    flux[58] = -vn[0] * x242 + vn[1] * x239 + 0.5F * wL[58] - 0.5F * wR[58] +
               x125 * x185 + 0.0800640769F * x144 + 0.0800640769F * x145 +
               x236 * x245 - x240 * x244 + x241 * x243 - 0.164197394F * x254 -
               0.164197394F * x255;
    flux[59] = 0.5F * wL[59] - 0.5F * wR[59] + x118 * x178 -
               0.169841555F * x141 + 0.169841555F * x142 +
               0.0620173673F * x147 + 0.0620173673F * x148 + x231 * x238 +
               0.0857492926F * x252 - 0.0857492926F * x253 -
               0.179869234F * x256 - 0.179869234F * x257;
    flux[60] = -vn[0] * x258 - vn[1] * x226 + 0.5F * wL[60] - 0.5F * wR[60] +
               x107 * x173 + x111 * x230 + x120 * x227 - 0.187766904F * x144 +
               0.187766904F * x145 + x224 * x233 + 0.0700140042F * x254 -
               0.0700140042F * x255;
    flux[61] = 0.0253184842F * vn[1] * x102 + vn[2] * x258 + 0.5F * wL[61] -
               0.5F * wR[61] + x120 * x168 - 0.205688338F * x147 +
               0.205688338F * x148 + 0.0542326145F * x256 -
               0.0542326145F * x257 + 0.0253184842F * x259 -
               0.211205689F * x260 - 0.211205689F * x261;
    flux[62] = 0.0383482494F * vn[0] * x217 - vn[0] * x220 +
               0.223606798F * vn[1] * x111 - vn[1] * x214 +
               0.129099445F * vn[2] * x109 + 0.165683374F * vn[2] * x208 +
               0.5F * wL[62] - 0.5F * wR[62] - x120 * x6 - x215 * x262;
    flux[63] = 0.0221403721F * vn[0] * x208 - vn[0] * x211 +
               0.241522946F * vn[1] * x102 - vn[1] * x204 +
               0.121267813F * vn[2] * x219 + 0.5F * wL[63] - 0.5F * wR[63] -
               0.241522946F * x259 - 0.0221403721F * x261;
    flux[64] = -vn[0] * x264 + vn[1] * x270 + 0.5F * wL[64] - 0.5F * wR[64] -
               0.242535625F * x263 + 0.0196722369F * x266 -
               0.242535625F * x267 + 0.0196722369F * x269 + x271 * x272;
    flux[65] = -0.226871303F * vn[0] * x159 - vn[0] * x273 - vn[1] * x276 +
               vn[1] * x280 + 0.5F * wL[65] - 0.5F * wR[65] + x150 * x213 +
               x265 * x281 + 0.0340733138F * x275 + 0.0340733138F * x278;
    flux[66] = 0.5F * wL[66] - 0.5F * wR[66] - 0.211205689F * x153 -
               0.211205689F * x156 + x159 * x221 + 0.0221403721F * x263 -
               0.215498558F * x266 - 0.0221403721F * x267 +
               0.215498558F * x269 + x274 * x286 + 0.0481869425F * x283 +
               0.0481869425F * x285;
    flux[67] = 0.5F * wL[67] - 0.5F * wR[67] + x152 * x292 + x159 * x287 -
               0.195538472F * x163 - 0.195538472F * x166 - x167 * x262 -
               0.201580443F * x275 + 0.201580443F * x278 + x282 * x293 +
               0.0622090752F * x289 + 0.0622090752F * x291;
    flux[68] = 0.5F * wL[68] - 0.5F * wR[68] + 0.0542326145F * x153 -
               0.0542326145F * x156 + x162 * x233 - 0.179869234F * x170 -
               0.179869234F * x172 - 0.187661179F * x283 + 0.187661179F * x285 +
               x288 * x298 + 0.0761902458F * x295 + 0.0761902458F * x297;
    flux[69] = 0.5F * wL[69] - 0.5F * wR[69] + 0.0700140042F * x163 -
               0.0700140042F * x166 + x169 * x238 - 0.164197394F * x175 -
               0.164197394F * x177 - 0.173740492F * x289 + 0.173740492F * x291 +
               x294 * x303 + 0.0901495146F * x300 + 0.0901495146F * x302;
    flux[70] = -vn[0] * x304 - vn[1] * x307 + 0.5F * wL[70] - 0.5F * wR[70] +
               0.0857492926F * x170 - 0.0857492926F * x172 + x174 * x245 -
               0.159818008F * x295 + 0.159818008F * x297 + x299 * x310 +
               x305 * x306 + x308 * x309;
    flux[71] = vn[1] * x312 + 0.5F * wL[71] - 0.5F * wR[71] +
               0.101459931F * x175 - 0.101459931F * x177 + x180 * x248 -
               x186 * x250 - 0.145893213F * x300 + 0.145893213F * x302 +
               x305 * x313;
    flux[72] = 0.165683374F * vn[0] * x183 + 0.165683374F * vn[1] * x180 +
               0.5F * wL[72] - 0.5F * wR[72] + x186 * x251 - x305 * x315 -
               x308 * x314 + x311 * x316;
    flux[73] = vn[0] * x312 + 0.5F * wL[73] - 0.5F * wR[73] + x183 * x248 -
               x186 * x249 + 0.101459931F * x192 + 0.101459931F * x193 +
               x308 * x313 - 0.145893213F * x317 - 0.145893213F * x318;
    flux[74] = -vn[0] * x307 + vn[1] * x304 + 0.5F * wL[74] - 0.5F * wR[74] +
               x176 * x245 + 0.0857492926F * x194 + 0.0857492926F * x195 +
               x301 * x310 - x305 * x309 + x306 * x308 - 0.159818008F * x319 -
               0.159818008F * x320;
    flux[75] = 0.5F * wL[75] - 0.5F * wR[75] + x171 * x238 -
               0.164197394F * x192 + 0.164197394F * x193 +
               0.0700140042F * x197 + 0.0700140042F * x198 + x296 * x303 +
               0.0901495146F * x317 - 0.0901495146F * x318 -
               0.173740492F * x321 - 0.173740492F * x322;
    flux[76] = 0.5F * wL[76] - 0.5F * wR[76] + x165 * x233 -
               0.179869234F * x194 + 0.179869234F * x195 +
               0.0542326145F * x200 + 0.0542326145F * x201 + x290 * x298 +
               0.0761902458F * x319 - 0.0761902458F * x320 -
               0.187661179F * x323 - 0.187661179F * x324;
    flux[77] = -0.201580443F * vn[0] * x277 + 0.5F * wL[77] - 0.5F * wR[77] +
               x155 * x292 + x159 * x262 + x167 * x287 - 0.195538472F * x197 +
               0.195538472F * x198 + x284 * x293 + 0.0622090752F * x321 -
               0.0622090752F * x322 - 0.201580443F * x325;
    flux[78] = -0.215498558F * vn[0] * x268 + 0.0221403721F * vn[1] * x150 +
               0.5F * wL[78] - 0.5F * wR[78] + x167 * x221 -
               0.211205689F * x200 + 0.211205689F * x201 + x277 * x286 +
               0.0481869425F * x323 - 0.0481869425F * x324 +
               0.0221403721F * x326 - 0.215498558F * x327;
    flux[79] = -vn[0] * x276 + 0.0340733138F * vn[0] * x277 - vn[0] * x280 +
               0.226871303F * vn[1] * x159 - vn[1] * x273 +
               0.121267813F * vn[2] * x157 + 0.157377895F * vn[2] * x268 +
               0.5F * wL[79] - 0.5F * wR[79] - 0.0340733138F * x325;
    flux[80] = 0.0196722369F * vn[0] * x268 - vn[0] * x270 +
               0.242535625F * vn[1] * x150 - vn[1] * x264 +
               0.114707867F * vn[2] * x279 + 0.5F * wL[80] - 0.5F * wR[80] -
               0.242535625F * x326 - 0.0196722369F * x327;
    flux[81] = -0.243332132F * vn[0] * x203 + 0.5F * wL[81] - 0.5F * wR[81] -
               0.243332132F * x328;
    flux[82] = -0.229415734F * vn[0] * x212 + 0.114707867F * vn[2] * x203 +
               0.5F * wL[82] - 0.5F * wR[82] - 0.229415734F * x329;
    flux[83] = 0.0196722369F * vn[0] * x203 + 0.157377895F * vn[2] * x212 +
               0.5F * wL[83] - 0.5F * wR[83] - 0.215498558F * x206 -
               0.215498558F * x209 - 0.0196722369F * x328;
    flux[84] = 0.0340733138F * vn[0] * x212 + 0.186627226F * vn[2] * x205 +
               0.5F * wL[84] - 0.5F * wR[84] - 0.201580443F * x216 -
               0.201580443F * x218 - 0.0340733138F * x329;
    flux[85] = 0.0481869425F * vn[0] * x205 + 0.208191386F * vn[2] * x215 +
               0.5F * wL[85] - 0.5F * wR[85] - 0.0481869425F * x209 -
               0.187661179F * x223 - 0.187661179F * x225;
    flux[86] = 0.0622090752F * vn[0] * x215 + 0.224298011F * vn[2] * x222 +
               0.5F * wL[86] - 0.5F * wR[86] - 0.0622090752F * x218 -
               0.173740492F * x229 - 0.173740492F * x232;
    flux[87] = 0.0761902458F * vn[0] * x222 + 0.236066843F * vn[2] * x228 +
               0.5F * wL[87] - 0.5F * wR[87] - 0.0761902458F * x225 -
               0.159818008F * x235 - 0.159818008F * x237;
    flux[88] = 0.0901495146F * vn[0] * x228 - vn[0] * x330 - vn[1] * x331 +
               0.24412604F * vn[2] * x234 + 0.5F * wL[88] - 0.5F * wR[88] -
               0.0901495146F * x232;
    flux[89] = 0.5F * wL[89] - 0.5F * wR[89] + 0.104095693F * x235 -
               0.104095693F * x237 + x240 * x313 - x246 * x315;
    flux[90] = 0.166924465F * vn[0] * x243 + 0.166924465F * vn[1] * x240 +
               0.5F * wL[90] - 0.5F * wR[90] + x246 * x316;
    flux[91] = 0.5F * wL[91] - 0.5F * wR[91] + x243 * x313 - x246 * x314 +
               0.104095693F * x252 + 0.104095693F * x253;
    flux[92] = -vn[0] * x331 + vn[1] * x330 + 0.5F * wL[92] - 0.5F * wR[92] +
               x236 * x310 + 0.0901495146F * x254 + 0.0901495146F * x255;
    flux[93] = 0.5F * wL[93] - 0.5F * wR[93] + x231 * x303 -
               0.159818008F * x252 + 0.159818008F * x253 +
               0.0761902458F * x256 + 0.0761902458F * x257;
    flux[94] = 0.5F * wL[94] - 0.5F * wR[94] + x224 * x298 -
               0.173740492F * x254 + 0.173740492F * x255 +
               0.0622090752F * x332 + 0.0622090752F * x333;
    flux[95] = 0.5F * wL[95] - 0.5F * wR[95] + x217 * x293 -
               0.187661179F * x256 + 0.187661179F * x257 +
               0.0481869425F * x260 + 0.0481869425F * x261;
    flux[96] = 0.5F * wL[96] - 0.5F * wR[96] + x208 * x286 -
               0.201580443F * x332 + 0.201580443F * x333 +
               0.0340733138F * x334 + 0.0340733138F * x335;
    flux[97] = 0.0196722369F * vn[1] * x203 + 0.5F * wL[97] - 0.5F * wR[97] +
               x219 * x281 - 0.215498558F * x260 + 0.215498558F * x261 +
               0.0196722369F * x336;
    flux[98] = 0.5F * wL[98] - 0.5F * wR[98] + x210 * x272 -
               0.229415734F * x334 + 0.229415734F * x335;
    flux[99] = 0.243332132F * vn[1] * x203 + 0.5F * wL[99] - 0.5F * wR[99] -
               0.243332132F * x336;
}

#endif
#endif
