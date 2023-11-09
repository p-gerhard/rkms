#ifndef P5_CL
#define P5_CL

#ifdef USE_DOUBLE

#ifdef IS_2D

void num_flux_rus(const double wL[21], const double wR[21], const double vn[2],
                  double flux[21])
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
    const double x13 = wL[6] + wR[6];
    const double x14 = 0.23145502494313785 * x13;
    const double x15 = wL[7] + wR[7];
    const double x16 = 0.059761430466719681 * vn[0];
    const double x17 = 0.22360679774997899 * x0;
    const double x18 = wL[8] + wR[8];
    const double x19 = 0.059761430466719681 * vn[1];
    const double x20 = wL[9] + wR[9];
    const double x21 = 0.23145502494313785 * x20;
    const double x22 = 0.20701966780270625 * vn[0];
    const double x23 = 0.20701966780270625 * vn[1];
    const double x24 = wL[10] + wR[10];
    const double x25 = 0.23570226039551584 * x24;
    const double x26 = wL[11] + wR[11];
    const double x27 = vn[0] * x26;
    const double x28 = 0.23145502494313785 * x5;
    const double x29 = wL[13] + wR[13];
    const double x30 = vn[1] * x29;
    const double x31 = wL[14] + wR[14];
    const double x32 = 0.23570226039551584 * x31;
    const double x33 = 0.23145502494313785 * x10;
    const double x34 = wL[12] + wR[12];
    const double x35 = 0.15430334996209191 * x34;
    const double x36 = vn[0] * x29;
    const double x37 = vn[1] * x26;
    const double x38 =
        0.23836564731139809 * wL[15] + 0.23836564731139809 * wR[15];
    const double x39 = wL[16] + wR[16];
    const double x40 = vn[0] * x39;
    const double x41 = vn[0] * x13;
    const double x42 = wL[19] + wR[19];
    const double x43 = vn[1] * x42;
    const double x44 =
        0.23836564731139809 * wL[20] + 0.23836564731139809 * wR[20];
    const double x45 = vn[1] * x20;
    const double x46 = wL[17] + wR[17];
    const double x47 = 0.087038827977848926 * vn[0];
    const double x48 = 0.17251638983558854 * x15;
    const double x49 = wL[18] + wR[18];
    const double x50 = 0.087038827977848926 * vn[1];
    const double x51 = 0.17251638983558854 * x18;
    const double x52 = 0.19462473604038075 * vn[0];
    const double x53 = 0.19462473604038075 * vn[1];
    const double x54 = vn[0] * x42;
    const double x55 = vn[0] * x20;
    const double x56 = vn[1] * x39;
    const double x57 = vn[1] * x13;
    const double x58 = vn[0] * x24;
    const double x59 = vn[1] * x31;
    const double x60 = vn[0] * x31;
    const double x61 = vn[1] * x24;
    flux[0] = -x0 * x1 - x2 * x3 - x4 * (-wL[0] + wR[0]);
    flux[1] = -vn[0] * x6 + vn[1] * x11 + vn[1] * x9 - x3 * x7 -
              x4 * (-wL[1] + wR[1]);
    flux[2] = -vn[0] * x11 + vn[0] * x9 - vn[1] * x6 - x1 * x7 -
              x4 * (-wL[2] + wR[2]);
    flux[3] = -vn[0] * x12 - vn[0] * x14 - vn[1] * x17 + vn[1] * x21 +
              x15 * x16 + x18 * x19 - x4 * (-wL[3] + wR[3]);
    flux[4] = 0.12909944487358058 * vn[0] * x0 +
              0.12909944487358058 * vn[1] * x2 - x15 * x23 - x18 * x22 -
              x4 * (-wL[4] + wR[4]);
    flux[5] = -vn[0] * x17 - vn[0] * x21 + vn[1] * x12 - vn[1] * x14 -
              x15 * x19 + x16 * x18 - x4 * (-wL[5] + wR[5]);
    flux[6] = -vn[0] * x25 - vn[0] * x28 + vn[1] * x32 - vn[1] * x33 +
              0.044543540318737397 * x27 + 0.044543540318737397 * x30 -
              x4 * (-wL[6] + wR[6]);
    flux[7] = vn[1] * x35 - x10 * x19 + x16 * x5 - x23 * x8 -
              0.17251638983558854 * x27 + 0.17251638983558854 * x30 -
              x4 * (-wL[7] + wR[7]);
    flux[8] = vn[0] * x35 + x10 * x16 + x19 * x5 - x22 * x8 -
              0.17251638983558854 * x36 - 0.17251638983558854 * x37 -
              x4 * (-wL[8] + wR[8]);
    flux[9] = -vn[0] * x32 - vn[0] * x33 - vn[1] * x25 + vn[1] * x28 +
              0.044543540318737397 * x36 - 0.044543540318737397 * x37 -
              x4 * (-wL[9] + wR[9]);
    flux[10] = -vn[0] * x38 + vn[1] * x44 - x4 * (-wL[10] + wR[10]) +
               0.035533452725935076 * x40 - 0.23570226039551584 * x41 +
               0.035533452725935076 * x43 - 0.23570226039551584 * x45;
    flux[11] = -vn[0] * x48 - vn[1] * x51 - x4 * (-wL[11] + wR[11]) -
               0.18802535827258876 * x40 + 0.044543540318737397 * x41 +
               0.18802535827258876 * x43 - 0.044543540318737397 * x45 +
               x46 * x47 + x49 * x50;
    flux[12] = 0.15430334996209191 * vn[0] * x18 +
               0.15430334996209191 * vn[1] * x15 - x4 * (-wL[12] + wR[12]) -
               x46 * x53 - x49 * x52;
    flux[13] = -vn[0] * x51 + vn[1] * x48 - x4 * (-wL[13] + wR[13]) -
               x46 * x50 + x47 * x49 - 0.18802535827258876 * x54 +
               0.044543540318737397 * x55 - 0.18802535827258876 * x56 +
               0.044543540318737397 * x57;
    flux[14] = -vn[0] * x44 - vn[1] * x38 - x4 * (-wL[14] + wR[14]) +
               0.035533452725935076 * x54 - 0.23570226039551584 * x55 -
               0.035533452725935076 * x56 + 0.23570226039551584 * x57;
    flux[15] = -x4 * (-wL[15] + wR[15]) - 0.23836564731139809 * x58 -
               0.23836564731139809 * x59;
    flux[16] = -0.18802535827258876 * x27 - 0.18802535827258876 * x30 -
               x4 * (-wL[16] + wR[16]) + 0.035533452725935076 * x58 -
               0.035533452725935076 * x59;
    flux[17] = 0.087038827977848926 * x27 - 0.087038827977848926 * x30 -
               x34 * x53 - x4 * (-wL[17] + wR[17]);
    flux[18] = -x34 * x52 + 0.087038827977848926 * x36 +
               0.087038827977848926 * x37 - x4 * (-wL[18] + wR[18]);
    flux[19] = -0.18802535827258876 * x36 + 0.18802535827258876 * x37 -
               x4 * (-wL[19] + wR[19]) + 0.035533452725935076 * x60 +
               0.035533452725935076 * x61;
    flux[20] = -x4 * (-wL[20] + wR[20]) - 0.23836564731139809 * x60 +
               0.23836564731139809 * x61;
}

