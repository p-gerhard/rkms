#ifndef P7_CL
#define P7_CL

#ifdef USE_DOUBLE

#ifdef IS_2D

void num_flux_rus(const double wL[36], const double wR[36], const double vn[2],
                  double flux[36])
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
    const double x38 = wL[15] + wR[15];
    const double x39 = 0.23836564731139809 * x38;
    const double x40 = wL[16] + wR[16];
    const double x41 = vn[0] * x40;
    const double x42 = vn[0] * x13;
    const double x43 = wL[19] + wR[19];
    const double x44 = vn[1] * x43;
    const double x45 = wL[20] + wR[20];
    const double x46 = 0.23836564731139809 * x45;
    const double x47 = vn[1] * x20;
    const double x48 = wL[17] + wR[17];
    const double x49 = 0.087038827977848926 * vn[0];
    const double x50 = 0.17251638983558854 * x15;
    const double x51 = wL[18] + wR[18];
    const double x52 = 0.087038827977848926 * vn[1];
    const double x53 = 0.17251638983558854 * x18;
    const double x54 = 0.19462473604038075 * vn[0];
    const double x55 = 0.19462473604038075 * vn[1];
    const double x56 = vn[0] * x43;
    const double x57 = vn[0] * x20;
    const double x58 = vn[1] * x40;
    const double x59 = vn[1] * x13;
    const double x60 = vn[0] * x24;
    const double x61 = wL[21] + wR[21];
    const double x62 = 0.24019223070763071 * x61;
    const double x63 = wL[22] + wR[22];
    const double x64 = vn[0] * x63;
    const double x65 = vn[1] * x31;
    const double x66 = wL[26] + wR[26];
    const double x67 = vn[1] * x66;
    const double x68 = wL[27] + wR[27];
    const double x69 = 0.24019223070763071 * x68;
    const double x70 = wL[23] + wR[23];
    const double x71 = vn[0] * x70;
    const double x72 = wL[25] + wR[25];
    const double x73 = vn[1] * x72;
    const double x74 = wL[24] + wR[24];
    const double x75 = 0.16193756890782393 * x74;
    const double x76 = vn[0] * x72;
    const double x77 = vn[1] * x70;
    const double x78 = vn[0] * x31;
    const double x79 = vn[0] * x66;
    const double x80 = vn[1] * x24;
    const double x81 = vn[1] * x63;
    const double x82 = vn[0] * x38;
    const double x83 =
        0.24152294576982397 * wL[28] + 0.24152294576982397 * wR[28];
    const double x84 = wL[29] + wR[29];
    const double x85 = vn[0] * x84;
    const double x86 = vn[1] * x45;
    const double x87 = wL[34] + wR[34];
    const double x88 = vn[1] * x87;
    const double x89 =
        0.24152294576982397 * wL[35] + 0.24152294576982397 * wR[35];
    const double x90 = wL[30] + wR[30];
    const double x91 = vn[0] * x90;
    const double x92 = wL[33] + wR[33];
    const double x93 = vn[1] * x92;
    const double x94 = 0.15644655469368599 * x48;
    const double x95 = wL[31] + wR[31];
    const double x96 = 0.098058067569092008 * vn[0];
    const double x97 = 0.15644655469368599 * x51;
    const double x98 = wL[32] + wR[32];
    const double x99 = 0.098058067569092008 * vn[1];
    const double x100 = 0.18946618668626838 * vn[0];
    const double x101 = 0.18946618668626838 * vn[1];
    const double x102 = vn[0] * x92;
    const double x103 = vn[1] * x90;
    const double x104 = vn[0] * x45;
    const double x105 = vn[0] * x87;
    const double x106 = vn[1] * x38;
    const double x107 = vn[1] * x84;
    const double x108 = vn[0] * x61;
    const double x109 = vn[1] * x68;
    const double x110 = vn[0] * x68;
    const double x111 = vn[1] * x61;
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
    flux[10] = -vn[0] * x39 + vn[1] * x46 - x4 * (-wL[10] + wR[10]) +
               0.035533452725935076 * x41 - 0.23570226039551584 * x42 +
               0.035533452725935076 * x44 - 0.23570226039551584 * x47;
    flux[11] = -vn[0] * x50 - vn[1] * x53 - x4 * (-wL[11] + wR[11]) -
               0.18802535827258876 * x41 + 0.044543540318737397 * x42 +
               0.18802535827258876 * x44 - 0.044543540318737397 * x47 +
               x48 * x49 + x51 * x52;
    flux[12] = 0.15430334996209191 * vn[0] * x18 +
               0.15430334996209191 * vn[1] * x15 - x4 * (-wL[12] + wR[12]) -
               x48 * x55 - x51 * x54;
    flux[13] = -vn[0] * x53 + vn[1] * x50 - x4 * (-wL[13] + wR[13]) -
               x48 * x52 + x49 * x51 - 0.18802535827258876 * x56 +
               0.044543540318737397 * x57 - 0.18802535827258876 * x58 +
               0.044543540318737397 * x59;
    flux[14] = -vn[0] * x46 - vn[1] * x39 - x4 * (-wL[14] + wR[14]) +
               0.035533452725935076 * x56 - 0.23570226039551584 * x57 -
               0.035533452725935076 * x58 + 0.23570226039551584 * x59;
    flux[15] = -vn[0] * x62 + vn[1] * x69 - x4 * (-wL[15] + wR[15]) -
               0.23836564731139809 * x60 + 0.029565619799454133 * x64 -
               0.23836564731139809 * x65 + 0.029565619799454133 * x67;
    flux[16] = -0.18802535827258876 * x27 - 0.18802535827258876 * x30 -
               x4 * (-wL[16] + wR[16]) + 0.035533452725935076 * x60 -
               0.19833220700547941 * x64 - 0.035533452725935076 * x65 +
               0.19833220700547941 * x67 + 0.072420682437790138 * x71 +
               0.072420682437790138 * x73;
    flux[17] = vn[1] * x75 + 0.087038827977848926 * x27 -
               0.087038827977848926 * x30 - x34 * x55 -
               x4 * (-wL[17] + wR[17]) - 0.15644655469368599 * x71 +
               0.15644655469368599 * x73;
    flux[18] = vn[0] * x75 - x34 * x54 + 0.087038827977848926 * x36 +
               0.087038827977848926 * x37 - x4 * (-wL[18] + wR[18]) -
               0.15644655469368599 * x76 - 0.15644655469368599 * x77;
    flux[19] = -0.18802535827258876 * x36 + 0.18802535827258876 * x37 -
               x4 * (-wL[19] + wR[19]) + 0.072420682437790138 * x76 -
               0.072420682437790138 * x77 + 0.035533452725935076 * x78 -
               0.19833220700547941 * x79 + 0.035533452725935076 * x80 -
               0.19833220700547941 * x81;
    flux[20] = -vn[0] * x69 - vn[1] * x62 - x4 * (-wL[20] + wR[20]) -
               0.23836564731139809 * x78 + 0.029565619799454133 * x79 +
               0.23836564731139809 * x80 - 0.029565619799454133 * x81;
    flux[21] = -vn[0] * x83 + vn[1] * x89 - x4 * (-wL[21] + wR[21]) -
               0.24019223070763071 * x82 + 0.025318484177091663 * x85 -
               0.24019223070763071 * x86 + 0.025318484177091663 * x88;
    flux[22] = -x4 * (-wL[22] + wR[22]) - 0.19833220700547941 * x41 -
               0.19833220700547941 * x44 + 0.029565619799454133 * x82 -
               0.2056883378018606 * x85 - 0.029565619799454133 * x86 +
               0.2056883378018606 * x88 + 0.062017367294604227 * x91 +
               0.062017367294604227 * x93;
    flux[23] = -vn[0] * x94 - vn[1] * x97 - x4 * (-wL[23] + wR[23]) +
               0.072420682437790138 * x41 - 0.072420682437790138 * x44 -
               0.16984155512168939 * x91 + 0.16984155512168939 * x93 +
               x95 * x96 + x98 * x99;
    flux[24] = 0.16193756890782393 * vn[0] * x51 +
               0.16193756890782393 * vn[1] * x48 - x100 * x98 - x101 * x95 -
               x4 * (-wL[24] + wR[24]);
    flux[25] = -vn[0] * x97 + vn[1] * x94 - 0.16984155512168939 * x102 -
               0.16984155512168939 * x103 - x4 * (-wL[25] + wR[25]) +
               0.072420682437790138 * x56 + 0.072420682437790138 * x58 -
               x95 * x99 + x96 * x98;
    flux[26] = 0.062017367294604227 * x102 - 0.062017367294604227 * x103 +
               0.029565619799454133 * x104 - 0.2056883378018606 * x105 +
               0.029565619799454133 * x106 - 0.2056883378018606 * x107 -
               x4 * (-wL[26] + wR[26]) - 0.19833220700547941 * x56 +
               0.19833220700547941 * x58;
    flux[27] = -vn[0] * x89 - vn[1] * x83 - 0.24019223070763071 * x104 +
               0.025318484177091663 * x105 + 0.24019223070763071 * x106 -
               0.025318484177091663 * x107 - x4 * (-wL[27] + wR[27]);
    flux[28] = -0.24152294576982397 * x108 - 0.24152294576982397 * x109 -
               x4 * (-wL[28] + wR[28]);
    flux[29] = 0.025318484177091663 * x108 - 0.025318484177091663 * x109 -
               x4 * (-wL[29] + wR[29]) - 0.2056883378018606 * x64 -
               0.2056883378018606 * x67;
    flux[30] = -x4 * (-wL[30] + wR[30]) + 0.062017367294604227 * x64 -
               0.062017367294604227 * x67 - 0.16984155512168939 * x71 -
               0.16984155512168939 * x73;
    flux[31] = -x101 * x74 - x4 * (-wL[31] + wR[31]) +
               0.098058067569092008 * x71 - 0.098058067569092008 * x73;
    flux[32] = -x100 * x74 - x4 * (-wL[32] + wR[32]) +
               0.098058067569092008 * x76 + 0.098058067569092008 * x77;
    flux[33] = -x4 * (-wL[33] + wR[33]) - 0.16984155512168939 * x76 +
               0.16984155512168939 * x77 + 0.062017367294604227 * x79 +
               0.062017367294604227 * x81;
    flux[34] = 0.025318484177091663 * x110 + 0.025318484177091663 * x111 -
               x4 * (-wL[34] + wR[34]) - 0.2056883378018606 * x79 +
               0.2056883378018606 * x81;
    flux[35] = -0.24152294576982397 * x110 + 0.24152294576982397 * x111 -
               x4 * (-wL[35] + wR[35]);
}