#else

void num_flux_rus(const double wL[36], const double wR[36], const double vn[3],
                  double flux[36])
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
    const double x20 = wL[9] + wR[9];
    const double x21 = 0.23145502494313785 * x20;
    const double x22 = wL[13] + wR[13];
    const double x23 = 0.059761430466719681 * vn[1];
    const double x24 = wL[15] + wR[15];
    const double x25 = 0.23145502494313785 * x24;
    const double x26 = wL[10] + wR[10];
    const double x27 = 0.1889822365046136 * x26;
    const double x28 = wL[12] + wR[12];
    const double x29 = 0.14638501094227996 * x28;
    const double x30 = wL[14] + wR[14];
    const double x31 = 0.1889822365046136 * x30;
    const double x32 = 0.23904572186687872 * vn[2];
    const double x33 = 0.20701966780270625 * vn[0];
    const double x34 = 0.20701966780270625 * vn[1];
    const double x35 = 0.25354627641855498 * vn[2];
    const double x36 = wL[16] + wR[16];
    const double x37 = 0.23570226039551584 * x36;
    const double x38 = wL[18] + wR[18];
    const double x39 = vn[0] * x38;
    const double x40 = 0.23145502494313785 * x7;
    const double x41 = wL[22] + wR[22];
    const double x42 = vn[1] * x41;
    const double x43 = wL[24] + wR[24];
    const double x44 = 0.23570226039551584 * x43;
    const double x45 = 0.23145502494313785 * x12;
    const double x46 = wL[17] + wR[17];
    const double x47 = 0.16666666666666666 * vn[2];
    const double x48 = 0.20412414523193148 * x46;
    const double x49 = wL[19] + wR[19];
    const double x50 = 0.077151674981045956 * vn[0];
    const double x51 = 0.1889822365046136 * x14;
    const double x52 = wL[21] + wR[21];
    const double x53 = 0.077151674981045956 * vn[1];
    const double x54 = wL[23] + wR[23];
    const double x55 = 0.20412414523193148 * x54;
    const double x56 = 0.1889822365046136 * x16;
    const double x57 = 0.21821789023599236 * vn[2];
    const double x58 = 0.1889822365046136 * vn[2];
    const double x59 = wL[20] + wR[20];
    const double x60 = 0.15430334996209191 * x59;
    const double x61 = 0.24397501823713327 * vn[2];
    const double x62 = 0.19920476822239894 * vn[0];
    const double x63 = 0.19920476822239894 * vn[1];
    const double x64 = 0.25197631533948484 * vn[2];
    const double x65 = vn[0] * x41;
    const double x66 = vn[1] * x38;
    const double x67 =
        0.23836564731139809 * wL[25] + 0.23836564731139809 * wR[25];
    const double x68 = wL[27] + wR[27];
    const double x69 = vn[0] * x68;
    const double x70 = vn[0] * x20;
    const double x71 = vn[1] * x24;
    const double x72 = wL[33] + wR[33];
    const double x73 = vn[1] * x72;
    const double x74 =
        0.23836564731139809 * wL[35] + 0.23836564731139809 * wR[35];
    const double x75 = wL[26] + wR[26];
    const double x76 = 0.15075567228888181 * vn[2];
    const double x77 = 0.20412414523193148 * x26;
    const double x78 = 0.21320071635561044 * x75;
    const double x79 = wL[28] + wR[28];
    const double x80 = vn[0] * x79;
    const double x81 = 0.20412414523193148 * x30;
    const double x82 = wL[32] + wR[32];
    const double x83 = vn[1] * x82;
    const double x84 = wL[34] + wR[34];
    const double x85 = 0.21320071635561044 * x84;
    const double x86 = 0.20100756305184242 * vn[2];
    const double x87 = 0.17251638983558854 * x18;
    const double x88 = wL[29] + wR[29];
    const double x89 = 0.087038827977848926 * vn[0];
    const double x90 = 0.17251638983558854 * x22;
    const double x91 = wL[31] + wR[31];
    const double x92 = 0.087038827977848926 * vn[1];
    const double x93 = 0.23028309323591917 * vn[2];
    const double x94 = wL[30] + wR[30];
    const double x95 = 0.15891043154093207 * x94;
    const double x96 = 0.24618298195866548 * vn[2];
    const double x97 = 0.19462473604038075 * vn[0];
    const double x98 = 0.19462473604038075 * vn[1];
    const double x99 = 0.25125945381480302 * vn[2];
    const double x100 = vn[0] * x82;
    const double x101 = vn[1] * x79;
    const double x102 = vn[0] * x24;
    const double x103 = vn[0] * x72;
    const double x104 = vn[1] * x68;
    const double x105 = vn[1] * x20;
    const double x106 = vn[0] * x36;
    const double x107 = vn[1] * x43;
    const double x108 = vn[0] * x46;
    const double x109 = vn[1] * x54;
    const double x110 = 0.1628347368197324 * x49;
    const double x111 = 0.1628347368197324 * x52;
    const double x112 = vn[0] * x54;
    const double x113 = vn[1] * x46;
    const double x114 = vn[0] * x43;
    const double x115 = vn[1] * x36;
    flux[0] = -x0 * x1 - x2 * x3 + x4 * x5 - x6 * (-wL[0] + wR[0]);
    flux[1] = vn[1] * x11 + x12 * x13 + x14 * x15 - x3 * x9 -
              x6 * (-wL[1] + wR[1]) - x7 * x8;
    flux[2] =
        x10 * x17 - x13 * x14 - x16 * x8 + x5 * x9 - x6 * (-wL[2] + wR[2]);
    flux[3] = vn[0] * x11 - x1 * x9 - x12 * x8 - x13 * x7 + x15 * x16 -
              x6 * (-wL[3] + wR[3]);
    flux[4] = -vn[0] * x21 + vn[1] * x25 + vn[2] * x27 - x0 * x13 + x18 * x19 -
              x2 * x8 + x22 * x23 - x6 * (-wL[4] + wR[4]);
    flux[5] = -vn[0] * x27 + vn[1] * x29 + vn[1] * x31 - x13 * x4 + x15 * x2 +
              x18 * x32 - x6 * (-wL[5] + wR[5]);
    flux[6] = 0.12909944487358058 * vn[0] * x0 +
              0.12909944487358058 * vn[1] * x2 + x17 * x4 - x18 * x34 -
              x22 * x33 + x28 * x35 - x6 * (-wL[6] + wR[6]);
    flux[7] = vn[0] * x29 - vn[0] * x31 - vn[1] * x27 + x0 * x15 + x22 * x32 -
              x4 * x8 - x6 * (-wL[7] + wR[7]);
    flux[8] = -vn[0] * x25 - vn[1] * x21 + vn[2] * x31 - x0 * x8 + x13 * x2 -
              x18 * x23 + x19 * x22 - x6 * (-wL[8] + wR[8]);
    flux[9] = -vn[0] * x37 - vn[0] * x40 + vn[1] * x44 - vn[1] * x45 +
              0.044543540318737397 * x39 + 0.044543540318737397 * x42 +
              x46 * x47 - x6 * (-wL[9] + wR[9]);
    flux[10] = -vn[0] * x48 - vn[0] * x51 + vn[1] * x55 - vn[1] * x56 +
               x38 * x57 + x49 * x50 + x52 * x53 + x58 * x7 -
               x6 * (-wL[10] + wR[10]);
    flux[11] = vn[1] * x60 - x10 * x34 - x12 * x23 + x14 * x32 + x19 * x7 -
               0.17251638983558854 * x39 + 0.17251638983558854 * x42 +
               x49 * x61 - x6 * (-wL[11] + wR[11]);
    flux[12] = 0.14638501094227996 * vn[0] * x16 +
               0.14638501094227996 * vn[1] * x14 + x10 * x35 - x49 * x63 -
               x52 * x62 + x59 * x64 - x6 * (-wL[12] + wR[12]);
    flux[13] = vn[0] * x60 - x10 * x33 + x12 * x19 + x16 * x32 + x23 * x7 +
               x52 * x61 - x6 * (-wL[13] + wR[13]) - 0.17251638983558854 * x65 -
               0.17251638983558854 * x66;
    flux[14] = -vn[0] * x55 - vn[0] * x56 - vn[1] * x48 + vn[1] * x51 +
               x12 * x58 + x41 * x57 - x49 * x53 + x50 * x52 -
               x6 * (-wL[14] + wR[14]);
    flux[15] = -vn[0] * x44 - vn[0] * x45 - vn[1] * x37 + vn[1] * x40 +
               x47 * x54 - x6 * (-wL[15] + wR[15]) +
               0.044543540318737397 * x65 - 0.044543540318737397 * x66;
    flux[16] = -vn[0] * x67 + vn[1] * x74 - x6 * (-wL[16] + wR[16]) +
               0.035533452725935076 * x69 - 0.23570226039551584 * x70 -
               0.23570226039551584 * x71 + 0.035533452725935076 * x73 +
               x75 * x76;
    flux[17] = -vn[0] * x77 - vn[0] * x78 - vn[1] * x81 + vn[1] * x85 +
               x20 * x47 - x6 * (-wL[17] + wR[17]) + x68 * x86 +
               0.061545745489666369 * x80 + 0.061545745489666369 * x83;
    flux[18] = -vn[0] * x87 - vn[1] * x90 + x26 * x57 -
               x6 * (-wL[18] + wR[18]) - 0.18802535827258876 * x69 +
               0.044543540318737397 * x70 - 0.044543540318737397 * x71 +
               0.18802535827258876 * x73 + x79 * x93 + x88 * x89 + x91 * x92;
    flux[19] = vn[1] * x95 + x18 * x61 + x26 * x50 - x28 * x63 - x30 * x53 -
               x6 * (-wL[19] + wR[19]) - 0.1628347368197324 * x80 +
               0.1628347368197324 * x83 + x88 * x96;
    flux[20] = 0.15430334996209191 * vn[0] * x22 +
               0.15430334996209191 * vn[1] * x18 + x28 * x64 -
               x6 * (-wL[20] + wR[20]) - x88 * x98 - x91 * x97 + x94 * x99;
    flux[21] = vn[0] * x95 - 0.1628347368197324 * x100 -
               0.1628347368197324 * x101 + x22 * x61 + x26 * x53 - x28 * x62 +
               x30 * x50 - x6 * (-wL[21] + wR[21]) + x91 * x96;
    flux[22] = -vn[0] * x90 + vn[1] * x87 + 0.044543540318737397 * x102 -
               0.18802535827258876 * x103 - 0.18802535827258876 * x104 +
               0.044543540318737397 * x105 + x30 * x57 -
               x6 * (-wL[22] + wR[22]) + x82 * x93 - x88 * x92 + x89 * x91;
    flux[23] = -vn[0] * x81 - vn[0] * x85 + vn[1] * x77 - vn[1] * x78 +
               0.061545745489666369 * x100 - 0.061545745489666369 * x101 +
               x24 * x47 - x6 * (-wL[23] + wR[23]) + x72 * x86;
    flux[24] = -vn[0] * x74 - vn[1] * x67 - 0.23570226039551584 * x102 +
               0.035533452725935076 * x103 - 0.035533452725935076 * x104 +
               0.23570226039551584 * x105 - x6 * (-wL[24] + wR[24]) + x76 * x84;
    flux[25] = -0.23836564731139809 * x106 - 0.23836564731139809 * x107 -
               x6 * (-wL[25] + wR[25]);
    flux[26] = -0.21320071635561044 * x108 - 0.21320071635561044 * x109 +
               x36 * x76 - x6 * (-wL[26] + wR[26]);
    flux[27] = 0.035533452725935076 * x106 - 0.035533452725935076 * x107 -
               0.18802535827258876 * x39 - 0.18802535827258876 * x42 +
               x46 * x86 - x6 * (-wL[27] + wR[27]);
    flux[28] = -vn[0] * x110 - vn[1] * x111 + 0.061545745489666369 * x108 -
               0.061545745489666369 * x109 + x38 * x93 -
               x6 * (-wL[28] + wR[28]);
    flux[29] = 0.087038827977848926 * x39 - 0.087038827977848926 * x42 +
               x49 * x96 - x59 * x98 - x6 * (-wL[29] + wR[29]);
    flux[30] = 0.15891043154093207 * vn[0] * x52 +
               0.15891043154093207 * vn[1] * x49 + x59 * x99 -
               x6 * (-wL[30] + wR[30]);
    flux[31] = x52 * x96 - x59 * x97 - x6 * (-wL[31] + wR[31]) +
               0.087038827977848926 * x65 + 0.087038827977848926 * x66;
    flux[32] = -vn[0] * x111 + vn[1] * x110 + 0.061545745489666369 * x112 +
               0.061545745489666369 * x113 + x41 * x93 -
               x6 * (-wL[32] + wR[32]);
    flux[33] = 0.035533452725935076 * x114 + 0.035533452725935076 * x115 +
               x54 * x86 - x6 * (-wL[33] + wR[33]) - 0.18802535827258876 * x65 +
               0.18802535827258876 * x66;
    flux[34] = -0.21320071635561044 * x112 + 0.21320071635561044 * x113 +
               x43 * x76 - x6 * (-wL[34] + wR[34]);
    flux[35] = -0.23836564731139809 * x114 + 0.23836564731139809 * x115 -
               x6 * (-wL[35] + wR[35]);
}

#endif

#else

#ifdef IS_2D

void num_flux_rus(const float wL[21], const float wR[21], const float vn[2],
                  float flux[21])
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
    const float x13 = wL[6] + wR[6];
    const float x14 = 0.231455025F * x13;
    const float x15 = wL[7] + wR[7];
    const float x16 = 0.0597614305F * vn[0];
    const float x17 = 0.223606798F * x0;
    const float x18 = wL[8] + wR[8];
    const float x19 = 0.0597614305F * vn[1];
    const float x20 = wL[9] + wR[9];
    const float x21 = 0.231455025F * x20;
    const float x22 = 0.207019668F * vn[0];
    const float x23 = 0.207019668F * vn[1];
    const float x24 = wL[10] + wR[10];
    const float x25 = 0.23570226F * x24;
    const float x26 = wL[11] + wR[11];
    const float x27 = vn[0] * x26;
    const float x28 = 0.231455025F * x5;
    const float x29 = wL[13] + wR[13];
    const float x30 = vn[1] * x29;
    const float x31 = wL[14] + wR[14];
    const float x32 = 0.23570226F * x31;
    const float x33 = 0.231455025F * x10;
    const float x34 = wL[12] + wR[12];
    const float x35 = 0.15430335F * x34;
    const float x36 = vn[0] * x29;
    const float x37 = vn[1] * x26;
    const float x38 = 0.238365647F * wL[15] + 0.238365647F * wR[15];
    const float x39 = wL[16] + wR[16];
    const float x40 = vn[0] * x39;
    const float x41 = vn[0] * x13;
    const float x42 = wL[19] + wR[19];
    const float x43 = vn[1] * x42;
    const float x44 = 0.238365647F * wL[20] + 0.238365647F * wR[20];
    const float x45 = vn[1] * x20;
    const float x46 = wL[17] + wR[17];
    const float x47 = 0.087038828F * vn[0];
    const float x48 = 0.17251639F * x15;
    const float x49 = wL[18] + wR[18];
    const float x50 = 0.087038828F * vn[1];
    const float x51 = 0.17251639F * x18;
    const float x52 = 0.194624736F * vn[0];
    const float x53 = 0.194624736F * vn[1];
    const float x54 = vn[0] * x42;
    const float x55 = vn[0] * x20;
    const float x56 = vn[1] * x39;
    const float x57 = vn[1] * x13;
    const float x58 = vn[0] * x24;
    const float x59 = vn[1] * x31;
    const float x60 = vn[0] * x31;
    const float x61 = vn[1] * x24;
    flux[0] = -x0 * x1 - x2 * x3 - x4 * (-wL[0] + wR[0]);
    flux[1] = -vn[0] * x6 + vn[1] * x11 + vn[1] * x9 - x3 * x7 -
              x4 * (-wL[1] + wR[1]);
    flux[2] = -vn[0] * x11 + vn[0] * x9 - vn[1] * x6 - x1 * x7 -
              x4 * (-wL[2] + wR[2]);
    flux[3] = -vn[0] * x12 - vn[0] * x14 - vn[1] * x17 + vn[1] * x21 +
              x15 * x16 + x18 * x19 - x4 * (-wL[3] + wR[3]);
    flux[4] = 0.129099445F * vn[0] * x0 + 0.129099445F * vn[1] * x2 -
              x15 * x23 - x18 * x22 - x4 * (-wL[4] + wR[4]);
    flux[5] = -vn[0] * x17 - vn[0] * x21 + vn[1] * x12 - vn[1] * x14 -
              x15 * x19 + x16 * x18 - x4 * (-wL[5] + wR[5]);
    flux[6] = -vn[0] * x25 - vn[0] * x28 + vn[1] * x32 - vn[1] * x33 +
              0.0445435403F * x27 + 0.0445435403F * x30 - x4 * (-wL[6] + wR[6]);
    flux[7] = vn[1] * x35 - x10 * x19 + x16 * x5 - x23 * x8 -
              0.17251639F * x27 + 0.17251639F * x30 - x4 * (-wL[7] + wR[7]);
    flux[8] = vn[0] * x35 + x10 * x16 + x19 * x5 - x22 * x8 -
              0.17251639F * x36 - 0.17251639F * x37 - x4 * (-wL[8] + wR[8]);
    flux[9] = -vn[0] * x32 - vn[0] * x33 - vn[1] * x25 + vn[1] * x28 +
              0.0445435403F * x36 - 0.0445435403F * x37 - x4 * (-wL[9] + wR[9]);
    flux[10] = -vn[0] * x38 + vn[1] * x44 - x4 * (-wL[10] + wR[10]) +
               0.0355334527F * x40 - 0.23570226F * x41 + 0.0355334527F * x43 -
               0.23570226F * x45;
    flux[11] = -vn[0] * x48 - vn[1] * x51 - x4 * (-wL[11] + wR[11]) -
               0.188025358F * x40 + 0.0445435403F * x41 + 0.188025358F * x43 -
               0.0445435403F * x45 + x46 * x47 + x49 * x50;
    flux[12] = 0.15430335F * vn[0] * x18 + 0.15430335F * vn[1] * x15 -
               x4 * (-wL[12] + wR[12]) - x46 * x53 - x49 * x52;
    flux[13] = -vn[0] * x51 + vn[1] * x48 - x4 * (-wL[13] + wR[13]) -
               x46 * x50 + x47 * x49 - 0.188025358F * x54 +
               0.0445435403F * x55 - 0.188025358F * x56 + 0.0445435403F * x57;
    flux[14] = -vn[0] * x44 - vn[1] * x38 - x4 * (-wL[14] + wR[14]) +
               0.0355334527F * x54 - 0.23570226F * x55 - 0.0355334527F * x56 +
               0.23570226F * x57;
    flux[15] =
        -x4 * (-wL[15] + wR[15]) - 0.238365647F * x58 - 0.238365647F * x59;
    flux[16] = -0.188025358F * x27 - 0.188025358F * x30 -
               x4 * (-wL[16] + wR[16]) + 0.0355334527F * x58 -
               0.0355334527F * x59;
    flux[17] = 0.087038828F * x27 - 0.087038828F * x30 - x34 * x53 -
               x4 * (-wL[17] + wR[17]);
    flux[18] = -x34 * x52 + 0.087038828F * x36 + 0.087038828F * x37 -
               x4 * (-wL[18] + wR[18]);
    flux[19] = -0.188025358F * x36 + 0.188025358F * x37 -
               x4 * (-wL[19] + wR[19]) + 0.0355334527F * x60 +
               0.0355334527F * x61;
    flux[20] =
        -x4 * (-wL[20] + wR[20]) - 0.238365647F * x60 + 0.238365647F * x61;
}