#else

void num_flux_rus(const double wL[64], const double wR[64], const double vn[3],
                  double flux[64])
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
    const double x67 = wL[25] + wR[25];
    const double x68 = 0.23836564731139809 * x67;
    const double x69 = wL[27] + wR[27];
    const double x70 = vn[0] * x69;
    const double x71 = vn[0] * x20;
    const double x72 = vn[1] * x24;
    const double x73 = wL[33] + wR[33];
    const double x74 = vn[1] * x73;
    const double x75 = wL[35] + wR[35];
    const double x76 = 0.23836564731139809 * x75;
    const double x77 = wL[26] + wR[26];
    const double x78 = 0.15075567228888181 * vn[2];
    const double x79 = 0.20412414523193148 * x26;
    const double x80 = 0.21320071635561044 * x77;
    const double x81 = wL[28] + wR[28];
    const double x82 = vn[0] * x81;
    const double x83 = 0.20412414523193148 * x30;
    const double x84 = wL[32] + wR[32];
    const double x85 = vn[1] * x84;
    const double x86 = wL[34] + wR[34];
    const double x87 = 0.21320071635561044 * x86;
    const double x88 = 0.20100756305184242 * vn[2];
    const double x89 = 0.17251638983558854 * x18;
    const double x90 = wL[29] + wR[29];
    const double x91 = 0.087038827977848926 * vn[0];
    const double x92 = 0.17251638983558854 * x22;
    const double x93 = wL[31] + wR[31];
    const double x94 = 0.087038827977848926 * vn[1];
    const double x95 = 0.23028309323591917 * vn[2];
    const double x96 = wL[30] + wR[30];
    const double x97 = 0.15891043154093207 * x96;
    const double x98 = 0.24618298195866548 * vn[2];
    const double x99 = 0.19462473604038075 * vn[0];
    const double x100 = 0.19462473604038075 * vn[1];
    const double x101 = 0.25125945381480302 * vn[2];
    const double x102 = vn[0] * x84;
    const double x103 = vn[1] * x81;
    const double x104 = vn[0] * x24;
    const double x105 = vn[0] * x73;
    const double x106 = vn[1] * x69;
    const double x107 = vn[1] * x20;
    const double x108 = vn[0] * x36;
    const double x109 = wL[36] + wR[36];
    const double x110 = 0.24019223070763071 * x109;
    const double x111 = wL[38] + wR[38];
    const double x112 = vn[0] * x111;
    const double x113 = vn[1] * x43;
    const double x114 = wL[46] + wR[46];
    const double x115 = vn[1] * x114;
    const double x116 = wL[48] + wR[48];
    const double x117 = 0.24019223070763071 * x116;
    const double x118 = wL[37] + wR[37];
    const double x119 = 0.13867504905630729 * vn[2];
    const double x120 = vn[0] * x46;
    const double x121 = 0.2192645048267573 * x118;
    const double x122 = wL[39] + wR[39];
    const double x123 = vn[0] * x122;
    const double x124 = vn[1] * x54;
    const double x125 = wL[45] + wR[45];
    const double x126 = vn[1] * x125;
    const double x127 = wL[47] + wR[47];
    const double x128 = 0.2192645048267573 * x127;
    const double x129 = 0.18698939800169145 * vn[2];
    const double x130 = wL[40] + wR[40];
    const double x131 = vn[0] * x130;
    const double x132 = wL[44] + wR[44];
    const double x133 = vn[1] * x132;
    const double x134 = 0.21726204731337043 * vn[2];
    const double x135 = 0.1628347368197324 * x49;
    const double x136 = wL[41] + wR[41];
    const double x137 = 0.093494699000845727 * vn[0];
    const double x138 = 0.1628347368197324 * x52;
    const double x139 = wL[43] + wR[43];
    const double x140 = 0.093494699000845727 * vn[1];
    const double x141 = 0.23652495839563306 * vn[2];
    const double x142 = wL[42] + wR[42];
    const double x143 = 0.16193756890782393 * x142;
    const double x144 = 0.24736372245907681 * vn[2];
    const double x145 = 0.19160711550797563 * vn[0];
    const double x146 = 0.19160711550797563 * vn[1];
    const double x147 = 0.25087260300212727 * vn[2];
    const double x148 = vn[0] * x132;
    const double x149 = vn[1] * x130;
    const double x150 = vn[0] * x54;
    const double x151 = vn[0] * x125;
    const double x152 = vn[1] * x46;
    const double x153 = vn[1] * x122;
    const double x154 = vn[0] * x43;
    const double x155 = vn[0] * x114;
    const double x156 = vn[1] * x36;
    const double x157 = vn[1] * x111;
    const double x158 = vn[0] * x67;
    const double x159 =
        0.24152294576982397 * wL[49] + 0.24152294576982397 * wR[49];
    const double x160 = wL[51] + wR[51];
    const double x161 = vn[0] * x160;
    const double x162 = vn[1] * x75;
    const double x163 = wL[61] + wR[61];
    const double x164 = vn[1] * x163;
    const double x165 =
        0.24152294576982397 * wL[63] + 0.24152294576982397 * wR[63];
    const double x166 = wL[50] + wR[50];
    const double x167 = 0.12909944487358058 * vn[2];
    const double x168 = vn[0] * x77;
    const double x169 = wL[52] + wR[52];
    const double x170 = vn[0] * x169;
    const double x171 = vn[1] * x86;
    const double x172 = wL[60] + wR[60];
    const double x173 = vn[1] * x172;
    const double x174 = wL[62] + wR[62];
    const double x175 = 0.17541160386140583 * vn[2];
    const double x176 = wL[53] + wR[53];
    const double x177 = vn[0] * x176;
    const double x178 = wL[59] + wR[59];
    const double x179 = vn[1] * x178;
    const double x180 = 0.2056883378018606 * vn[2];
    const double x181 = wL[54] + wR[54];
    const double x182 = vn[0] * x181;
    const double x183 = wL[58] + wR[58];
    const double x184 = vn[1] * x183;
    const double x185 = 0.22645540682891915 * vn[2];
    const double x186 = 0.15644655469368599 * x90;
    const double x187 = wL[55] + wR[55];
    const double x188 = 0.098058067569092008 * vn[0];
    const double x189 = 0.15644655469368599 * x93;
    const double x190 = wL[57] + wR[57];
    const double x191 = 0.098058067569092008 * vn[1];
    const double x192 = 0.24019223070763071 * vn[2];
    const double x193 = wL[56] + wR[56];
    const double x194 = 0.16408253082847341 * x193;
    const double x195 = 0.24806946917841691 * vn[2];
    const double x196 = 0.18946618668626838 * vn[0];
    const double x197 = 0.18946618668626838 * vn[1];
    const double x198 = 0.25064020591380148 * vn[2];
    const double x199 = vn[0] * x183;
    const double x200 = vn[1] * x181;
    const double x201 = vn[0] * x178;
    const double x202 = vn[1] * x176;
    const double x203 = vn[0] * x86;
    const double x204 = vn[0] * x172;
    const double x205 = vn[1] * x77;
    const double x206 = vn[1] * x169;
    const double x207 = vn[0] * x75;
    const double x208 = vn[0] * x163;
    const double x209 = vn[1] * x67;
    const double x210 = vn[1] * x160;
    const double x211 = vn[0] * x109;
    const double x212 = vn[1] * x116;
    const double x213 = 0.043852900965351459 * vn[0];
    const double x214 = 0.043852900965351459 * vn[1];
    const double x215 = 0.15191090506254998 * x136;
    const double x216 = 0.15191090506254998 * x139;
    const double x217 = vn[0] * x116;
    const double x218 = vn[1] * x109;
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
    flux[16] = -vn[0] * x68 + vn[1] * x76 - x6 * (-wL[16] + wR[16]) +
               0.035533452725935076 * x70 - 0.23570226039551584 * x71 -
               0.23570226039551584 * x72 + 0.035533452725935076 * x74 +
               x77 * x78;
    flux[17] = -vn[0] * x79 - vn[0] * x80 - vn[1] * x83 + vn[1] * x87 +
               x20 * x47 - x6 * (-wL[17] + wR[17]) + x69 * x88 +
               0.061545745489666369 * x82 + 0.061545745489666369 * x85;
    flux[18] = -vn[0] * x89 - vn[1] * x92 + x26 * x57 -
               x6 * (-wL[18] + wR[18]) - 0.18802535827258876 * x70 +
               0.044543540318737397 * x71 - 0.044543540318737397 * x72 +
               0.18802535827258876 * x74 + x81 * x95 + x90 * x91 + x93 * x94;
    flux[19] = vn[1] * x97 + x18 * x61 + x26 * x50 - x28 * x63 - x30 * x53 -
               x6 * (-wL[19] + wR[19]) - 0.1628347368197324 * x82 +
               0.1628347368197324 * x85 + x90 * x98;
    flux[20] = 0.15430334996209191 * vn[0] * x22 +
               0.15430334996209191 * vn[1] * x18 - x100 * x90 + x101 * x96 +
               x28 * x64 - x6 * (-wL[20] + wR[20]) - x93 * x99;
    flux[21] = vn[0] * x97 - 0.1628347368197324 * x102 -
               0.1628347368197324 * x103 + x22 * x61 + x26 * x53 - x28 * x62 +
               x30 * x50 - x6 * (-wL[21] + wR[21]) + x93 * x98;
    flux[22] = -vn[0] * x92 + vn[1] * x89 + 0.044543540318737397 * x104 -
               0.18802535827258876 * x105 - 0.18802535827258876 * x106 +
               0.044543540318737397 * x107 + x30 * x57 -
               x6 * (-wL[22] + wR[22]) + x84 * x95 - x90 * x94 + x91 * x93;
    flux[23] = -vn[0] * x83 - vn[0] * x87 + vn[1] * x79 - vn[1] * x80 +
               0.061545745489666369 * x102 - 0.061545745489666369 * x103 +
               x24 * x47 - x6 * (-wL[23] + wR[23]) + x73 * x88;
    flux[24] = -vn[0] * x76 - vn[1] * x68 - 0.23570226039551584 * x104 +
               0.035533452725935076 * x105 - 0.035533452725935076 * x106 +
               0.23570226039551584 * x107 - x6 * (-wL[24] + wR[24]) + x78 * x86;
    flux[25] = -vn[0] * x110 + vn[1] * x117 - 0.23836564731139809 * x108 +
               0.029565619799454133 * x112 - 0.23836564731139809 * x113 +
               0.029565619799454133 * x115 + x118 * x119 -
               x6 * (-wL[25] + wR[25]);
    flux[26] = -vn[0] * x121 + vn[1] * x128 + x111 * x129 -
               0.21320071635561044 * x120 + 0.051209155649918917 * x123 -
               0.21320071635561044 * x124 + 0.051209155649918917 * x126 +
               x36 * x78 - x6 * (-wL[26] + wR[26]);
    flux[27] = 0.035533452725935076 * x108 - 0.19833220700547941 * x112 -
               0.035533452725935076 * x113 + 0.19833220700547941 * x115 +
               x122 * x134 + 0.072420682437790138 * x131 +
               0.072420682437790138 * x133 - 0.18802535827258876 * x39 -
               0.18802535827258876 * x42 + x46 * x88 - x6 * (-wL[27] + wR[27]);
    flux[28] = -vn[0] * x135 - vn[1] * x138 + 0.061545745489666369 * x120 -
               0.1773937187967248 * x123 - 0.061545745489666369 * x124 +
               0.1773937187967248 * x126 + x130 * x141 + x136 * x137 +
               x139 * x140 + x38 * x95 - x6 * (-wL[28] + wR[28]);
    flux[29] = vn[1] * x143 - x100 * x59 - 0.15644655469368599 * x131 +
               0.15644655469368599 * x133 + x136 * x144 +
               0.087038827977848926 * x39 - 0.087038827977848926 * x42 +
               x49 * x98 - x6 * (-wL[29] + wR[29]);
    flux[30] = 0.15891043154093207 * vn[0] * x52 +
               0.15891043154093207 * vn[1] * x49 + x101 * x59 - x136 * x146 -
               x139 * x145 + x142 * x147 - x6 * (-wL[30] + wR[30]);
    flux[31] = vn[0] * x143 + x139 * x144 - 0.15644655469368599 * x148 -
               0.15644655469368599 * x149 + x52 * x98 - x59 * x99 -
               x6 * (-wL[31] + wR[31]) + 0.087038827977848926 * x65 +
               0.087038827977848926 * x66;
    flux[32] = -vn[0] * x138 + vn[1] * x135 + x132 * x141 - x136 * x140 +
               x137 * x139 + 0.061545745489666369 * x150 -
               0.1773937187967248 * x151 + 0.061545745489666369 * x152 -
               0.1773937187967248 * x153 + x41 * x95 - x6 * (-wL[32] + wR[32]);
    flux[33] = x125 * x134 + 0.072420682437790138 * x148 -
               0.072420682437790138 * x149 + 0.035533452725935076 * x154 -
               0.19833220700547941 * x155 + 0.035533452725935076 * x156 -
               0.19833220700547941 * x157 + x54 * x88 -
               x6 * (-wL[33] + wR[33]) - 0.18802535827258876 * x65 +
               0.18802535827258876 * x66;
    flux[34] = -vn[0] * x128 - vn[1] * x121 + x114 * x129 -
               0.21320071635561044 * x150 + 0.051209155649918917 * x151 +
               0.21320071635561044 * x152 - 0.051209155649918917 * x153 +
               x43 * x78 - x6 * (-wL[34] + wR[34]);
    flux[35] = -vn[0] * x117 - vn[1] * x110 + x119 * x127 -
               0.23836564731139809 * x154 + 0.029565619799454133 * x155 +
               0.23836564731139809 * x156 - 0.029565619799454133 * x157 -
               x6 * (-wL[35] + wR[35]);
    flux[36] = -vn[0] * x159 + vn[1] * x165 - 0.24019223070763071 * x158 +
               0.025318484177091663 * x161 - 0.24019223070763071 * x162 +
               0.025318484177091663 * x164 + x166 * x167 -
               x6 * (-wL[36] + wR[36]);
    flux[37] = x119 * x67 + x13 * x174 + x160 * x175 - x166 * x8 -
               0.2192645048267573 * x168 + 0.043852900965351459 * x170 -
               0.2192645048267573 * x171 + 0.043852900965351459 * x173 -
               x6 * (-wL[37] + wR[37]);
    flux[38] = x129 * x77 + 0.029565619799454133 * x158 -
               0.2056883378018606 * x161 - 0.029565619799454133 * x162 +
               0.2056883378018606 * x164 + x169 * x180 +
               0.062017367294604227 * x177 + 0.062017367294604227 * x179 -
               x6 * (-wL[38] + wR[38]) - 0.19833220700547941 * x70 -
               0.19833220700547941 * x74;
    flux[39] = x134 * x69 + 0.051209155649918917 * x168 -
               0.1877669040497027 * x170 - 0.051209155649918917 * x171 +
               0.1877669040497027 * x173 + x176 * x185 +
               0.080064076902543566 * x182 + 0.080064076902543566 * x184 -
               x6 * (-wL[39] + wR[39]) - 0.1773937187967248 * x82 -
               0.1773937187967248 * x85;
    flux[40] = -vn[0] * x186 - vn[1] * x189 + x141 * x81 -
               0.16984155512168939 * x177 + 0.16984155512168939 * x179 +
               x181 * x192 + x187 * x188 + x190 * x191 -
               x6 * (-wL[40] + wR[40]) + 0.072420682437790138 * x70 -
               0.072420682437790138 * x74;
    flux[41] = vn[1] * x194 + x144 * x90 - x146 * x96 -
               0.15191090506254998 * x182 + 0.15191090506254998 * x184 +
               x187 * x195 - x6 * (-wL[41] + wR[41]) +
               0.093494699000845727 * x82 - 0.093494699000845727 * x85;
    flux[42] = 0.16193756890782393 * vn[0] * x93 +
               0.16193756890782393 * vn[1] * x90 + x147 * x96 - x187 * x197 -
               x190 * x196 + x193 * x198 - x6 * (-wL[42] + wR[42]);
    flux[43] = vn[0] * x194 + 0.093494699000845727 * x102 +
               0.093494699000845727 * x103 + x144 * x93 - x145 * x96 +
               x190 * x195 - 0.15191090506254998 * x199 -
               0.15191090506254998 * x200 - x6 * (-wL[43] + wR[43]);
    flux[44] = -vn[0] * x189 + vn[1] * x186 + 0.072420682437790138 * x105 +
               0.072420682437790138 * x106 + x141 * x84 + x183 * x192 -
               x187 * x191 + x188 * x190 - 0.16984155512168939 * x201 -
               0.16984155512168939 * x202 - x6 * (-wL[44] + wR[44]);
    flux[45] = -0.1773937187967248 * x102 + 0.1773937187967248 * x103 +
               x134 * x73 + x178 * x185 + 0.080064076902543566 * x199 -
               0.080064076902543566 * x200 + 0.051209155649918917 * x203 -
               0.1877669040497027 * x204 + 0.051209155649918917 * x205 -
               0.1877669040497027 * x206 - x6 * (-wL[45] + wR[45]);
    flux[46] = -0.19833220700547941 * x105 + 0.19833220700547941 * x106 +
               x129 * x86 + x172 * x180 + 0.062017367294604227 * x201 -
               0.062017367294604227 * x202 + 0.029565619799454133 * x207 -
               0.2056883378018606 * x208 + 0.029565619799454133 * x209 -
               0.2056883378018606 * x210 - x6 * (-wL[46] + wR[46]);
    flux[47] = x119 * x75 - x13 * x166 + x163 * x175 - x174 * x8 -
               0.2192645048267573 * x203 + 0.043852900965351459 * x204 +
               0.2192645048267573 * x205 - 0.043852900965351459 * x206 -
               x6 * (-wL[47] + wR[47]);
    flux[48] = -vn[0] * x165 - vn[1] * x159 + x167 * x174 -
               0.24019223070763071 * x207 + 0.025318484177091663 * x208 +
               0.24019223070763071 * x209 - 0.025318484177091663 * x210 -
               x6 * (-wL[48] + wR[48]);
    flux[49] = -0.24152294576982397 * x211 - 0.24152294576982397 * x212 -
               x6 * (-wL[49] + wR[49]);
    flux[50] = x109 * x167 - x118 * x8 - x127 * x13 - x6 * (-wL[50] + wR[50]);
    flux[51] = -0.2056883378018606 * x112 - 0.2056883378018606 * x115 +
               x118 * x175 + 0.025318484177091663 * x211 -
               0.025318484177091663 * x212 - x6 * (-wL[51] + wR[51]);
    flux[52] = x111 * x180 + x118 * x213 - 0.1877669040497027 * x123 -
               0.1877669040497027 * x126 - x127 * x214 -
               x6 * (-wL[52] + wR[52]);
    flux[53] = 0.062017367294604227 * x112 - 0.062017367294604227 * x115 +
               x122 * x185 - 0.16984155512168939 * x131 -
               0.16984155512168939 * x133 - x6 * (-wL[53] + wR[53]);
    flux[54] = -vn[0] * x215 - vn[1] * x216 + 0.080064076902543566 * x123 -
               0.080064076902543566 * x126 + x130 * x192 -
               x6 * (-wL[54] + wR[54]);
    flux[55] = 0.098058067569092008 * x131 - 0.098058067569092008 * x133 +
               x136 * x195 - x142 * x197 - x6 * (-wL[55] + wR[55]);
    flux[56] = 0.16408253082847341 * vn[0] * x139 +
               0.16408253082847341 * vn[1] * x136 + x142 * x198 -
               x6 * (-wL[56] + wR[56]);
    flux[57] = x139 * x195 - x142 * x196 + 0.098058067569092008 * x148 +
               0.098058067569092008 * x149 - x6 * (-wL[57] + wR[57]);
    flux[58] = -vn[0] * x216 + vn[1] * x215 + x132 * x192 +
               0.080064076902543566 * x151 + 0.080064076902543566 * x153 -
               x6 * (-wL[58] + wR[58]);
    flux[59] = x125 * x185 - 0.16984155512168939 * x148 +
               0.16984155512168939 * x149 + 0.062017367294604227 * x155 +
               0.062017367294604227 * x157 - x6 * (-wL[59] + wR[59]);
    flux[60] = x114 * x180 + x118 * x214 + x127 * x213 -
               0.1877669040497027 * x151 + 0.1877669040497027 * x153 -
               x6 * (-wL[60] + wR[60]);
    flux[61] = x127 * x175 - 0.2056883378018606 * x155 +
               0.2056883378018606 * x157 + 0.025318484177091663 * x217 +
               0.025318484177091663 * x218 - x6 * (-wL[61] + wR[61]);
    flux[62] = x116 * x167 + x118 * x13 - x127 * x8 - x6 * (-wL[62] + wR[62]);
    flux[63] = -0.24152294576982397 * x217 + 0.24152294576982397 * x218 -
               x6 * (-wL[63] + wR[63]);
}