#else

void num_flux_rus(const float wL[36], const float wR[36], const float vn[3],
                  float flux[36])
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
    const float x20 = wL[9] + wR[9];
    const float x21 = 0.231455025F * x20;
    const float x22 = wL[13] + wR[13];
    const float x23 = 0.0597614305F * vn[1];
    const float x24 = wL[15] + wR[15];
    const float x25 = 0.231455025F * x24;
    const float x26 = wL[10] + wR[10];
    const float x27 = 0.188982236F * x26;
    const float x28 = wL[12] + wR[12];
    const float x29 = 0.146385011F * x28;
    const float x30 = wL[14] + wR[14];
    const float x31 = 0.188982236F * x30;
    const float x32 = 0.239045722F * vn[2];
    const float x33 = 0.207019668F * vn[0];
    const float x34 = 0.207019668F * vn[1];
    const float x35 = 0.253546276F * vn[2];
    const float x36 = wL[16] + wR[16];
    const float x37 = 0.23570226F * x36;
    const float x38 = wL[18] + wR[18];
    const float x39 = vn[0] * x38;
    const float x40 = 0.231455025F * x7;
    const float x41 = wL[22] + wR[22];
    const float x42 = vn[1] * x41;
    const float x43 = wL[24] + wR[24];
    const float x44 = 0.23570226F * x43;
    const float x45 = 0.231455025F * x12;
    const float x46 = wL[17] + wR[17];
    const float x47 = 0.166666667F * vn[2];
    const float x48 = 0.204124145F * x46;
    const float x49 = wL[19] + wR[19];
    const float x50 = 0.077151675F * vn[0];
    const float x51 = 0.188982236F * x14;
    const float x52 = wL[21] + wR[21];
    const float x53 = 0.077151675F * vn[1];
    const float x54 = wL[23] + wR[23];
    const float x55 = 0.204124145F * x54;
    const float x56 = 0.188982236F * x16;
    const float x57 = 0.21821789F * vn[2];
    const float x58 = 0.188982236F * vn[2];
    const float x59 = wL[20] + wR[20];
    const float x60 = 0.15430335F * x59;
    const float x61 = 0.243975018F * vn[2];
    const float x62 = 0.199204768F * vn[0];
    const float x63 = 0.199204768F * vn[1];
    const float x64 = 0.251976315F * vn[2];
    const float x65 = vn[0] * x41;
    const float x66 = vn[1] * x38;
    const float x67 = 0.238365647F * wL[25] + 0.238365647F * wR[25];
    const float x68 = wL[27] + wR[27];
    const float x69 = vn[0] * x68;
    const float x70 = vn[0] * x20;
    const float x71 = vn[1] * x24;
    const float x72 = wL[33] + wR[33];
    const float x73 = vn[1] * x72;
    const float x74 = 0.238365647F * wL[35] + 0.238365647F * wR[35];
    const float x75 = wL[26] + wR[26];
    const float x76 = 0.150755672F * vn[2];
    const float x77 = 0.204124145F * x26;
    const float x78 = 0.213200716F * x75;
    const float x79 = wL[28] + wR[28];
    const float x80 = vn[0] * x79;
    const float x81 = 0.204124145F * x30;
    const float x82 = wL[32] + wR[32];
    const float x83 = vn[1] * x82;
    const float x84 = wL[34] + wR[34];
    const float x85 = 0.213200716F * x84;
    const float x86 = 0.201007563F * vn[2];
    const float x87 = 0.17251639F * x18;
    const float x88 = wL[29] + wR[29];
    const float x89 = 0.087038828F * vn[0];
    const float x90 = 0.17251639F * x22;
    const float x91 = wL[31] + wR[31];
    const float x92 = 0.087038828F * vn[1];
    const float x93 = 0.230283093F * vn[2];
    const float x94 = wL[30] + wR[30];
    const float x95 = 0.158910432F * x94;
    const float x96 = 0.246182982F * vn[2];
    const float x97 = 0.194624736F * vn[0];
    const float x98 = 0.194624736F * vn[1];
    const float x99 = 0.251259454F * vn[2];
    const float x100 = vn[0] * x82;
    const float x101 = vn[1] * x79;
    const float x102 = vn[0] * x24;
    const float x103 = vn[0] * x72;
    const float x104 = vn[1] * x68;
    const float x105 = vn[1] * x20;
    const float x106 = vn[0] * x36;
    const float x107 = vn[1] * x43;
    const float x108 = vn[0] * x46;
    const float x109 = vn[1] * x54;
    const float x110 = 0.162834737F * x49;
    const float x111 = 0.162834737F * x52;
    const float x112 = vn[0] * x54;
    const float x113 = vn[1] * x46;
    const float x114 = vn[0] * x43;
    const float x115 = vn[1] * x36;
    flux[0] = -x0 * x1 - x2 * x3 + x4 * x5 - x6 * (-wL[0] + wR[0]);
    flux[1] = vn[1] * x11 + x12 * x13 + x14 * x15 - x3 * x9 -
              x6 * (-wL[1] + wR[1]) - x7 * x8;
    flux[2] =
        x10 * x17 - x13 * x14 - x16 * x8 + x5 * x9 - x6 * (-wL[2] + wR[2]);
    flux[3] = vn[0] * x11 - x1 * x9 - x12 * x8 - x13 * x7 + x15 * x16 -
              x6 * (-wL[3] + wR[3]);
    flux[4] = -vn[0] * x21 + vn[1] * x25 + vn[2] * x27 - x0 * x13 + x18 * x19 -
              x2 * x8 + x22 * x23 - x6 * (-wL[4] + wR[4]);
    flux[5] = -vn[0] * x27 + vn[1] * x29 + vn[1] * x31 - x13 * x4 + x15 * x2 +
              x18 * x32 - x6 * (-wL[5] + wR[5]);
    flux[6] = 0.129099445F * vn[0] * x0 + 0.129099445F * vn[1] * x2 + x17 * x4 -
              x18 * x34 - x22 * x33 + x28 * x35 - x6 * (-wL[6] + wR[6]);
    flux[7] = vn[0] * x29 - vn[0] * x31 - vn[1] * x27 + x0 * x15 + x22 * x32 -
              x4 * x8 - x6 * (-wL[7] + wR[7]);
    flux[8] = -vn[0] * x25 - vn[1] * x21 + vn[2] * x31 - x0 * x8 + x13 * x2 -
              x18 * x23 + x19 * x22 - x6 * (-wL[8] + wR[8]);
    flux[9] = -vn[0] * x37 - vn[0] * x40 + vn[1] * x44 - vn[1] * x45 +
              0.0445435403F * x39 + 0.0445435403F * x42 + x46 * x47 -
              x6 * (-wL[9] + wR[9]);
    flux[10] = -vn[0] * x48 - vn[0] * x51 + vn[1] * x55 - vn[1] * x56 +
               x38 * x57 + x49 * x50 + x52 * x53 + x58 * x7 -
               x6 * (-wL[10] + wR[10]);
    flux[11] = vn[1] * x60 - x10 * x34 - x12 * x23 + x14 * x32 + x19 * x7 -
               0.17251639F * x39 + 0.17251639F * x42 + x49 * x61 -
               x6 * (-wL[11] + wR[11]);
    flux[12] = 0.146385011F * vn[0] * x16 + 0.146385011F * vn[1] * x14 +
               x10 * x35 - x49 * x63 - x52 * x62 + x59 * x64 -
               x6 * (-wL[12] + wR[12]);
    flux[13] = vn[0] * x60 - x10 * x33 + x12 * x19 + x16 * x32 + x23 * x7 +
               x52 * x61 - x6 * (-wL[13] + wR[13]) - 0.17251639F * x65 -
               0.17251639F * x66;
    flux[14] = -vn[0] * x55 - vn[0] * x56 - vn[1] * x48 + vn[1] * x51 +
               x12 * x58 + x41 * x57 - x49 * x53 + x50 * x52 -
               x6 * (-wL[14] + wR[14]);
    flux[15] = -vn[0] * x44 - vn[0] * x45 - vn[1] * x37 + vn[1] * x40 +
               x47 * x54 - x6 * (-wL[15] + wR[15]) + 0.0445435403F * x65 -
               0.0445435403F * x66;
    flux[16] = -vn[0] * x67 + vn[1] * x74 - x6 * (-wL[16] + wR[16]) +
               0.0355334527F * x69 - 0.23570226F * x70 - 0.23570226F * x71 +
               0.0355334527F * x73 + x75 * x76;
    flux[17] = -vn[0] * x77 - vn[0] * x78 - vn[1] * x81 + vn[1] * x85 +
               x20 * x47 - x6 * (-wL[17] + wR[17]) + x68 * x86 +
               0.0615457455F * x80 + 0.0615457455F * x83;
    flux[18] = -vn[0] * x87 - vn[1] * x90 + x26 * x57 -
               x6 * (-wL[18] + wR[18]) - 0.188025358F * x69 +
               0.0445435403F * x70 - 0.0445435403F * x71 + 0.188025358F * x73 +
               x79 * x93 + x88 * x89 + x91 * x92;
    flux[19] = vn[1] * x95 + x18 * x61 + x26 * x50 - x28 * x63 - x30 * x53 -
               x6 * (-wL[19] + wR[19]) - 0.162834737F * x80 +
               0.162834737F * x83 + x88 * x96;
    flux[20] = 0.15430335F * vn[0] * x22 + 0.15430335F * vn[1] * x18 +
               x28 * x64 - x6 * (-wL[20] + wR[20]) - x88 * x98 - x91 * x97 +
               x94 * x99;
    flux[21] = vn[0] * x95 - 0.162834737F * x100 - 0.162834737F * x101 +
               x22 * x61 + x26 * x53 - x28 * x62 + x30 * x50 -
               x6 * (-wL[21] + wR[21]) + x91 * x96;
    flux[22] = -vn[0] * x90 + vn[1] * x87 + 0.0445435403F * x102 -
               0.188025358F * x103 - 0.188025358F * x104 +
               0.0445435403F * x105 + x30 * x57 - x6 * (-wL[22] + wR[22]) +
               x82 * x93 - x88 * x92 + x89 * x91;
    flux[23] = -vn[0] * x81 - vn[0] * x85 + vn[1] * x77 - vn[1] * x78 +
               0.0615457455F * x100 - 0.0615457455F * x101 + x24 * x47 -
               x6 * (-wL[23] + wR[23]) + x72 * x86;
    flux[24] = -vn[0] * x74 - vn[1] * x67 - 0.23570226F * x102 +
               0.0355334527F * x103 - 0.0355334527F * x104 +
               0.23570226F * x105 - x6 * (-wL[24] + wR[24]) + x76 * x84;
    flux[25] =
        -0.238365647F * x106 - 0.238365647F * x107 - x6 * (-wL[25] + wR[25]);
    flux[26] = -0.213200716F * x108 - 0.213200716F * x109 + x36 * x76 -
               x6 * (-wL[26] + wR[26]);
    flux[27] = 0.0355334527F * x106 - 0.0355334527F * x107 -
               0.188025358F * x39 - 0.188025358F * x42 + x46 * x86 -
               x6 * (-wL[27] + wR[27]);
    flux[28] = -vn[0] * x110 - vn[1] * x111 + 0.0615457455F * x108 -
               0.0615457455F * x109 + x38 * x93 - x6 * (-wL[28] + wR[28]);
    flux[29] = 0.087038828F * x39 - 0.087038828F * x42 + x49 * x96 - x59 * x98 -
               x6 * (-wL[29] + wR[29]);
    flux[30] = 0.158910432F * vn[0] * x52 + 0.158910432F * vn[1] * x49 +
               x59 * x99 - x6 * (-wL[30] + wR[30]);
    flux[31] = x52 * x96 - x59 * x97 - x6 * (-wL[31] + wR[31]) +
               0.087038828F * x65 + 0.087038828F * x66;
    flux[32] = -vn[0] * x111 + vn[1] * x110 + 0.0615457455F * x112 +
               0.0615457455F * x113 + x41 * x93 - x6 * (-wL[32] + wR[32]);
    flux[33] = 0.0355334527F * x114 + 0.0355334527F * x115 + x54 * x86 -
               x6 * (-wL[33] + wR[33]) - 0.188025358F * x65 +
               0.188025358F * x66;
    flux[34] = -0.213200716F * x112 + 0.213200716F * x113 + x43 * x76 -
               x6 * (-wL[34] + wR[34]);
    flux[35] =
        -0.238365647F * x114 + 0.238365647F * x115 - x6 * (-wL[35] + wR[35]);
}

#endif

#endif
#endif