#endif

#else

#ifdef IS_2D

void num_flux_rus(const float wL[36], const float wR[36], const float vn[2],
                  float flux[36])
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
    const float x38 = wL[15] + wR[15];
    const float x39 = 0.238365647F * x38;
    const float x40 = wL[16] + wR[16];
    const float x41 = vn[0] * x40;
    const float x42 = vn[0] * x13;
    const float x43 = wL[19] + wR[19];
    const float x44 = vn[1] * x43;
    const float x45 = wL[20] + wR[20];
    const float x46 = 0.238365647F * x45;
    const float x47 = vn[1] * x20;
    const float x48 = wL[17] + wR[17];
    const float x49 = 0.087038828F * vn[0];
    const float x50 = 0.17251639F * x15;
    const float x51 = wL[18] + wR[18];
    const float x52 = 0.087038828F * vn[1];
    const float x53 = 0.17251639F * x18;
    const float x54 = 0.194624736F * vn[0];
    const float x55 = 0.194624736F * vn[1];
    const float x56 = vn[0] * x43;
    const float x57 = vn[0] * x20;
    const float x58 = vn[1] * x40;
    const float x59 = vn[1] * x13;
    const float x60 = vn[0] * x24;
    const float x61 = wL[21] + wR[21];
    const float x62 = 0.240192231F * x61;
    const float x63 = wL[22] + wR[22];
    const float x64 = vn[0] * x63;
    const float x65 = vn[1] * x31;
    const float x66 = wL[26] + wR[26];
    const float x67 = vn[1] * x66;
    const float x68 = wL[27] + wR[27];
    const float x69 = 0.240192231F * x68;
    const float x70 = wL[23] + wR[23];
    const float x71 = vn[0] * x70;
    const float x72 = wL[25] + wR[25];
    const float x73 = vn[1] * x72;
    const float x74 = wL[24] + wR[24];
    const float x75 = 0.161937569F * x74;
    const float x76 = vn[0] * x72;
    const float x77 = vn[1] * x70;
    const float x78 = vn[0] * x31;
    const float x79 = vn[0] * x66;
    const float x80 = vn[1] * x24;
    const float x81 = vn[1] * x63;
    const float x82 = vn[0] * x38;
    const float x83 = 0.241522946F * wL[28] + 0.241522946F * wR[28];
    const float x84 = wL[29] + wR[29];
    const float x85 = vn[0] * x84;
    const float x86 = vn[1] * x45;
    const float x87 = wL[34] + wR[34];
    const float x88 = vn[1] * x87;
    const float x89 = 0.241522946F * wL[35] + 0.241522946F * wR[35];
    const float x90 = wL[30] + wR[30];
    const float x91 = vn[0] * x90;
    const float x92 = wL[33] + wR[33];
    const float x93 = vn[1] * x92;
    const float x94 = 0.156446555F * x48;
    const float x95 = wL[31] + wR[31];
    const float x96 = 0.0980580676F * vn[0];
    const float x97 = 0.156446555F * x51;
    const float x98 = wL[32] + wR[32];
    const float x99 = 0.0980580676F * vn[1];
    const float x100 = 0.189466187F * vn[0];
    const float x101 = 0.189466187F * vn[1];
    const float x102 = vn[0] * x92;
    const float x103 = vn[1] * x90;
    const float x104 = vn[0] * x45;
    const float x105 = vn[0] * x87;
    const float x106 = vn[1] * x38;
    const float x107 = vn[1] * x84;
    const float x108 = vn[0] * x61;
    const float x109 = vn[1] * x68;
    const float x110 = vn[0] * x68;
    const float x111 = vn[1] * x61;
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
    flux[10] = -vn[0] * x39 + vn[1] * x46 - x4 * (-wL[10] + wR[10]) +
               0.0355334527F * x41 - 0.23570226F * x42 + 0.0355334527F * x44 -
               0.23570226F * x47;
    flux[11] = -vn[0] * x50 - vn[1] * x53 - x4 * (-wL[11] + wR[11]) -
               0.188025358F * x41 + 0.0445435403F * x42 + 0.188025358F * x44 -
               0.0445435403F * x47 + x48 * x49 + x51 * x52;
    flux[12] = 0.15430335F * vn[0] * x18 + 0.15430335F * vn[1] * x15 -
               x4 * (-wL[12] + wR[12]) - x48 * x55 - x51 * x54;
    flux[13] = -vn[0] * x53 + vn[1] * x50 - x4 * (-wL[13] + wR[13]) -
               x48 * x52 + x49 * x51 - 0.188025358F * x56 +
               0.0445435403F * x57 - 0.188025358F * x58 + 0.0445435403F * x59;
    flux[14] = -vn[0] * x46 - vn[1] * x39 - x4 * (-wL[14] + wR[14]) +
               0.0355334527F * x56 - 0.23570226F * x57 - 0.0355334527F * x58 +
               0.23570226F * x59;
    flux[15] = -vn[0] * x62 + vn[1] * x69 - x4 * (-wL[15] + wR[15]) -
               0.238365647F * x60 + 0.0295656198F * x64 - 0.238365647F * x65 +
               0.0295656198F * x67;
    flux[16] = -0.188025358F * x27 - 0.188025358F * x30 -
               x4 * (-wL[16] + wR[16]) + 0.0355334527F * x60 -
               0.198332207F * x64 - 0.0355334527F * x65 + 0.198332207F * x67 +
               0.0724206824F * x71 + 0.0724206824F * x73;
    flux[17] = vn[1] * x75 + 0.087038828F * x27 - 0.087038828F * x30 -
               x34 * x55 - x4 * (-wL[17] + wR[17]) - 0.156446555F * x71 +
               0.156446555F * x73;
    flux[18] = vn[0] * x75 - x34 * x54 + 0.087038828F * x36 +
               0.087038828F * x37 - x4 * (-wL[18] + wR[18]) -
               0.156446555F * x76 - 0.156446555F * x77;
    flux[19] = -0.188025358F * x36 + 0.188025358F * x37 -
               x4 * (-wL[19] + wR[19]) + 0.0724206824F * x76 -
               0.0724206824F * x77 + 0.0355334527F * x78 - 0.198332207F * x79 +
               0.0355334527F * x80 - 0.198332207F * x81;
    flux[20] = -vn[0] * x69 - vn[1] * x62 - x4 * (-wL[20] + wR[20]) -
               0.238365647F * x78 + 0.0295656198F * x79 + 0.238365647F * x80 -
               0.0295656198F * x81;
    flux[21] = -vn[0] * x83 + vn[1] * x89 - x4 * (-wL[21] + wR[21]) -
               0.240192231F * x82 + 0.0253184842F * x85 - 0.240192231F * x86 +
               0.0253184842F * x88;
    flux[22] = -x4 * (-wL[22] + wR[22]) - 0.198332207F * x41 -
               0.198332207F * x44 + 0.0295656198F * x82 - 0.205688338F * x85 -
               0.0295656198F * x86 + 0.205688338F * x88 + 0.0620173673F * x91 +
               0.0620173673F * x93;
    flux[23] = -vn[0] * x94 - vn[1] * x97 - x4 * (-wL[23] + wR[23]) +
               0.0724206824F * x41 - 0.0724206824F * x44 - 0.169841555F * x91 +
               0.169841555F * x93 + x95 * x96 + x98 * x99;
    flux[24] = 0.161937569F * vn[0] * x51 + 0.161937569F * vn[1] * x48 -
               x100 * x98 - x101 * x95 - x4 * (-wL[24] + wR[24]);
    flux[25] = -vn[0] * x97 + vn[1] * x94 - 0.169841555F * x102 -
               0.169841555F * x103 - x4 * (-wL[25] + wR[25]) +
               0.0724206824F * x56 + 0.0724206824F * x58 - x95 * x99 +
               x96 * x98;
    flux[26] =
        0.0620173673F * x102 - 0.0620173673F * x103 + 0.0295656198F * x104 -
        0.205688338F * x105 + 0.0295656198F * x106 - 0.205688338F * x107 -
        x4 * (-wL[26] + wR[26]) - 0.198332207F * x56 + 0.198332207F * x58;
    flux[27] = -vn[0] * x89 - vn[1] * x83 - 0.240192231F * x104 +
               0.0253184842F * x105 + 0.240192231F * x106 -
               0.0253184842F * x107 - x4 * (-wL[27] + wR[27]);
    flux[28] =
        -0.241522946F * x108 - 0.241522946F * x109 - x4 * (-wL[28] + wR[28]);
    flux[29] = 0.0253184842F * x108 - 0.0253184842F * x109 -
               x4 * (-wL[29] + wR[29]) - 0.205688338F * x64 -
               0.205688338F * x67;
    flux[30] = -x4 * (-wL[30] + wR[30]) + 0.0620173673F * x64 -
               0.0620173673F * x67 - 0.169841555F * x71 - 0.169841555F * x73;
    flux[31] = -x101 * x74 - x4 * (-wL[31] + wR[31]) + 0.0980580676F * x71 -
               0.0980580676F * x73;
    flux[32] = -x100 * x74 - x4 * (-wL[32] + wR[32]) + 0.0980580676F * x76 +
               0.0980580676F * x77;
    flux[33] = -x4 * (-wL[33] + wR[33]) - 0.169841555F * x76 +
               0.169841555F * x77 + 0.0620173673F * x79 + 0.0620173673F * x81;
    flux[34] = 0.0253184842F * x110 + 0.0253184842F * x111 -
               x4 * (-wL[34] + wR[34]) - 0.205688338F * x79 +
               0.205688338F * x81;
    flux[35] =
        -0.241522946F * x110 + 0.241522946F * x111 - x4 * (-wL[35] + wR[35]);
}

#else

void num_flux_rus(const float wL[64], const float wR[64], const float vn[3],
                  float flux[64])
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
    const float x67 = wL[25] + wR[25];
    const float x68 = 0.238365647F * x67;
    const float x69 = wL[27] + wR[27];
    const float x70 = vn[0] * x69;
    const float x71 = vn[0] * x20;
    const float x72 = vn[1] * x24;
    const float x73 = wL[33] + wR[33];
    const float x74 = vn[1] * x73;
    const float x75 = wL[35] + wR[35];
    const float x76 = 0.238365647F * x75;
    const float x77 = wL[26] + wR[26];
    const float x78 = 0.150755672F * vn[2];
    const float x79 = 0.204124145F * x26;
    const float x80 = 0.213200716F * x77;
    const float x81 = wL[28] + wR[28];
    const float x82 = vn[0] * x81;
    const float x83 = 0.204124145F * x30;
    const float x84 = wL[32] + wR[32];
    const float x85 = vn[1] * x84;
    const float x86 = wL[34] + wR[34];
    const float x87 = 0.213200716F * x86;
    const float x88 = 0.201007563F * vn[2];
    const float x89 = 0.17251639F * x18;
    const float x90 = wL[29] + wR[29];
    const float x91 = 0.087038828F * vn[0];
    const float x92 = 0.17251639F * x22;
    const float x93 = wL[31] + wR[31];
    const float x94 = 0.087038828F * vn[1];
    const float x95 = 0.230283093F * vn[2];
    const float x96 = wL[30] + wR[30];
    const float x97 = 0.158910432F * x96;
    const float x98 = 0.246182982F * vn[2];
    const float x99 = 0.194624736F * vn[0];
    const float x100 = 0.194624736F * vn[1];
    const float x101 = 0.251259454F * vn[2];
    const float x102 = vn[0] * x84;
    const float x103 = vn[1] * x81;
    const float x104 = vn[0] * x24;
    const float x105 = vn[0] * x73;
    const float x106 = vn[1] * x69;
    const float x107 = vn[1] * x20;
    const float x108 = vn[0] * x36;
    const float x109 = wL[36] + wR[36];
    const float x110 = 0.240192231F * x109;
    const float x111 = wL[38] + wR[38];
    const float x112 = vn[0] * x111;
    const float x113 = vn[1] * x43;
    const float x114 = wL[46] + wR[46];
    const float x115 = vn[1] * x114;
    const float x116 = wL[48] + wR[48];
    const float x117 = 0.240192231F * x116;
    const float x118 = wL[37] + wR[37];
    const float x119 = 0.138675049F * vn[2];
    const float x120 = vn[0] * x46;
    const float x121 = 0.219264505F * x118;
    const float x122 = wL[39] + wR[39];
    const float x123 = vn[0] * x122;
    const float x124 = vn[1] * x54;
    const float x125 = wL[45] + wR[45];
    const float x126 = vn[1] * x125;
    const float x127 = wL[47] + wR[47];
    const float x128 = 0.219264505F * x127;
    const float x129 = 0.186989398F * vn[2];
    const float x130 = wL[40] + wR[40];
    const float x131 = vn[0] * x130;
    const float x132 = wL[44] + wR[44];
    const float x133 = vn[1] * x132;
    const float x134 = 0.217262047F * vn[2];
    const float x135 = 0.162834737F * x49;
    const float x136 = wL[41] + wR[41];
    const float x137 = 0.093494699F * vn[0];
    const float x138 = 0.162834737F * x52;
    const float x139 = wL[43] + wR[43];
    const float x140 = 0.093494699F * vn[1];
    const float x141 = 0.236524958F * vn[2];
    const float x142 = wL[42] + wR[42];
    const float x143 = 0.161937569F * x142;
    const float x144 = 0.247363722F * vn[2];
    const float x145 = 0.191607115F * vn[0];
    const float x146 = 0.191607115F * vn[1];
    const float x147 = 0.250872603F * vn[2];
    const float x148 = vn[0] * x132;
    const float x149 = vn[1] * x130;
    const float x150 = vn[0] * x54;
    const float x151 = vn[0] * x125;
    const float x152 = vn[1] * x46;
    const float x153 = vn[1] * x122;
    const float x154 = vn[0] * x43;
    const float x155 = vn[0] * x114;
    const float x156 = vn[1] * x36;
    const float x157 = vn[1] * x111;
    const float x158 = vn[0] * x67;
    const float x159 = 0.241522946F * wL[49] + 0.241522946F * wR[49];
    const float x160 = wL[51] + wR[51];
    const float x161 = vn[0] * x160;
    const float x162 = vn[1] * x75;
    const float x163 = wL[61] + wR[61];
    const float x164 = vn[1] * x163;
    const float x165 = 0.241522946F * wL[63] + 0.241522946F * wR[63];
    const float x166 = wL[50] + wR[50];
    const float x167 = 0.129099445F * vn[2];
    const float x168 = vn[0] * x77;
    const float x169 = wL[52] + wR[52];
    const float x170 = vn[0] * x169;
    const float x171 = vn[1] * x86;
    const float x172 = wL[60] + wR[60];
    const float x173 = vn[1] * x172;
    const float x174 = wL[62] + wR[62];
    const float x175 = 0.175411604F * vn[2];
    const float x176 = wL[53] + wR[53];
    const float x177 = vn[0] * x176;
    const float x178 = wL[59] + wR[59];
    const float x179 = vn[1] * x178;
    const float x180 = 0.205688338F * vn[2];
    const float x181 = wL[54] + wR[54];
    const float x182 = vn[0] * x181;
    const float x183 = wL[58] + wR[58];
    const float x184 = vn[1] * x183;
    const float x185 = 0.226455407F * vn[2];
    const float x186 = 0.156446555F * x90;
    const float x187 = wL[55] + wR[55];
    const float x188 = 0.0980580676F * vn[0];
    const float x189 = 0.156446555F * x93;
    const float x190 = wL[57] + wR[57];
    const float x191 = 0.0980580676F * vn[1];
    const float x192 = 0.240192231F * vn[2];
    const float x193 = wL[56] + wR[56];
    const float x194 = 0.164082531F * x193;
    const float x195 = 0.248069469F * vn[2];
    const float x196 = 0.189466187F * vn[0];
    const float x197 = 0.189466187F * vn[1];
    const float x198 = 0.250640206F * vn[2];
    const float x199 = vn[0] * x183;
    const float x200 = vn[1] * x181;
    const float x201 = vn[0] * x178;
    const float x202 = vn[1] * x176;
    const float x203 = vn[0] * x86;
    const float x204 = vn[0] * x172;
    const float x205 = vn[1] * x77;
    const float x206 = vn[1] * x169;
    const float x207 = vn[0] * x75;
    const float x208 = vn[0] * x163;
    const float x209 = vn[1] * x67;
    const float x210 = vn[1] * x160;
    const float x211 = vn[0] * x109;
    const float x212 = vn[1] * x116;
    const float x213 = 0.043852901F * vn[0];
    const float x214 = 0.043852901F * vn[1];
    const float x215 = 0.151910905F * x136;
    const float x216 = 0.151910905F * x139;
    const float x217 = vn[0] * x116;
    const float x218 = vn[1] * x109;
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
    flux[16] = -vn[0] * x68 + vn[1] * x76 - x6 * (-wL[16] + wR[16]) +
               0.0355334527F * x70 - 0.23570226F * x71 - 0.23570226F * x72 +
               0.0355334527F * x74 + x77 * x78;
    flux[17] = -vn[0] * x79 - vn[0] * x80 - vn[1] * x83 + vn[1] * x87 +
               x20 * x47 - x6 * (-wL[17] + wR[17]) + x69 * x88 +
               0.0615457455F * x82 + 0.0615457455F * x85;
    flux[18] = -vn[0] * x89 - vn[1] * x92 + x26 * x57 -
               x6 * (-wL[18] + wR[18]) - 0.188025358F * x70 +
               0.0445435403F * x71 - 0.0445435403F * x72 + 0.188025358F * x74 +
               x81 * x95 + x90 * x91 + x93 * x94;
    flux[19] = vn[1] * x97 + x18 * x61 + x26 * x50 - x28 * x63 - x30 * x53 -
               x6 * (-wL[19] + wR[19]) - 0.162834737F * x82 +
               0.162834737F * x85 + x90 * x98;
    flux[20] = 0.15430335F * vn[0] * x22 + 0.15430335F * vn[1] * x18 -
               x100 * x90 + x101 * x96 + x28 * x64 - x6 * (-wL[20] + wR[20]) -
               x93 * x99;
    flux[21] = vn[0] * x97 - 0.162834737F * x102 - 0.162834737F * x103 +
               x22 * x61 + x26 * x53 - x28 * x62 + x30 * x50 -
               x6 * (-wL[21] + wR[21]) + x93 * x98;
    flux[22] = -vn[0] * x92 + vn[1] * x89 + 0.0445435403F * x104 -
               0.188025358F * x105 - 0.188025358F * x106 +
               0.0445435403F * x107 + x30 * x57 - x6 * (-wL[22] + wR[22]) +
               x84 * x95 - x90 * x94 + x91 * x93;
    flux[23] = -vn[0] * x83 - vn[0] * x87 + vn[1] * x79 - vn[1] * x80 +
               0.0615457455F * x102 - 0.0615457455F * x103 + x24 * x47 -
               x6 * (-wL[23] + wR[23]) + x73 * x88;
    flux[24] = -vn[0] * x76 - vn[1] * x68 - 0.23570226F * x104 +
               0.0355334527F * x105 - 0.0355334527F * x106 +
               0.23570226F * x107 - x6 * (-wL[24] + wR[24]) + x78 * x86;
    flux[25] = -vn[0] * x110 + vn[1] * x117 - 0.238365647F * x108 +
               0.0295656198F * x112 - 0.238365647F * x113 +
               0.0295656198F * x115 + x118 * x119 - x6 * (-wL[25] + wR[25]);
    flux[26] = -vn[0] * x121 + vn[1] * x128 + x111 * x129 -
               0.213200716F * x120 + 0.0512091557F * x123 -
               0.213200716F * x124 + 0.0512091557F * x126 + x36 * x78 -
               x6 * (-wL[26] + wR[26]);
    flux[27] = 0.0355334527F * x108 - 0.198332207F * x112 -
               0.0355334527F * x113 + 0.198332207F * x115 + x122 * x134 +
               0.0724206824F * x131 + 0.0724206824F * x133 -
               0.188025358F * x39 - 0.188025358F * x42 + x46 * x88 -
               x6 * (-wL[27] + wR[27]);
    flux[28] = -vn[0] * x135 - vn[1] * x138 + 0.0615457455F * x120 -
               0.177393719F * x123 - 0.0615457455F * x124 +
               0.177393719F * x126 + x130 * x141 + x136 * x137 + x139 * x140 +
               x38 * x95 - x6 * (-wL[28] + wR[28]);
    flux[29] = vn[1] * x143 - x100 * x59 - 0.156446555F * x131 +
               0.156446555F * x133 + x136 * x144 + 0.087038828F * x39 -
               0.087038828F * x42 + x49 * x98 - x6 * (-wL[29] + wR[29]);
    flux[30] = 0.158910432F * vn[0] * x52 + 0.158910432F * vn[1] * x49 +
               x101 * x59 - x136 * x146 - x139 * x145 + x142 * x147 -
               x6 * (-wL[30] + wR[30]);
    flux[31] = vn[0] * x143 + x139 * x144 - 0.156446555F * x148 -
               0.156446555F * x149 + x52 * x98 - x59 * x99 -
               x6 * (-wL[31] + wR[31]) + 0.087038828F * x65 +
               0.087038828F * x66;
    flux[32] = -vn[0] * x138 + vn[1] * x135 + x132 * x141 - x136 * x140 +
               x137 * x139 + 0.0615457455F * x150 - 0.177393719F * x151 +
               0.0615457455F * x152 - 0.177393719F * x153 + x41 * x95 -
               x6 * (-wL[32] + wR[32]);
    flux[33] = x125 * x134 + 0.0724206824F * x148 - 0.0724206824F * x149 +
               0.0355334527F * x154 - 0.198332207F * x155 +
               0.0355334527F * x156 - 0.198332207F * x157 + x54 * x88 -
               x6 * (-wL[33] + wR[33]) - 0.188025358F * x65 +
               0.188025358F * x66;
    flux[34] = -vn[0] * x128 - vn[1] * x121 + x114 * x129 -
               0.213200716F * x150 + 0.0512091557F * x151 +
               0.213200716F * x152 - 0.0512091557F * x153 + x43 * x78 -
               x6 * (-wL[34] + wR[34]);
    flux[35] = -vn[0] * x117 - vn[1] * x110 + x119 * x127 -
               0.238365647F * x154 + 0.0295656198F * x155 +
               0.238365647F * x156 - 0.0295656198F * x157 -
               x6 * (-wL[35] + wR[35]);
    flux[36] = -vn[0] * x159 + vn[1] * x165 - 0.240192231F * x158 +
               0.0253184842F * x161 - 0.240192231F * x162 +
               0.0253184842F * x164 + x166 * x167 - x6 * (-wL[36] + wR[36]);
    flux[37] = x119 * x67 + x13 * x174 + x160 * x175 - x166 * x8 -
               0.219264505F * x168 + 0.043852901F * x170 - 0.219264505F * x171 +
               0.043852901F * x173 - x6 * (-wL[37] + wR[37]);
    flux[38] = x129 * x77 + 0.0295656198F * x158 - 0.205688338F * x161 -
               0.0295656198F * x162 + 0.205688338F * x164 + x169 * x180 +
               0.0620173673F * x177 + 0.0620173673F * x179 -
               x6 * (-wL[38] + wR[38]) - 0.198332207F * x70 -
               0.198332207F * x74;
    flux[39] = x134 * x69 + 0.0512091557F * x168 - 0.187766904F * x170 -
               0.0512091557F * x171 + 0.187766904F * x173 + x176 * x185 +
               0.0800640769F * x182 + 0.0800640769F * x184 -
               x6 * (-wL[39] + wR[39]) - 0.177393719F * x82 -
               0.177393719F * x85;
    flux[40] = -vn[0] * x186 - vn[1] * x189 + x141 * x81 - 0.169841555F * x177 +
               0.169841555F * x179 + x181 * x192 + x187 * x188 + x190 * x191 -
               x6 * (-wL[40] + wR[40]) + 0.0724206824F * x70 -
               0.0724206824F * x74;
    flux[41] = vn[1] * x194 + x144 * x90 - x146 * x96 - 0.151910905F * x182 +
               0.151910905F * x184 + x187 * x195 - x6 * (-wL[41] + wR[41]) +
               0.093494699F * x82 - 0.093494699F * x85;
    flux[42] = 0.161937569F * vn[0] * x93 + 0.161937569F * vn[1] * x90 +
               x147 * x96 - x187 * x197 - x190 * x196 + x193 * x198 -
               x6 * (-wL[42] + wR[42]);
    flux[43] = vn[0] * x194 + 0.093494699F * x102 + 0.093494699F * x103 +
               x144 * x93 - x145 * x96 + x190 * x195 - 0.151910905F * x199 -
               0.151910905F * x200 - x6 * (-wL[43] + wR[43]);
    flux[44] = -vn[0] * x189 + vn[1] * x186 + 0.0724206824F * x105 +
               0.0724206824F * x106 + x141 * x84 + x183 * x192 - x187 * x191 +
               x188 * x190 - 0.169841555F * x201 - 0.169841555F * x202 -
               x6 * (-wL[44] + wR[44]);
    flux[45] = -0.177393719F * x102 + 0.177393719F * x103 + x134 * x73 +
               x178 * x185 + 0.0800640769F * x199 - 0.0800640769F * x200 +
               0.0512091557F * x203 - 0.187766904F * x204 +
               0.0512091557F * x205 - 0.187766904F * x206 -
               x6 * (-wL[45] + wR[45]);
    flux[46] = -0.198332207F * x105 + 0.198332207F * x106 + x129 * x86 +
               x172 * x180 + 0.0620173673F * x201 - 0.0620173673F * x202 +
               0.0295656198F * x207 - 0.205688338F * x208 +
               0.0295656198F * x209 - 0.205688338F * x210 -
               x6 * (-wL[46] + wR[46]);
    flux[47] = x119 * x75 - x13 * x166 + x163 * x175 - x174 * x8 -
               0.219264505F * x203 + 0.043852901F * x204 + 0.219264505F * x205 -
               0.043852901F * x206 - x6 * (-wL[47] + wR[47]);
    flux[48] = -vn[0] * x165 - vn[1] * x159 + x167 * x174 -
               0.240192231F * x207 + 0.0253184842F * x208 +
               0.240192231F * x209 - 0.0253184842F * x210 -
               x6 * (-wL[48] + wR[48]);
    flux[49] =
        -0.241522946F * x211 - 0.241522946F * x212 - x6 * (-wL[49] + wR[49]);
    flux[50] = x109 * x167 - x118 * x8 - x127 * x13 - x6 * (-wL[50] + wR[50]);
    flux[51] = -0.205688338F * x112 - 0.205688338F * x115 + x118 * x175 +
               0.0253184842F * x211 - 0.0253184842F * x212 -
               x6 * (-wL[51] + wR[51]);
    flux[52] = x111 * x180 + x118 * x213 - 0.187766904F * x123 -
               0.187766904F * x126 - x127 * x214 - x6 * (-wL[52] + wR[52]);
    flux[53] = 0.0620173673F * x112 - 0.0620173673F * x115 + x122 * x185 -
               0.169841555F * x131 - 0.169841555F * x133 -
               x6 * (-wL[53] + wR[53]);
    flux[54] = -vn[0] * x215 - vn[1] * x216 + 0.0800640769F * x123 -
               0.0800640769F * x126 + x130 * x192 - x6 * (-wL[54] + wR[54]);
    flux[55] = 0.0980580676F * x131 - 0.0980580676F * x133 + x136 * x195 -
               x142 * x197 - x6 * (-wL[55] + wR[55]);
    flux[56] = 0.164082531F * vn[0] * x139 + 0.164082531F * vn[1] * x136 +
               x142 * x198 - x6 * (-wL[56] + wR[56]);
    flux[57] = x139 * x195 - x142 * x196 + 0.0980580676F * x148 +
               0.0980580676F * x149 - x6 * (-wL[57] + wR[57]);
    flux[58] = -vn[0] * x216 + vn[1] * x215 + x132 * x192 +
               0.0800640769F * x151 + 0.0800640769F * x153 -
               x6 * (-wL[58] + wR[58]);
    flux[59] = x125 * x185 - 0.169841555F * x148 + 0.169841555F * x149 +
               0.0620173673F * x155 + 0.0620173673F * x157 -
               x6 * (-wL[59] + wR[59]);
    flux[60] = x114 * x180 + x118 * x214 + x127 * x213 - 0.187766904F * x151 +
               0.187766904F * x153 - x6 * (-wL[60] + wR[60]);
    flux[61] = x127 * x175 - 0.205688338F * x155 + 0.205688338F * x157 +
               0.0253184842F * x217 + 0.0253184842F * x218 -
               x6 * (-wL[61] + wR[61]);
    flux[62] = x116 * x167 + x118 * x13 - x127 * x8 - x6 * (-wL[62] + wR[62]);
    flux[63] =
        -0.241522946F * x217 + 0.241522946F * x218 - x6 * (-wL[63] + wR[63]);
}

#endif

#endif
#endif
