#ifndef P11_CL
#define P11_CL

#ifdef USE_DOUBLE

#ifdef IS_2D

void num_flux_rus(const double wL[78], const double wR[78], const double vn[2],
                  double flux[78])
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
    const double x83 = wL[28] + wR[28];
    const double x84 = 0.24152294576982397 * x83;
    const double x85 = wL[29] + wR[29];
    const double x86 = vn[0] * x85;
    const double x87 = vn[1] * x45;
    const double x88 = wL[34] + wR[34];
    const double x89 = vn[1] * x88;
    const double x90 = wL[35] + wR[35];
    const double x91 = 0.24152294576982397 * x90;
    const double x92 = wL[30] + wR[30];
    const double x93 = vn[0] * x92;
    const double x94 = wL[33] + wR[33];
    const double x95 = vn[1] * x94;
    const double x96 = 0.15644655469368599 * x48;
    const double x97 = wL[31] + wR[31];
    const double x98 = 0.098058067569092008 * vn[0];
    const double x99 = 0.15644655469368599 * x51;
    const double x100 = wL[32] + wR[32];
    const double x101 = 0.098058067569092008 * vn[1];
    const double x102 = 0.18946618668626838 * vn[0];
    const double x103 = 0.18946618668626838 * vn[1];
    const double x104 = vn[0] * x94;
    const double x105 = vn[1] * x92;
    const double x106 = vn[0] * x45;
    const double x107 = vn[0] * x88;
    const double x108 = vn[1] * x38;
    const double x109 = vn[1] * x85;
    const double x110 = vn[0] * x61;
    const double x111 = wL[36] + wR[36];
    const double x112 = 0.24253562503633297 * x111;
    const double x113 = wL[37] + wR[37];
    const double x114 = vn[0] * x113;
    const double x115 = vn[1] * x68;
    const double x116 = wL[43] + wR[43];
    const double x117 = vn[1] * x116;
    const double x118 = wL[44] + wR[44];
    const double x119 = 0.24253562503633297 * x118;
    const double x120 = wL[38] + wR[38];
    const double x121 = vn[0] * x120;
    const double x122 = wL[42] + wR[42];
    const double x123 = vn[1] * x122;
    const double x124 = wL[39] + wR[39];
    const double x125 = vn[0] * x124;
    const double x126 = wL[41] + wR[41];
    const double x127 = vn[1] * x126;
    const double x128 = wL[40] + wR[40];
    const double x129 = 0.16568337391590282 * x128;
    const double x130 = vn[0] * x126;
    const double x131 = vn[1] * x124;
    const double x132 = vn[0] * x122;
    const double x133 = vn[1] * x120;
    const double x134 = vn[0] * x68;
    const double x135 = vn[0] * x116;
    const double x136 = vn[1] * x61;
    const double x137 = vn[1] * x113;
    const double x138 = vn[0] * x83;
    const double x139 = wL[45] + wR[45];
    const double x140 = 0.24333213169614379 * x139;
    const double x141 = wL[46] + wR[46];
    const double x142 = vn[0] * x141;
    const double x143 = vn[1] * x90;
    const double x144 = wL[53] + wR[53];
    const double x145 = vn[1] * x144;
    const double x146 = wL[54] + wR[54];
    const double x147 = 0.24333213169614379 * x146;
    const double x148 = wL[47] + wR[47];
    const double x149 = vn[0] * x148;
    const double x150 = wL[52] + wR[52];
    const double x151 = vn[1] * x150;
    const double x152 = wL[48] + wR[48];
    const double x153 = vn[0] * x152;
    const double x154 = wL[51] + wR[51];
    const double x155 = vn[1] * x154;
    const double x156 = 0.14852213144650114 * x97;
    const double x157 = wL[49] + wR[49];
    const double x158 = 0.10409569305544539 * vn[0];
    const double x159 = 0.14852213144650114 * x100;
    const double x160 = wL[50] + wR[50];
    const double x161 = 0.10409569305544539 * vn[1];
    const double x162 = 0.18662722567253981 * vn[0];
    const double x163 = 0.18662722567253981 * vn[1];
    const double x164 = vn[0] * x154;
    const double x165 = vn[1] * x152;
    const double x166 = vn[0] * x150;
    const double x167 = vn[1] * x148;
    const double x168 = vn[0] * x90;
    const double x169 = vn[0] * x144;
    const double x170 = vn[1] * x83;
    const double x171 = vn[1] * x141;
    const double x172 = vn[0] * x111;
    const double x173 = wL[55] + wR[55];
    const double x174 = 0.24397501823713327 * x173;
    const double x175 = wL[56] + wR[56];
    const double x176 = vn[0] * x175;
    const double x177 = vn[1] * x118;
    const double x178 = wL[64] + wR[64];
    const double x179 = vn[1] * x178;
    const double x180 = wL[65] + wR[65];
    const double x181 = 0.24397501823713327 * x180;
    const double x182 = wL[57] + wR[57];
    const double x183 = vn[0] * x182;
    const double x184 = wL[63] + wR[63];
    const double x185 = vn[1] * x184;
    const double x186 = wL[58] + wR[58];
    const double x187 = vn[0] * x186;
    const double x188 = wL[62] + wR[62];
    const double x189 = vn[1] * x188;
    const double x190 = wL[59] + wR[59];
    const double x191 = vn[0] * x190;
    const double x192 = wL[61] + wR[61];
    const double x193 = vn[1] * x192;
    const double x194 = wL[60] + wR[60];
    const double x195 = 0.16791512356486687 * x194;
    const double x196 = vn[0] * x192;
    const double x197 = vn[1] * x190;
    const double x198 = vn[0] * x188;
    const double x199 = vn[1] * x186;
    const double x200 = vn[0] * x184;
    const double x201 = vn[1] * x182;
    const double x202 = vn[0] * x118;
    const double x203 = vn[0] * x178;
    const double x204 = vn[1] * x111;
    const double x205 = vn[1] * x175;
    const double x206 = vn[0] * x139;
    const double x207 =
        0.24450482346091287 * wL[66] + 0.24450482346091287 * wR[66];
    const double x208 = wL[67] + wR[67];
    const double x209 = vn[0] * x208;
    const double x210 = vn[1] * x146;
    const double x211 = wL[76] + wR[76];
    const double x212 = vn[1] * x211;
    const double x213 =
        0.24450482346091287 * wL[77] + 0.24450482346091287 * wR[77];
    const double x214 = wL[68] + wR[68];
    const double x215 = vn[0] * x214;
    const double x216 = wL[75] + wR[75];
    const double x217 = vn[1] * x216;
    const double x218 = wL[69] + wR[69];
    const double x219 = vn[0] * x218;
    const double x220 = wL[74] + wR[74];
    const double x221 = vn[1] * x220;
    const double x222 = wL[70] + wR[70];
    const double x223 = vn[0] * x222;
    const double x224 = wL[73] + wR[73];
    const double x225 = vn[1] * x224;
    const double x226 = 0.14379392104440059 * x157;
    const double x227 = wL[71] + wR[71];
    const double x228 = 0.1079164618254289 * vn[0];
    const double x229 = 0.14379392104440059 * x160;
    const double x230 = wL[72] + wR[72];
    const double x231 = 0.1079164618254289 * vn[1];
    const double x232 = 0.18482827349523615 * vn[0];
    const double x233 = 0.18482827349523615 * vn[1];
    const double x234 = vn[0] * x224;
    const double x235 = vn[1] * x222;
    const double x236 = vn[0] * x220;
    const double x237 = vn[1] * x218;
    const double x238 = vn[0] * x216;
    const double x239 = vn[1] * x214;
    const double x240 = vn[0] * x146;
    const double x241 = vn[0] * x211;
    const double x242 = vn[1] * x139;
    const double x243 = vn[1] * x208;
    const double x244 = vn[0] * x173;
    const double x245 = vn[1] * x180;
    const double x246 = vn[0] * x180;
    const double x247 = vn[1] * x173;
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
    flux[21] = -vn[0] * x84 + vn[1] * x91 - x4 * (-wL[21] + wR[21]) -
               0.24019223070763071 * x82 + 0.025318484177091663 * x86 -
               0.24019223070763071 * x87 + 0.025318484177091663 * x89;
    flux[22] = -x4 * (-wL[22] + wR[22]) - 0.19833220700547941 * x41 -
               0.19833220700547941 * x44 + 0.029565619799454133 * x82 -
               0.2056883378018606 * x86 - 0.029565619799454133 * x87 +
               0.2056883378018606 * x89 + 0.062017367294604227 * x93 +
               0.062017367294604227 * x95;
    flux[23] = -vn[0] * x96 - vn[1] * x99 + x100 * x101 -
               x4 * (-wL[23] + wR[23]) + 0.072420682437790138 * x41 -
               0.072420682437790138 * x44 - 0.16984155512168939 * x93 +
               0.16984155512168939 * x95 + x97 * x98;
    flux[24] = 0.16193756890782393 * vn[0] * x51 +
               0.16193756890782393 * vn[1] * x48 - x100 * x102 - x103 * x97 -
               x4 * (-wL[24] + wR[24]);
    flux[25] = -vn[0] * x99 + vn[1] * x96 + x100 * x98 - x101 * x97 -
               0.16984155512168939 * x104 - 0.16984155512168939 * x105 -
               x4 * (-wL[25] + wR[25]) + 0.072420682437790138 * x56 +
               0.072420682437790138 * x58;
    flux[26] = 0.062017367294604227 * x104 - 0.062017367294604227 * x105 +
               0.029565619799454133 * x106 - 0.2056883378018606 * x107 +
               0.029565619799454133 * x108 - 0.2056883378018606 * x109 -
               x4 * (-wL[26] + wR[26]) - 0.19833220700547941 * x56 +
               0.19833220700547941 * x58;
    flux[27] = -vn[0] * x91 - vn[1] * x84 - 0.24019223070763071 * x106 +
               0.025318484177091663 * x107 + 0.24019223070763071 * x108 -
               0.025318484177091663 * x109 - x4 * (-wL[27] + wR[27]);
    flux[28] = -vn[0] * x112 + vn[1] * x119 - 0.24152294576982397 * x110 +
               0.022140372138502382 * x114 - 0.24152294576982397 * x115 +
               0.022140372138502382 * x117 - x4 * (-wL[28] + wR[28]);
    flux[29] = 0.025318484177091663 * x110 - 0.21120568916876956 * x114 -
               0.025318484177091663 * x115 + 0.21120568916876956 * x117 +
               0.054232614454664041 * x121 + 0.054232614454664041 * x123 -
               x4 * (-wL[29] + wR[29]) - 0.2056883378018606 * x64 -
               0.2056883378018606 * x67;
    flux[30] = -0.17986923354612536 * x121 + 0.17986923354612536 * x123 +
               0.085749292571254424 * x125 + 0.085749292571254424 * x127 -
               x4 * (-wL[30] + wR[30]) + 0.062017367294604227 * x64 -
               0.062017367294604227 * x67 - 0.16984155512168939 * x71 -
               0.16984155512168939 * x73;
    flux[31] = vn[1] * x129 - x103 * x74 - 0.14852213144650114 * x125 +
               0.14852213144650114 * x127 - x4 * (-wL[31] + wR[31]) +
               0.098058067569092008 * x71 - 0.098058067569092008 * x73;
    flux[32] = vn[0] * x129 - x102 * x74 - 0.14852213144650114 * x130 -
               0.14852213144650114 * x131 - x4 * (-wL[32] + wR[32]) +
               0.098058067569092008 * x76 + 0.098058067569092008 * x77;
    flux[33] = 0.085749292571254424 * x130 - 0.085749292571254424 * x131 -
               0.17986923354612536 * x132 - 0.17986923354612536 * x133 -
               x4 * (-wL[33] + wR[33]) - 0.16984155512168939 * x76 +
               0.16984155512168939 * x77 + 0.062017367294604227 * x79 +
               0.062017367294604227 * x81;
    flux[34] = 0.054232614454664041 * x132 - 0.054232614454664041 * x133 +
               0.025318484177091663 * x134 - 0.21120568916876956 * x135 +
               0.025318484177091663 * x136 - 0.21120568916876956 * x137 -
               x4 * (-wL[34] + wR[34]) - 0.2056883378018606 * x79 +
               0.2056883378018606 * x81;
    flux[35] = -vn[0] * x119 - vn[1] * x112 - 0.24152294576982397 * x134 +
               0.022140372138502382 * x135 + 0.24152294576982397 * x136 -
               0.022140372138502382 * x137 - x4 * (-wL[35] + wR[35]);
    flux[36] = -vn[0] * x140 + vn[1] * x147 - 0.24253562503633297 * x138 +
               0.019672236884115842 * x142 - 0.24253562503633297 * x143 +
               0.019672236884115842 * x145 - x4 * (-wL[36] + wR[36]);
    flux[37] = 0.022140372138502382 * x138 - 0.21549855796030778 * x142 -
               0.022140372138502382 * x143 + 0.21549855796030778 * x145 +
               0.048186942465242667 * x149 + 0.048186942465242667 * x151 -
               x4 * (-wL[37] + wR[37]) - 0.21120568916876956 * x86 -
               0.21120568916876956 * x89;
    flux[38] = -0.18766117943318453 * x149 + 0.18766117943318453 * x151 +
               0.076190245834827947 * x153 + 0.076190245834827947 * x155 -
               x4 * (-wL[38] + wR[38]) + 0.054232614454664041 * x86 -
               0.054232614454664041 * x89 - 0.17986923354612536 * x93 -
               0.17986923354612536 * x95;
    flux[39] = -vn[0] * x156 - vn[1] * x159 - 0.15981800795165318 * x153 +
               0.15981800795165318 * x155 + x157 * x158 + x160 * x161 -
               x4 * (-wL[39] + wR[39]) + 0.085749292571254424 * x93 -
               0.085749292571254424 * x95;
    flux[40] = 0.16568337391590282 * vn[0] * x100 +
               0.16568337391590282 * vn[1] * x97 - x157 * x163 - x160 * x162 -
               x4 * (-wL[40] + wR[40]);
    flux[41] = -vn[0] * x159 + vn[1] * x156 + 0.085749292571254424 * x104 +
               0.085749292571254424 * x105 - x157 * x161 + x158 * x160 -
               0.15981800795165318 * x164 - 0.15981800795165318 * x165 -
               x4 * (-wL[41] + wR[41]);
    flux[42] = -0.17986923354612536 * x104 + 0.17986923354612536 * x105 +
               0.054232614454664041 * x107 + 0.054232614454664041 * x109 +
               0.076190245834827947 * x164 - 0.076190245834827947 * x165 -
               0.18766117943318453 * x166 - 0.18766117943318453 * x167 -
               x4 * (-wL[42] + wR[42]);
    flux[43] = -0.21120568916876956 * x107 + 0.21120568916876956 * x109 +
               0.048186942465242667 * x166 - 0.048186942465242667 * x167 +
               0.022140372138502382 * x168 - 0.21549855796030778 * x169 +
               0.022140372138502382 * x170 - 0.21549855796030778 * x171 -
               x4 * (-wL[43] + wR[43]);
    flux[44] = -vn[0] * x147 - vn[1] * x140 - 0.24253562503633297 * x168 +
               0.019672236884115842 * x169 + 0.24253562503633297 * x170 -
               0.019672236884115842 * x171 - x4 * (-wL[44] + wR[44]);
    flux[45] = -vn[0] * x174 + vn[1] * x181 - 0.24333213169614379 * x172 +
               0.017699808135119718 * x176 - 0.24333213169614379 * x177 +
               0.017699808135119718 * x179 - x4 * (-wL[45] + wR[45]);
    flux[46] = -0.21549855796030778 * x114 - 0.21549855796030778 * x117 +
               0.019672236884115842 * x172 - 0.21893453548279601 * x176 -
               0.019672236884115842 * x177 + 0.21893453548279601 * x179 +
               0.043355498476205998 * x183 + 0.043355498476205998 * x185 -
               x4 * (-wL[46] + wR[46]);
    flux[47] = 0.048186942465242667 * x114 - 0.048186942465242667 * x117 -
               0.18766117943318453 * x121 - 0.18766117943318453 * x123 -
               0.19389168358237033 * x183 + 0.19389168358237033 * x185 +
               0.06855106213838523 * x187 + 0.06855106213838523 * x189 -
               x4 * (-wL[47] + wR[47]);
    flux[48] = 0.076190245834827947 * x121 - 0.076190245834827947 * x123 -
               0.15981800795165318 * x125 - 0.15981800795165318 * x127 -
               0.16884540837649259 * x187 + 0.16884540837649259 * x189 +
               0.093658581158169385 * x191 + 0.093658581158169385 * x193 -
               x4 * (-wL[48] + wR[48]);
    flux[49] = vn[1] * x195 + 0.10409569305544539 * x125 -
               0.10409569305544539 * x127 - x128 * x163 -
               0.14379392104440059 * x191 + 0.14379392104440059 * x193 -
               x4 * (-wL[49] + wR[49]);
    flux[50] = vn[0] * x195 - x128 * x162 + 0.10409569305544539 * x130 +
               0.10409569305544539 * x131 - 0.14379392104440059 * x196 -
               0.14379392104440059 * x197 - x4 * (-wL[50] + wR[50]);
    flux[51] = -0.15981800795165318 * x130 + 0.15981800795165318 * x131 +
               0.076190245834827947 * x132 + 0.076190245834827947 * x133 +
               0.093658581158169385 * x196 - 0.093658581158169385 * x197 -
               0.16884540837649259 * x198 - 0.16884540837649259 * x199 -
               x4 * (-wL[51] + wR[51]);
    flux[52] = -0.18766117943318453 * x132 + 0.18766117943318453 * x133 +
               0.048186942465242667 * x135 + 0.048186942465242667 * x137 +
               0.06855106213838523 * x198 - 0.06855106213838523 * x199 -
               0.19389168358237033 * x200 - 0.19389168358237033 * x201 -
               x4 * (-wL[52] + wR[52]);
    flux[53] = -0.21549855796030778 * x135 + 0.21549855796030778 * x137 +
               0.043355498476205998 * x200 - 0.043355498476205998 * x201 +
               0.019672236884115842 * x202 - 0.21893453548279601 * x203 +
               0.019672236884115842 * x204 - 0.21893453548279601 * x205 -
               x4 * (-wL[53] + wR[53]);
    flux[54] = -vn[0] * x181 - vn[1] * x174 - 0.24333213169614379 * x202 +
               0.017699808135119718 * x203 + 0.24333213169614379 * x204 -
               0.017699808135119718 * x205 - x4 * (-wL[54] + wR[54]);
    flux[55] = -vn[0] * x207 + vn[1] * x213 - 0.24397501823713327 * x206 +
               0.016087236302194673 * x209 - 0.24397501823713327 * x210 +
               0.016087236302194673 * x212 - x4 * (-wL[55] + wR[55]);
    flux[56] = -0.21893453548279601 * x142 - 0.21893453548279601 * x145 +
               0.017699808135119718 * x206 - 0.22174724947584698 * x209 -
               0.017699808135119718 * x210 + 0.22174724947584698 * x212 +
               0.039405520311955031 * x215 + 0.039405520311955031 * x217 -
               x4 * (-wL[56] + wR[56]);
    flux[57] = 0.043355498476205998 * x142 - 0.043355498476205998 * x145 -
               0.19389168358237033 * x149 - 0.19389168358237033 * x151 -
               0.19898812349465853 * x215 + 0.19898812349465853 * x217 +
               0.062305598284903341 * x219 + 0.062305598284903341 * x221 -
               x4 * (-wL[57] + wR[57]);
    flux[58] = 0.06855106213838523 * x149 - 0.06855106213838523 * x151 -
               0.16884540837649259 * x153 - 0.16884540837649259 * x155 -
               0.17622684421256032 * x219 + 0.17622684421256032 * x221 +
               0.085125653075874858 * x223 + 0.085125653075874858 * x225 -
               x4 * (-wL[58] + wR[58]);
    flux[59] = -vn[0] * x226 - vn[1] * x229 + 0.093658581158169385 * x153 -
               0.093658581158169385 * x155 - 0.15346245351121282 * x223 +
               0.15346245351121282 * x225 + x227 * x228 + x230 * x231 -
               x4 * (-wL[59] + wR[59]);
    flux[60] = 0.16791512356486687 * vn[0] * x160 +
               0.16791512356486687 * vn[1] * x157 - x227 * x233 - x230 * x232 -
               x4 * (-wL[60] + wR[60]);
    flux[61] = -vn[0] * x229 + vn[1] * x226 + 0.093658581158169385 * x164 +
               0.093658581158169385 * x165 - x227 * x231 + x228 * x230 -
               0.15346245351121282 * x234 - 0.15346245351121282 * x235 -
               x4 * (-wL[61] + wR[61]);
    flux[62] = -0.16884540837649259 * x164 + 0.16884540837649259 * x165 +
               0.06855106213838523 * x166 + 0.06855106213838523 * x167 +
               0.085125653075874858 * x234 - 0.085125653075874858 * x235 -
               0.17622684421256032 * x236 - 0.17622684421256032 * x237 -
               x4 * (-wL[62] + wR[62]);
    flux[63] = -0.19389168358237033 * x166 + 0.19389168358237033 * x167 +
               0.043355498476205998 * x169 + 0.043355498476205998 * x171 +
               0.062305598284903341 * x236 - 0.062305598284903341 * x237 -
               0.19898812349465853 * x238 - 0.19898812349465853 * x239 -
               x4 * (-wL[63] + wR[63]);
    flux[64] = -0.21893453548279601 * x169 + 0.21893453548279601 * x171 +
               0.039405520311955031 * x238 - 0.039405520311955031 * x239 +
               0.017699808135119718 * x240 - 0.22174724947584698 * x241 +
               0.017699808135119718 * x242 - 0.22174724947584698 * x243 -
               x4 * (-wL[64] + wR[64]);
    flux[65] = -vn[0] * x213 - vn[1] * x207 - 0.24397501823713327 * x240 +
               0.016087236302194673 * x241 + 0.24397501823713327 * x242 -
               0.016087236302194673 * x243 - x4 * (-wL[65] + wR[65]);
    flux[66] = -0.24450482346091287 * x244 - 0.24450482346091287 * x245 -
               x4 * (-wL[66] + wR[66]);
    flux[67] = -0.22174724947584698 * x176 - 0.22174724947584698 * x179 +
               0.016087236302194673 * x244 - 0.016087236302194673 * x245 -
               x4 * (-wL[67] + wR[67]);
    flux[68] = 0.039405520311955031 * x176 - 0.039405520311955031 * x179 -
               0.19898812349465853 * x183 - 0.19898812349465853 * x185 -
               x4 * (-wL[68] + wR[68]);
    flux[69] = 0.062305598284903341 * x183 - 0.062305598284903341 * x185 -
               0.17622684421256032 * x187 - 0.17622684421256032 * x189 -
               x4 * (-wL[69] + wR[69]);
    flux[70] = 0.085125653075874858 * x187 - 0.085125653075874858 * x189 -
               0.15346245351121282 * x191 - 0.15346245351121282 * x193 -
               x4 * (-wL[70] + wR[70]);
    flux[71] = 0.1079164618254289 * x191 - 0.1079164618254289 * x193 -
               x194 * x233 - x4 * (-wL[71] + wR[71]);
    flux[72] = -x194 * x232 + 0.1079164618254289 * x196 +
               0.1079164618254289 * x197 - x4 * (-wL[72] + wR[72]);
    flux[73] = -0.15346245351121282 * x196 + 0.15346245351121282 * x197 +
               0.085125653075874858 * x198 + 0.085125653075874858 * x199 -
               x4 * (-wL[73] + wR[73]);
    flux[74] = -0.17622684421256032 * x198 + 0.17622684421256032 * x199 +
               0.062305598284903341 * x200 + 0.062305598284903341 * x201 -
               x4 * (-wL[74] + wR[74]);
    flux[75] = -0.19898812349465853 * x200 + 0.19898812349465853 * x201 +
               0.039405520311955031 * x203 + 0.039405520311955031 * x205 -
               x4 * (-wL[75] + wR[75]);
    flux[76] = -0.22174724947584698 * x203 + 0.22174724947584698 * x205 +
               0.016087236302194673 * x246 + 0.016087236302194673 * x247 -
               x4 * (-wL[76] + wR[76]);
    flux[77] = -0.24450482346091287 * x246 + 0.24450482346091287 * x247 -
               x4 * (-wL[77] + wR[77]);
}

#else

void num_flux_rus(const double wL[144], const double wR[144],
                  const double vn[3], double flux[144])
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
    const double x159 = wL[49] + wR[49];
    const double x160 = 0.24152294576982397 * x159;
    const double x161 = wL[51] + wR[51];
    const double x162 = vn[0] * x161;
    const double x163 = vn[1] * x75;
    const double x164 = wL[61] + wR[61];
    const double x165 = vn[1] * x164;
    const double x166 = wL[63] + wR[63];
    const double x167 = 0.24152294576982397 * x166;
    const double x168 = wL[50] + wR[50];
    const double x169 = 0.12909944487358058 * vn[2];
    const double x170 = vn[0] * x77;
    const double x171 = wL[52] + wR[52];
    const double x172 = vn[0] * x171;
    const double x173 = vn[1] * x86;
    const double x174 = wL[60] + wR[60];
    const double x175 = vn[1] * x174;
    const double x176 = wL[62] + wR[62];
    const double x177 = 0.17541160386140583 * vn[2];
    const double x178 = wL[53] + wR[53];
    const double x179 = vn[0] * x178;
    const double x180 = wL[59] + wR[59];
    const double x181 = vn[1] * x180;
    const double x182 = 0.2056883378018606 * vn[2];
    const double x183 = wL[54] + wR[54];
    const double x184 = vn[0] * x183;
    const double x185 = wL[58] + wR[58];
    const double x186 = vn[1] * x185;
    const double x187 = 0.22645540682891915 * vn[2];
    const double x188 = 0.15644655469368599 * x90;
    const double x189 = wL[55] + wR[55];
    const double x190 = 0.098058067569092008 * vn[0];
    const double x191 = 0.15644655469368599 * x93;
    const double x192 = wL[57] + wR[57];
    const double x193 = 0.098058067569092008 * vn[1];
    const double x194 = 0.24019223070763071 * vn[2];
    const double x195 = wL[56] + wR[56];
    const double x196 = 0.16408253082847341 * x195;
    const double x197 = 0.24806946917841691 * vn[2];
    const double x198 = 0.18946618668626838 * vn[0];
    const double x199 = 0.18946618668626838 * vn[1];
    const double x200 = 0.25064020591380148 * vn[2];
    const double x201 = vn[0] * x185;
    const double x202 = vn[1] * x183;
    const double x203 = vn[0] * x180;
    const double x204 = vn[1] * x178;
    const double x205 = vn[0] * x86;
    const double x206 = vn[0] * x174;
    const double x207 = vn[1] * x77;
    const double x208 = vn[1] * x171;
    const double x209 = vn[0] * x75;
    const double x210 = vn[0] * x164;
    const double x211 = vn[1] * x67;
    const double x212 = vn[1] * x161;
    const double x213 = vn[0] * x109;
    const double x214 = wL[64] + wR[64];
    const double x215 = 0.24253562503633297 * x214;
    const double x216 = wL[66] + wR[66];
    const double x217 = vn[0] * x216;
    const double x218 = vn[1] * x116;
    const double x219 = wL[78] + wR[78];
    const double x220 = vn[1] * x219;
    const double x221 = wL[80] + wR[80];
    const double x222 = 0.24253562503633297 * x221;
    const double x223 = wL[65] + wR[65];
    const double x224 = 0.12126781251816648 * vn[2];
    const double x225 = 0.22687130324325752 * x223;
    const double x226 = wL[67] + wR[67];
    const double x227 = vn[0] * x226;
    const double x228 = wL[77] + wR[77];
    const double x229 = vn[1] * x228;
    const double x230 = wL[79] + wR[79];
    const double x231 = 0.22687130324325752 * x230;
    const double x232 = 0.16568337391590282 * vn[2];
    const double x233 = wL[68] + wR[68];
    const double x234 = vn[0] * x233;
    const double x235 = wL[76] + wR[76];
    const double x236 = vn[1] * x235;
    const double x237 = 0.19553847221876072 * x226;
    const double x238 = 0.043852900965351459 * vn[0];
    const double x239 = wL[69] + wR[69];
    const double x240 = vn[0] * x239;
    const double x241 = 0.043852900965351459 * vn[1];
    const double x242 = wL[75] + wR[75];
    const double x243 = vn[1] * x242;
    const double x244 = 0.21693045781865616 * vn[2];
    const double x245 = wL[70] + wR[70];
    const double x246 = vn[0] * x245;
    const double x247 = wL[74] + wR[74];
    const double x248 = vn[1] * x247;
    const double x249 = 0.23221018200641197 * vn[2];
    const double x250 = 0.15191090506254998 * x136;
    const double x251 = wL[71] + wR[71];
    const double x252 = 0.10145993123917846 * vn[0];
    const double x253 = 0.15191090506254998 * x139;
    const double x254 = wL[73] + wR[73];
    const double x255 = 0.10145993123917846 * vn[1];
    const double x256 = 0.24253562503633297 * vn[2];
    const double x257 = wL[72] + wR[72];
    const double x258 = 0.16568337391590282 * x257;
    const double x259 = 0.24852506087385423 * vn[2];
    const double x260 = 0.18786728732554484 * vn[0];
    const double x261 = 0.18786728732554484 * vn[1];
    const double x262 = 0.25048971643405976 * vn[2];
    const double x263 = vn[0] * x247;
    const double x264 = vn[1] * x245;
    const double x265 = vn[0] * x242;
    const double x266 = vn[1] * x239;
    const double x267 = vn[0] * x235;
    const double x268 = vn[1] * x233;
    const double x269 = 0.19553847221876072 * x228;
    const double x270 = vn[0] * x116;
    const double x271 = vn[0] * x219;
    const double x272 = vn[1] * x109;
    const double x273 = vn[1] * x216;
    const double x274 = 0.038348249442368525 * vn[0];
    const double x275 = 0.038348249442368525 * vn[1];
    const double x276 = vn[0] * x159;
    const double x277 = wL[81] + wR[81];
    const double x278 = 0.24333213169614379 * x277;
    const double x279 = wL[83] + wR[83];
    const double x280 = vn[0] * x279;
    const double x281 = vn[1] * x166;
    const double x282 = wL[97] + wR[97];
    const double x283 = vn[1] * x282;
    const double x284 = wL[99] + wR[99];
    const double x285 = 0.24333213169614379 * x284;
    const double x286 = wL[82] + wR[82];
    const double x287 = 0.11470786693528089 * vn[2];
    const double x288 = 0.22687130324325752 * x168;
    const double x289 = 0.22941573387056177 * x286;
    const double x290 = wL[84] + wR[84];
    const double x291 = vn[0] * x290;
    const double x292 = 0.22687130324325752 * x176;
    const double x293 = wL[96] + wR[96];
    const double x294 = vn[1] * x293;
    const double x295 = wL[98] + wR[98];
    const double x296 = 0.22941573387056177 * x295;
    const double x297 = 0.15737789507292674 * vn[2];
    const double x298 = wL[85] + wR[85];
    const double x299 = vn[0] * x298;
    const double x300 = wL[95] + wR[95];
    const double x301 = vn[1] * x300;
    const double x302 = 0.18662722567253981 * vn[2];
    const double x303 = wL[86] + wR[86];
    const double x304 = vn[0] * x303;
    const double x305 = wL[94] + wR[94];
    const double x306 = vn[1] * x305;
    const double x307 = 0.19553847221876072 * vn[2];
    const double x308 = 0.20819138611089077 * vn[2];
    const double x309 = wL[87] + wR[87];
    const double x310 = vn[0] * x309;
    const double x311 = wL[93] + wR[93];
    const double x312 = vn[1] * x311;
    const double x313 = 0.22429801051997725 * vn[2];
    const double x314 = wL[88] + wR[88];
    const double x315 = vn[0] * x314;
    const double x316 = wL[92] + wR[92];
    const double x317 = vn[1] * x316;
    const double x318 = 0.23606684260939009 * vn[2];
    const double x319 = 0.14852213144650114 * x189;
    const double x320 = wL[89] + wR[89];
    const double x321 = 0.10409569305544539 * vn[0];
    const double x322 = 0.14852213144650114 * x192;
    const double x323 = wL[91] + wR[91];
    const double x324 = 0.10409569305544539 * vn[1];
    const double x325 = 0.24412603961850168 * vn[2];
    const double x326 = wL[90] + wR[90];
    const double x327 = 0.16692446522239715 * x326;
    const double x328 = 0.24883630089671976 * vn[2];
    const double x329 = 0.18662722567253981 * vn[0];
    const double x330 = 0.18662722567253981 * vn[1];
    const double x331 = 0.25038669783359574 * vn[2];
    const double x332 = vn[0] * x316;
    const double x333 = vn[1] * x314;
    const double x334 = vn[0] * x311;
    const double x335 = vn[1] * x309;
    const double x336 = vn[0] * x305;
    const double x337 = vn[1] * x303;
    const double x338 = vn[0] * x300;
    const double x339 = vn[1] * x298;
    const double x340 = vn[0] * x293;
    const double x341 = vn[1] * x290;
    const double x342 = vn[0] * x166;
    const double x343 = vn[0] * x282;
    const double x344 = vn[1] * x159;
    const double x345 = vn[1] * x279;
    const double x346 = wL[100] + wR[100];
    const double x347 = 0.24397501823713327 * x346;
    const double x348 = wL[102] + wR[102];
    const double x349 = vn[0] * x348;
    const double x350 = vn[0] * x214;
    const double x351 = wL[118] + wR[118];
    const double x352 = vn[1] * x351;
    const double x353 = wL[120] + wR[120];
    const double x354 = 0.24397501823713327 * x353;
    const double x355 = vn[1] * x221;
    const double x356 = wL[101] + wR[101];
    const double x357 = 0.10910894511799618 * vn[2];
    const double x358 = 0.23145502494313785 * x356;
    const double x359 = wL[103] + wR[103];
    const double x360 = vn[0] * x359;
    const double x361 = vn[0] * x223;
    const double x362 = wL[117] + wR[117];
    const double x363 = vn[1] * x362;
    const double x364 = wL[119] + wR[119];
    const double x365 = 0.23145502494313785 * x364;
    const double x366 = vn[1] * x230;
    const double x367 = 0.15018785229652765 * vn[2];
    const double x368 = wL[104] + wR[104];
    const double x369 = vn[0] * x368;
    const double x370 = wL[116] + wR[116];
    const double x371 = vn[1] * x370;
    const double x372 = 0.17875929966870285 * vn[2];
    const double x373 = wL[105] + wR[105];
    const double x374 = vn[0] * x373;
    const double x375 = wL[115] + wR[115];
    const double x376 = vn[1] * x375;
    const double x377 = 0.20025046972870353 * vn[2];
    const double x378 = wL[106] + wR[106];
    const double x379 = vn[0] * x378;
    const double x380 = wL[114] + wR[114];
    const double x381 = vn[1] * x380;
    const double x382 = 0.21677749238103 * vn[2];
    const double x383 = wL[107] + wR[107];
    const double x384 = vn[0] * x383;
    const double x385 = wL[113] + wR[113];
    const double x386 = vn[1] * x385;
    const double x387 = 0.22941573387056177 * vn[2];
    const double x388 = wL[108] + wR[108];
    const double x389 = vn[0] * x388;
    const double x390 = wL[112] + wR[112];
    const double x391 = vn[1] * x390;
    const double x392 = 0.23878346647045962 * vn[2];
    const double x393 = wL[109] + wR[109];
    const double x394 = 0.1061988488107183 * vn[0];
    const double x395 = 0.14589321341776743 * x251;
    const double x396 = wL[111] + wR[111];
    const double x397 = 0.1061988488107183 * vn[1];
    const double x398 = 0.14589321341776743 * x254;
    const double x399 = 0.2452557357939863 * vn[2];
    const double x400 = wL[110] + wR[110];
    const double x401 = 0.16791512356486687 * x400;
    const double x402 = 0.24905837706844941 * vn[2];
    const double x403 = 0.18563715383027588 * vn[0];
    const double x404 = 0.18563715383027588 * vn[1];
    const double x405 = 0.25031308716087941 * vn[2];
    const double x406 = vn[0] * x390;
    const double x407 = vn[1] * x388;
    const double x408 = vn[0] * x385;
    const double x409 = vn[1] * x383;
    const double x410 = vn[0] * x380;
    const double x411 = vn[1] * x378;
    const double x412 = vn[0] * x375;
    const double x413 = vn[0] * x228;
    const double x414 = vn[1] * x373;
    const double x415 = vn[1] * x226;
    const double x416 = vn[0] * x370;
    const double x417 = vn[1] * x368;
    const double x418 = vn[0] * x362;
    const double x419 = vn[0] * x230;
    const double x420 = vn[1] * x359;
    const double x421 = vn[1] * x223;
    const double x422 = vn[0] * x351;
    const double x423 = vn[0] * x221;
    const double x424 = vn[1] * x348;
    const double x425 = vn[1] * x214;
    const double x426 =
        0.24450482346091287 * wL[121] + 0.24450482346091287 * wR[121];
    const double x427 = wL[123] + wR[123];
    const double x428 = vn[0] * x427;
    const double x429 = vn[0] * x277;
    const double x430 = wL[141] + wR[141];
    const double x431 = vn[1] * x430;
    const double x432 =
        0.24450482346091287 * wL[143] + 0.24450482346091287 * wR[143];
    const double x433 = vn[1] * x284;
    const double x434 = wL[122] + wR[122];
    const double x435 = 0.10425720702853737 * vn[2];
    const double x436 = 0.23312620206007842 * x434;
    const double x437 = wL[124] + wR[124];
    const double x438 = vn[0] * x437;
    const double x439 = vn[0] * x286;
    const double x440 = wL[140] + wR[140];
    const double x441 = vn[1] * x440;
    const double x442 = wL[142] + wR[142];
    const double x443 = 0.23312620206007842 * x442;
    const double x444 = vn[1] * x295;
    const double x445 = 0.14388861576723855 * vn[2];
    const double x446 = wL[125] + wR[125];
    const double x447 = vn[0] * x446;
    const double x448 = wL[139] + wR[139];
    const double x449 = vn[1] * x448;
    const double x450 = 0.17176468085745134 * vn[2];
    const double x451 = wL[126] + wR[126];
    const double x452 = vn[0] * x451;
    const double x453 = wL[138] + wR[138];
    const double x454 = vn[1] * x453;
    const double x455 = 0.19304683562633607 * vn[2];
    const double x456 = wL[127] + wR[127];
    const double x457 = vn[0] * x456;
    const double x458 = wL[137] + wR[137];
    const double x459 = vn[1] * x458;
    const double x460 = 0.20975189918866177 * vn[2];
    const double x461 = wL[128] + wR[128];
    const double x462 = vn[0] * x461;
    const double x463 = wL[136] + wR[136];
    const double x464 = vn[1] * x463;
    const double x465 = 0.22291128503014113 * vn[2];
    const double x466 = wL[129] + wR[129];
    const double x467 = vn[0] * x466;
    const double x468 = wL[135] + wR[135];
    const double x469 = vn[1] * x468;
    const double x470 = 0.23312620206007842 * vn[2];
    const double x471 = wL[130] + wR[130];
    const double x472 = vn[0] * x471;
    const double x473 = wL[134] + wR[134];
    const double x474 = vn[1] * x473;
    const double x475 = 0.2407717061715384 * vn[2];
    const double x476 = wL[131] + wR[131];
    const double x477 = 0.1079164618254289 * vn[0];
    const double x478 = 0.14379392104440059 * x320;
    const double x479 = wL[133] + wR[133];
    const double x480 = 0.1079164618254289 * vn[1];
    const double x481 = 0.14379392104440059 * x323;
    const double x482 = 0.24608739547400657 * vn[2];
    const double x483 = wL[132] + wR[132];
    const double x484 = 0.16872435776345843 * x483;
    const double x485 = 0.24922239313961336 * vn[2];
    const double x486 = 0.18482827349523615 * vn[0];
    const double x487 = 0.18482827349523615 * vn[1];
    const double x488 = 0.25025866535630953 * vn[2];
    const double x489 = vn[0] * x473;
    const double x490 = vn[1] * x471;
    const double x491 = vn[0] * x468;
    const double x492 = vn[1] * x466;
    const double x493 = vn[0] * x463;
    const double x494 = vn[1] * x461;
    const double x495 = vn[0] * x458;
    const double x496 = vn[1] * x456;
    const double x497 = vn[0] * x453;
    const double x498 = vn[1] * x451;
    const double x499 = vn[0] * x448;
    const double x500 = vn[1] * x446;
    const double x501 = vn[0] * x440;
    const double x502 = vn[0] * x295;
    const double x503 = vn[1] * x437;
    const double x504 = vn[1] * x286;
    const double x505 = vn[0] * x430;
    const double x506 = vn[0] * x284;
    const double x507 = vn[1] * x427;
    const double x508 = vn[1] * x277;
    const double x509 = vn[0] * x346;
    const double x510 = vn[1] * x353;
    const double x511 = vn[0] * x356;
    const double x512 = vn[1] * x364;
    const double x513 = 0.14207862402109159 * x393;
    const double x514 = 0.14207862402109159 * x396;
    const double x515 = vn[0] * x364;
    const double x516 = vn[1] * x356;
    const double x517 = vn[0] * x353;
    const double x518 = vn[1] * x346;
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
    flux[36] = -vn[0] * x160 + vn[1] * x167 - 0.24019223070763071 * x158 +
               0.025318484177091663 * x162 - 0.24019223070763071 * x163 +
               0.025318484177091663 * x165 + x168 * x169 -
               x6 * (-wL[36] + wR[36]);
    flux[37] = x119 * x67 + x13 * x176 + x161 * x177 - x168 * x8 -
               0.2192645048267573 * x170 + 0.043852900965351459 * x172 -
               0.2192645048267573 * x173 + 0.043852900965351459 * x175 -
               x6 * (-wL[37] + wR[37]);
    flux[38] = x129 * x77 + 0.029565619799454133 * x158 -
               0.2056883378018606 * x162 - 0.029565619799454133 * x163 +
               0.2056883378018606 * x165 + x171 * x182 +
               0.062017367294604227 * x179 + 0.062017367294604227 * x181 -
               x6 * (-wL[38] + wR[38]) - 0.19833220700547941 * x70 -
               0.19833220700547941 * x74;
    flux[39] = x134 * x69 + 0.051209155649918917 * x170 -
               0.1877669040497027 * x172 - 0.051209155649918917 * x173 +
               0.1877669040497027 * x175 + x178 * x187 +
               0.080064076902543566 * x184 + 0.080064076902543566 * x186 -
               x6 * (-wL[39] + wR[39]) - 0.1773937187967248 * x82 -
               0.1773937187967248 * x85;
    flux[40] = -vn[0] * x188 - vn[1] * x191 + x141 * x81 -
               0.16984155512168939 * x179 + 0.16984155512168939 * x181 +
               x183 * x194 + x189 * x190 + x192 * x193 -
               x6 * (-wL[40] + wR[40]) + 0.072420682437790138 * x70 -
               0.072420682437790138 * x74;
    flux[41] = vn[1] * x196 + x144 * x90 - x146 * x96 -
               0.15191090506254998 * x184 + 0.15191090506254998 * x186 +
               x189 * x197 - x6 * (-wL[41] + wR[41]) +
               0.093494699000845727 * x82 - 0.093494699000845727 * x85;
    flux[42] = 0.16193756890782393 * vn[0] * x93 +
               0.16193756890782393 * vn[1] * x90 + x147 * x96 - x189 * x199 -
               x192 * x198 + x195 * x200 - x6 * (-wL[42] + wR[42]);
    flux[43] = vn[0] * x196 + 0.093494699000845727 * x102 +
               0.093494699000845727 * x103 + x144 * x93 - x145 * x96 +
               x192 * x197 - 0.15191090506254998 * x201 -
               0.15191090506254998 * x202 - x6 * (-wL[43] + wR[43]);
    flux[44] = -vn[0] * x191 + vn[1] * x188 + 0.072420682437790138 * x105 +
               0.072420682437790138 * x106 + x141 * x84 + x185 * x194 -
               x189 * x193 + x190 * x192 - 0.16984155512168939 * x203 -
               0.16984155512168939 * x204 - x6 * (-wL[44] + wR[44]);
    flux[45] = -0.1773937187967248 * x102 + 0.1773937187967248 * x103 +
               x134 * x73 + x180 * x187 + 0.080064076902543566 * x201 -
               0.080064076902543566 * x202 + 0.051209155649918917 * x205 -
               0.1877669040497027 * x206 + 0.051209155649918917 * x207 -
               0.1877669040497027 * x208 - x6 * (-wL[45] + wR[45]);
    flux[46] = -0.19833220700547941 * x105 + 0.19833220700547941 * x106 +
               x129 * x86 + x174 * x182 + 0.062017367294604227 * x203 -
               0.062017367294604227 * x204 + 0.029565619799454133 * x209 -
               0.2056883378018606 * x210 + 0.029565619799454133 * x211 -
               0.2056883378018606 * x212 - x6 * (-wL[46] + wR[46]);
    flux[47] = x119 * x75 - x13 * x168 + x164 * x177 - x176 * x8 -
               0.2192645048267573 * x205 + 0.043852900965351459 * x206 +
               0.2192645048267573 * x207 - 0.043852900965351459 * x208 -
               x6 * (-wL[47] + wR[47]);
    flux[48] = -vn[0] * x167 - vn[1] * x160 + x169 * x176 -
               0.24019223070763071 * x209 + 0.025318484177091663 * x210 +
               0.24019223070763071 * x211 - 0.025318484177091663 * x212 -
               x6 * (-wL[48] + wR[48]);
    flux[49] = -vn[0] * x215 + vn[1] * x222 - 0.24152294576982397 * x213 +
               0.022140372138502382 * x217 - 0.24152294576982397 * x218 +
               0.022140372138502382 * x220 + x223 * x224 -
               x6 * (-wL[49] + wR[49]);
    flux[50] = -vn[0] * x225 + vn[1] * x231 + x109 * x169 - x118 * x8 -
               x127 * x13 + x216 * x232 + 0.038348249442368525 * x227 +
               0.038348249442368525 * x229 - x6 * (-wL[50] + wR[50]);
    flux[51] = vn[2] * x237 - 0.2056883378018606 * x112 -
               0.2056883378018606 * x115 + x118 * x177 +
               0.025318484177091663 * x213 - 0.21120568916876956 * x217 -
               0.025318484177091663 * x218 + 0.21120568916876956 * x220 +
               0.054232614454664041 * x234 + 0.054232614454664041 * x236 -
               x6 * (-wL[51] + wR[51]);
    flux[52] = x111 * x182 + x118 * x238 - 0.1877669040497027 * x123 -
               0.1877669040497027 * x126 - x127 * x241 -
               0.19553847221876072 * x227 + 0.19553847221876072 * x229 +
               x233 * x244 + 0.070014004201400498 * x240 +
               0.070014004201400498 * x243 - x6 * (-wL[52] + wR[52]);
    flux[53] = 0.062017367294604227 * x112 - 0.062017367294604227 * x115 +
               x122 * x187 - 0.16984155512168939 * x131 -
               0.16984155512168939 * x133 - 0.17986923354612536 * x234 +
               0.17986923354612536 * x236 + x239 * x249 +
               0.085749292571254424 * x246 + 0.085749292571254424 * x248 -
               x6 * (-wL[53] + wR[53]);
    flux[54] = -vn[0] * x250 - vn[1] * x253 + 0.080064076902543566 * x123 -
               0.080064076902543566 * x126 + x130 * x194 -
               0.16419739435729633 * x240 + 0.16419739435729633 * x243 +
               x245 * x256 + x251 * x252 + x254 * x255 -
               x6 * (-wL[54] + wR[54]);
    flux[55] = vn[1] * x258 + 0.098058067569092008 * x131 -
               0.098058067569092008 * x133 + x136 * x197 - x142 * x199 -
               0.14852213144650114 * x246 + 0.14852213144650114 * x248 +
               x251 * x259 - x6 * (-wL[55] + wR[55]);
    flux[56] = 0.16408253082847341 * vn[0] * x139 +
               0.16408253082847341 * vn[1] * x136 + x142 * x200 - x251 * x261 -
               x254 * x260 + x257 * x262 - x6 * (-wL[56] + wR[56]);
    flux[57] = vn[0] * x258 + x139 * x197 - x142 * x198 +
               0.098058067569092008 * x148 + 0.098058067569092008 * x149 +
               x254 * x259 - 0.14852213144650114 * x263 -
               0.14852213144650114 * x264 - x6 * (-wL[57] + wR[57]);
    flux[58] = -vn[0] * x253 + vn[1] * x250 + x132 * x194 +
               0.080064076902543566 * x151 + 0.080064076902543566 * x153 +
               x247 * x256 - x251 * x255 + x252 * x254 -
               0.16419739435729633 * x265 - 0.16419739435729633 * x266 -
               x6 * (-wL[58] + wR[58]);
    flux[59] = x125 * x187 - 0.16984155512168939 * x148 +
               0.16984155512168939 * x149 + 0.062017367294604227 * x155 +
               0.062017367294604227 * x157 + x242 * x249 +
               0.085749292571254424 * x263 - 0.085749292571254424 * x264 -
               0.17986923354612536 * x267 - 0.17986923354612536 * x268 -
               x6 * (-wL[59] + wR[59]);
    flux[60] = -vn[0] * x269 - vn[1] * x237 + x114 * x182 + x118 * x241 +
               x127 * x238 - 0.1877669040497027 * x151 +
               0.1877669040497027 * x153 + x235 * x244 +
               0.070014004201400498 * x265 - 0.070014004201400498 * x266 -
               x6 * (-wL[60] + wR[60]);
    flux[61] = vn[2] * x269 + x127 * x177 - 0.2056883378018606 * x155 +
               0.2056883378018606 * x157 + 0.054232614454664041 * x267 -
               0.054232614454664041 * x268 + 0.025318484177091663 * x270 -
               0.21120568916876956 * x271 + 0.025318484177091663 * x272 -
               0.21120568916876956 * x273 - x6 * (-wL[61] + wR[61]);
    flux[62] = -vn[0] * x231 - vn[1] * x225 + x116 * x169 + x118 * x13 -
               x127 * x8 + x219 * x232 - x226 * x275 + x228 * x274 -
               x6 * (-wL[62] + wR[62]);
    flux[63] = -vn[0] * x222 - vn[1] * x215 + x224 * x230 -
               0.24152294576982397 * x270 + 0.022140372138502382 * x271 +
               0.24152294576982397 * x272 - 0.022140372138502382 * x273 -
               x6 * (-wL[63] + wR[63]);
    flux[64] = -vn[0] * x278 + vn[1] * x285 - 0.24253562503633297 * x276 +
               0.019672236884115842 * x280 - 0.24253562503633297 * x281 +
               0.019672236884115842 * x283 + x286 * x287 -
               x6 * (-wL[64] + wR[64]);
    flux[65] = -vn[0] * x288 - vn[0] * x289 - vn[1] * x292 + vn[1] * x296 +
               x159 * x224 + x279 * x297 + 0.034073313781819103 * x291 +
               0.034073313781819103 * x294 - x6 * (-wL[65] + wR[65]);
    flux[66] = -0.21120568916876956 * x162 - 0.21120568916876956 * x165 +
               x168 * x232 + 0.022140372138502382 * x276 -
               0.21549855796030778 * x280 - 0.022140372138502382 * x281 +
               0.21549855796030778 * x283 + x290 * x302 +
               0.048186942465242667 * x299 + 0.048186942465242667 * x301 -
               x6 * (-wL[66] + wR[66]);
    flux[67] = x161 * x307 + x168 * x274 - 0.19553847221876072 * x172 -
               0.19553847221876072 * x175 - x176 * x275 -
               0.20158044280782952 * x291 + 0.20158044280782952 * x294 +
               x298 * x308 + 0.062209075224179941 * x304 +
               0.062209075224179941 * x306 - x6 * (-wL[67] + wR[67]);
    flux[68] = 0.054232614454664041 * x162 - 0.054232614454664041 * x165 +
               x171 * x244 - 0.17986923354612536 * x179 -
               0.17986923354612536 * x181 - 0.18766117943318453 * x299 +
               0.18766117943318453 * x301 + x303 * x313 +
               0.076190245834827947 * x310 + 0.076190245834827947 * x312 -
               x6 * (-wL[68] + wR[68]);
    flux[69] = 0.070014004201400498 * x172 - 0.070014004201400498 * x175 +
               x178 * x249 - 0.16419739435729633 * x184 -
               0.16419739435729633 * x186 - 0.17374049186626556 * x304 +
               0.17374049186626556 * x306 + x309 * x318 +
               0.090149514610563072 * x315 + 0.090149514610563072 * x317 -
               x6 * (-wL[69] + wR[69]);
    flux[70] = -vn[0] * x319 - vn[1] * x322 + 0.085749292571254424 * x179 -
               0.085749292571254424 * x181 + x183 * x256 -
               0.15981800795165318 * x310 + 0.15981800795165318 * x312 +
               x314 * x325 + x320 * x321 + x323 * x324 -
               x6 * (-wL[70] + wR[70]);
    flux[71] = vn[1] * x327 + 0.10145993123917846 * x184 -
               0.10145993123917846 * x186 + x189 * x259 - x195 * x261 -
               0.14589321341776743 * x315 + 0.14589321341776743 * x317 +
               x320 * x328 - x6 * (-wL[71] + wR[71]);
    flux[72] = 0.16568337391590282 * vn[0] * x192 +
               0.16568337391590282 * vn[1] * x189 + x195 * x262 - x320 * x330 -
               x323 * x329 + x326 * x331 - x6 * (-wL[72] + wR[72]);
    flux[73] = vn[0] * x327 + x192 * x259 - x195 * x260 +
               0.10145993123917846 * x201 + 0.10145993123917846 * x202 +
               x323 * x328 - 0.14589321341776743 * x332 -
               0.14589321341776743 * x333 - x6 * (-wL[73] + wR[73]);
    flux[74] = -vn[0] * x322 + vn[1] * x319 + x185 * x256 +
               0.085749292571254424 * x203 + 0.085749292571254424 * x204 +
               x316 * x325 - x320 * x324 + x321 * x323 -
               0.15981800795165318 * x334 - 0.15981800795165318 * x335 -
               x6 * (-wL[74] + wR[74]);
    flux[75] = x180 * x249 - 0.16419739435729633 * x201 +
               0.16419739435729633 * x202 + 0.070014004201400498 * x206 +
               0.070014004201400498 * x208 + x311 * x318 +
               0.090149514610563072 * x332 - 0.090149514610563072 * x333 -
               0.17374049186626556 * x336 - 0.17374049186626556 * x337 -
               x6 * (-wL[75] + wR[75]);
    flux[76] = x174 * x244 - 0.17986923354612536 * x203 +
               0.17986923354612536 * x204 + 0.054232614454664041 * x210 +
               0.054232614454664041 * x212 + x305 * x313 +
               0.076190245834827947 * x334 - 0.076190245834827947 * x335 -
               0.18766117943318453 * x338 - 0.18766117943318453 * x339 -
               x6 * (-wL[76] + wR[76]);
    flux[77] = x164 * x307 + x168 * x275 + x176 * x274 -
               0.19553847221876072 * x206 + 0.19553847221876072 * x208 +
               x300 * x308 + 0.062209075224179941 * x336 -
               0.062209075224179941 * x337 - 0.20158044280782952 * x340 -
               0.20158044280782952 * x341 - x6 * (-wL[77] + wR[77]);
    flux[78] = x176 * x232 - 0.21120568916876956 * x210 +
               0.21120568916876956 * x212 + x293 * x302 +
               0.048186942465242667 * x338 - 0.048186942465242667 * x339 +
               0.022140372138502382 * x342 - 0.21549855796030778 * x343 +
               0.022140372138502382 * x344 - 0.21549855796030778 * x345 -
               x6 * (-wL[78] + wR[78]);
    flux[79] = -vn[0] * x292 - vn[0] * x296 + vn[1] * x288 - vn[1] * x289 +
               x166 * x224 + x282 * x297 + 0.034073313781819103 * x340 -
               0.034073313781819103 * x341 - x6 * (-wL[79] + wR[79]);
    flux[80] = -vn[0] * x285 - vn[1] * x278 + x287 * x295 -
               0.24253562503633297 * x342 + 0.019672236884115842 * x343 +
               0.24253562503633297 * x344 - 0.019672236884115842 * x345 -
               x6 * (-wL[80] + wR[80]);
    flux[81] = -vn[0] * x347 + vn[1] * x354 + 0.017699808135119718 * x349 -
               0.24333213169614379 * x350 + 0.017699808135119718 * x352 -
               0.24333213169614379 * x355 + x356 * x357 -
               x6 * (-wL[81] + wR[81]);
    flux[82] = -vn[0] * x358 + vn[1] * x365 + x214 * x287 + x348 * x367 +
               0.030656966974248287 * x360 - 0.22941573387056177 * x361 +
               0.030656966974248287 * x363 - 0.22941573387056177 * x366 -
               x6 * (-wL[82] + wR[82]);
    flux[83] = -0.21549855796030778 * x217 - 0.21549855796030778 * x220 +
               x223 * x297 - 0.21893453548279601 * x349 +
               0.019672236884115842 * x350 + 0.21893453548279601 * x352 -
               0.019672236884115842 * x355 + x359 * x372 +
               0.043355498476205998 * x369 + 0.043355498476205998 * x371 -
               x6 * (-wL[83] + wR[83]);
    flux[84] = x216 * x302 - 0.20158044280782952 * x227 -
               0.20158044280782952 * x229 - 0.20641345956774915 * x360 +
               0.034073313781819103 * x361 + 0.20641345956774915 * x363 -
               0.034073313781819103 * x366 + x368 * x377 +
               0.055971707854955623 * x374 + 0.055971707854955623 * x376 -
               x6 * (-wL[84] + wR[84]);
    flux[85] = 0.048186942465242667 * x217 - 0.048186942465242667 * x220 +
               x226 * x308 - 0.18766117943318453 * x234 -
               0.18766117943318453 * x236 - 0.19389168358237033 * x369 +
               0.19389168358237033 * x371 + x373 * x382 +
               0.06855106213838523 * x379 + 0.06855106213838523 * x381 -
               x6 * (-wL[85] + wR[85]);
    flux[86] = 0.062209075224179941 * x227 - 0.062209075224179941 * x229 +
               x233 * x313 - 0.17374049186626556 * x240 -
               0.17374049186626556 * x243 - 0.1813690625275029 * x374 +
               0.1813690625275029 * x376 + x378 * x387 +
               0.081110710565381258 * x384 + 0.081110710565381258 * x386 -
               x6 * (-wL[86] + wR[86]);
    flux[87] = 0.076190245834827947 * x234 - 0.076190245834827947 * x236 +
               x239 * x318 - 0.15981800795165318 * x246 -
               0.15981800795165318 * x248 - 0.16884540837649259 * x379 +
               0.16884540837649259 * x381 + x383 * x392 +
               0.093658581158169385 * x389 + 0.093658581158169385 * x391 -
               x6 * (-wL[87] + wR[87]);
    flux[88] = -vn[0] * x395 - vn[1] * x398 + 0.090149514610563072 * x240 -
               0.090149514610563072 * x243 + x245 * x325 -
               0.15632047282926156 * x384 + 0.15632047282926156 * x386 +
               x388 * x399 + x393 * x394 + x396 * x397 -
               x6 * (-wL[88] + wR[88]);
    flux[89] = vn[1] * x401 + 0.10409569305544539 * x246 -
               0.10409569305544539 * x248 + x251 * x328 - x257 * x330 -
               0.14379392104440059 * x389 + 0.14379392104440059 * x391 +
               x393 * x402 - x6 * (-wL[89] + wR[89]);
    flux[90] = 0.16692446522239715 * vn[0] * x254 +
               0.16692446522239715 * vn[1] * x251 + x257 * x331 - x393 * x404 -
               x396 * x403 + x400 * x405 - x6 * (-wL[90] + wR[90]);
    flux[91] = vn[0] * x401 + x254 * x328 - x257 * x329 +
               0.10409569305544539 * x263 + 0.10409569305544539 * x264 +
               x396 * x402 - 0.14379392104440059 * x406 -
               0.14379392104440059 * x407 - x6 * (-wL[91] + wR[91]);
    flux[92] = -vn[0] * x398 + vn[1] * x395 + x247 * x325 +
               0.090149514610563072 * x265 + 0.090149514610563072 * x266 +
               x390 * x399 - x393 * x397 + x394 * x396 -
               0.15632047282926156 * x408 - 0.15632047282926156 * x409 -
               x6 * (-wL[92] + wR[92]);
    flux[93] = x242 * x318 - 0.15981800795165318 * x263 +
               0.15981800795165318 * x264 + 0.076190245834827947 * x267 +
               0.076190245834827947 * x268 + x385 * x392 +
               0.093658581158169385 * x406 - 0.093658581158169385 * x407 -
               0.16884540837649259 * x410 - 0.16884540837649259 * x411 -
               x6 * (-wL[93] + wR[93]);
    flux[94] = x235 * x313 - 0.17374049186626556 * x265 +
               0.17374049186626556 * x266 + x380 * x387 +
               0.081110710565381258 * x408 - 0.081110710565381258 * x409 -
               0.1813690625275029 * x412 + 0.062209075224179941 * x413 -
               0.1813690625275029 * x414 + 0.062209075224179941 * x415 -
               x6 * (-wL[94] + wR[94]);
    flux[95] = x228 * x308 - 0.18766117943318453 * x267 +
               0.18766117943318453 * x268 + 0.048186942465242667 * x271 +
               0.048186942465242667 * x273 + x375 * x382 +
               0.06855106213838523 * x410 - 0.06855106213838523 * x411 -
               0.19389168358237033 * x416 - 0.19389168358237033 * x417 -
               x6 * (-wL[95] + wR[95]);
    flux[96] = x219 * x302 + x370 * x377 + 0.055971707854955623 * x412 -
               0.20158044280782952 * x413 - 0.055971707854955623 * x414 +
               0.20158044280782952 * x415 - 0.20641345956774915 * x418 +
               0.034073313781819103 * x419 - 0.20641345956774915 * x420 +
               0.034073313781819103 * x421 - x6 * (-wL[96] + wR[96]);
    flux[97] = x230 * x297 - 0.21549855796030778 * x271 +
               0.21549855796030778 * x273 + x362 * x372 +
               0.043355498476205998 * x416 - 0.043355498476205998 * x417 -
               0.21893453548279601 * x422 + 0.019672236884115842 * x423 -
               0.21893453548279601 * x424 + 0.019672236884115842 * x425 -
               x6 * (-wL[97] + wR[97]);
    flux[98] = -vn[0] * x365 - vn[1] * x358 + x221 * x287 + x351 * x367 +
               0.030656966974248287 * x418 - 0.22941573387056177 * x419 -
               0.030656966974248287 * x420 + 0.22941573387056177 * x421 -
               x6 * (-wL[98] + wR[98]);
    flux[99] = -vn[0] * x354 - vn[1] * x347 + x357 * x364 +
               0.017699808135119718 * x422 - 0.24333213169614379 * x423 -
               0.017699808135119718 * x424 + 0.24333213169614379 * x425 -
               x6 * (-wL[99] + wR[99]);
    flux[100] = -vn[0] * x426 + vn[1] * x432 + 0.016087236302194673 * x428 -
                0.24397501823713327 * x429 + 0.016087236302194673 * x431 -
                0.24397501823713327 * x433 + x434 * x435 -
                x6 * (-wL[100] + wR[100]);
    flux[101] = -vn[0] * x436 + vn[1] * x443 + x277 * x357 + x427 * x445 +
                0.027863910628767641 * x438 - 0.23145502494313785 * x439 +
                0.027863910628767641 * x441 - 0.23145502494313785 * x444 -
                x6 * (-wL[101] + wR[101]);
    flux[102] = -0.21893453548279601 * x280 - 0.21893453548279601 * x283 +
                x286 * x367 - 0.22174724947584698 * x428 +
                0.017699808135119718 * x429 + 0.22174724947584698 * x431 -
                0.017699808135119718 * x433 + x437 * x450 +
                0.039405520311955031 * x447 + 0.039405520311955031 * x449 -
                x6 * (-wL[102] + wR[102]);
    flux[103] = x279 * x372 - 0.20641345956774915 * x291 -
                0.20641345956774915 * x294 - 0.21036791196637658 * x438 +
                0.030656966974248287 * x439 + 0.21036791196637658 * x441 -
                0.030656966974248287 * x444 + x446 * x455 +
                0.050872307972279977 * x452 + 0.050872307972279977 * x454 -
                x6 * (-wL[103] + wR[103]);
    flux[104] = 0.043355498476205998 * x280 - 0.043355498476205998 * x283 +
                x290 * x377 - 0.19389168358237033 * x299 -
                0.19389168358237033 * x301 - 0.19898812349465853 * x447 +
                0.19898812349465853 * x449 + x451 * x460 +
                0.062305598284903341 * x457 + 0.062305598284903341 * x459 -
                x6 * (-wL[104] + wR[104]);
    flux[105] = 0.055971707854955623 * x291 - 0.055971707854955623 * x294 +
                x298 * x382 - 0.1813690625275029 * x304 -
                0.1813690625275029 * x306 - 0.18760780199821228 * x452 +
                0.18760780199821228 * x454 + x456 * x465 +
                0.073720978077448568 * x462 + 0.073720978077448568 * x464 -
                x6 * (-wL[105] + wR[105]);
    flux[106] = 0.06855106213838523 * x299 - 0.06855106213838523 * x301 +
                x303 * x387 - 0.16884540837649259 * x310 -
                0.16884540837649259 * x312 - 0.17622684421256032 * x457 +
                0.17622684421256032 * x459 + x461 * x470 +
                0.085125653075874858 * x467 + 0.085125653075874858 * x469 -
                x6 * (-wL[106] + wR[106]);
    flux[107] = 0.081110710565381258 * x304 - 0.081110710565381258 * x306 +
                x309 * x392 - 0.15632047282926156 * x315 -
                0.15632047282926156 * x317 - 0.16484511834894675 * x462 +
                0.16484511834894675 * x464 + x466 * x475 +
                0.096523417813168033 * x472 + 0.096523417813168033 * x474 -
                x6 * (-wL[107] + wR[107]);
    flux[108] = -vn[0] * x478 - vn[1] * x481 + 0.093658581158169385 * x310 -
                0.093658581158169385 * x312 + x314 * x399 -
                0.15346245351121282 * x467 + 0.15346245351121282 * x469 +
                x471 * x482 + x476 * x477 + x479 * x480 -
                x6 * (-wL[108] + wR[108]);
    flux[109] = vn[1] * x484 + 0.1061988488107183 * x315 -
                0.1061988488107183 * x317 + x320 * x402 - x326 * x404 -
                0.14207862402109159 * x472 + 0.14207862402109159 * x474 +
                x476 * x485 - x6 * (-wL[109] + wR[109]);
    flux[110] = 0.16791512356486687 * vn[0] * x323 +
                0.16791512356486687 * vn[1] * x320 + x326 * x405 - x476 * x487 -
                x479 * x486 + x483 * x488 - x6 * (-wL[110] + wR[110]);
    flux[111] = vn[0] * x484 + x323 * x402 - x326 * x403 +
                0.1061988488107183 * x332 + 0.1061988488107183 * x333 +
                x479 * x485 - 0.14207862402109159 * x489 -
                0.14207862402109159 * x490 - x6 * (-wL[111] + wR[111]);
    flux[112] = -vn[0] * x481 + vn[1] * x478 + x316 * x399 +
                0.093658581158169385 * x334 + 0.093658581158169385 * x335 +
                x473 * x482 - x476 * x480 + x477 * x479 -
                0.15346245351121282 * x491 - 0.15346245351121282 * x492 -
                x6 * (-wL[112] + wR[112]);
    flux[113] = x311 * x392 - 0.15632047282926156 * x332 +
                0.15632047282926156 * x333 + 0.081110710565381258 * x336 +
                0.081110710565381258 * x337 + x468 * x475 +
                0.096523417813168033 * x489 - 0.096523417813168033 * x490 -
                0.16484511834894675 * x493 - 0.16484511834894675 * x494 -
                x6 * (-wL[113] + wR[113]);
    flux[114] = x305 * x387 - 0.16884540837649259 * x334 +
                0.16884540837649259 * x335 + 0.06855106213838523 * x338 +
                0.06855106213838523 * x339 + x463 * x470 +
                0.085125653075874858 * x491 - 0.085125653075874858 * x492 -
                0.17622684421256032 * x495 - 0.17622684421256032 * x496 -
                x6 * (-wL[114] + wR[114]);
    flux[115] = x300 * x382 - 0.1813690625275029 * x336 +
                0.1813690625275029 * x337 + 0.055971707854955623 * x340 +
                0.055971707854955623 * x341 + x458 * x465 +
                0.073720978077448568 * x493 - 0.073720978077448568 * x494 -
                0.18760780199821228 * x497 - 0.18760780199821228 * x498 -
                x6 * (-wL[115] + wR[115]);
    flux[116] = x293 * x377 - 0.19389168358237033 * x338 +
                0.19389168358237033 * x339 + 0.043355498476205998 * x343 +
                0.043355498476205998 * x345 + x453 * x460 +
                0.062305598284903341 * x495 - 0.062305598284903341 * x496 -
                0.19898812349465853 * x499 - 0.19898812349465853 * x500 -
                x6 * (-wL[116] + wR[116]);
    flux[117] = x282 * x372 - 0.20641345956774915 * x340 +
                0.20641345956774915 * x341 + x448 * x455 +
                0.050872307972279977 * x497 - 0.050872307972279977 * x498 -
                0.21036791196637658 * x501 + 0.030656966974248287 * x502 -
                0.21036791196637658 * x503 + 0.030656966974248287 * x504 -
                x6 * (-wL[117] + wR[117]);
    flux[118] = x295 * x367 - 0.21893453548279601 * x343 +
                0.21893453548279601 * x345 + x440 * x450 +
                0.039405520311955031 * x499 - 0.039405520311955031 * x500 -
                0.22174724947584698 * x505 + 0.017699808135119718 * x506 -
                0.22174724947584698 * x507 + 0.017699808135119718 * x508 -
                x6 * (-wL[118] + wR[118]);
    flux[119] = -vn[0] * x443 - vn[1] * x436 + x284 * x357 + x430 * x445 +
                0.027863910628767641 * x501 - 0.23145502494313785 * x502 -
                0.027863910628767641 * x503 + 0.23145502494313785 * x504 -
                x6 * (-wL[119] + wR[119]);
    flux[120] = -vn[0] * x432 - vn[1] * x426 + x435 * x442 +
                0.016087236302194673 * x505 - 0.24397501823713327 * x506 -
                0.016087236302194673 * x507 + 0.24397501823713327 * x508 -
                x6 * (-wL[120] + wR[120]);
    flux[121] = -0.24450482346091287 * x509 - 0.24450482346091287 * x510 -
                x6 * (-wL[121] + wR[121]);
    flux[122] = x346 * x435 - 0.23312620206007842 * x511 -
                0.23312620206007842 * x512 - x6 * (-wL[122] + wR[122]);
    flux[123] = -0.22174724947584698 * x349 - 0.22174724947584698 * x352 +
                x356 * x445 + 0.016087236302194673 * x509 -
                0.016087236302194673 * x510 - x6 * (-wL[123] + wR[123]);
    flux[124] = x348 * x450 - 0.21036791196637658 * x360 -
                0.21036791196637658 * x363 + 0.027863910628767641 * x511 -
                0.027863910628767641 * x512 - x6 * (-wL[124] + wR[124]);
    flux[125] = 0.039405520311955031 * x349 - 0.039405520311955031 * x352 +
                x359 * x455 - 0.19898812349465853 * x369 -
                0.19898812349465853 * x371 - x6 * (-wL[125] + wR[125]);
    flux[126] = 0.050872307972279977 * x360 - 0.050872307972279977 * x363 +
                x368 * x460 - 0.18760780199821228 * x374 -
                0.18760780199821228 * x376 - x6 * (-wL[126] + wR[126]);
    flux[127] = 0.062305598284903341 * x369 - 0.062305598284903341 * x371 +
                x373 * x465 - 0.17622684421256032 * x379 -
                0.17622684421256032 * x381 - x6 * (-wL[127] + wR[127]);
    flux[128] = 0.073720978077448568 * x374 - 0.073720978077448568 * x376 +
                x378 * x470 - 0.16484511834894675 * x384 -
                0.16484511834894675 * x386 - x6 * (-wL[128] + wR[128]);
    flux[129] = 0.085125653075874858 * x379 - 0.085125653075874858 * x381 +
                x383 * x475 - 0.15346245351121282 * x389 -
                0.15346245351121282 * x391 - x6 * (-wL[129] + wR[129]);
    flux[130] = -vn[0] * x513 - vn[1] * x514 + 0.096523417813168033 * x384 -
                0.096523417813168033 * x386 + x388 * x482 -
                x6 * (-wL[130] + wR[130]);
    flux[131] = 0.1079164618254289 * x389 - 0.1079164618254289 * x391 +
                x393 * x485 - x400 * x487 - x6 * (-wL[131] + wR[131]);
    flux[132] = 0.16872435776345843 * vn[0] * x396 +
                0.16872435776345843 * vn[1] * x393 + x400 * x488 -
                x6 * (-wL[132] + wR[132]);
    flux[133] = x396 * x485 - x400 * x486 + 0.1079164618254289 * x406 +
                0.1079164618254289 * x407 - x6 * (-wL[133] + wR[133]);
    flux[134] = -vn[0] * x514 + vn[1] * x513 + x390 * x482 +
                0.096523417813168033 * x408 + 0.096523417813168033 * x409 -
                x6 * (-wL[134] + wR[134]);
    flux[135] = x385 * x475 - 0.15346245351121282 * x406 +
                0.15346245351121282 * x407 + 0.085125653075874858 * x410 +
                0.085125653075874858 * x411 - x6 * (-wL[135] + wR[135]);
    flux[136] = x380 * x470 - 0.16484511834894675 * x408 +
                0.16484511834894675 * x409 + 0.073720978077448568 * x412 +
                0.073720978077448568 * x414 - x6 * (-wL[136] + wR[136]);
    flux[137] = x375 * x465 - 0.17622684421256032 * x410 +
                0.17622684421256032 * x411 + 0.062305598284903341 * x416 +
                0.062305598284903341 * x417 - x6 * (-wL[137] + wR[137]);
    flux[138] = x370 * x460 - 0.18760780199821228 * x412 +
                0.18760780199821228 * x414 + 0.050872307972279977 * x418 +
                0.050872307972279977 * x420 - x6 * (-wL[138] + wR[138]);
    flux[139] = x362 * x455 - 0.19898812349465853 * x416 +
                0.19898812349465853 * x417 + 0.039405520311955031 * x422 +
                0.039405520311955031 * x424 - x6 * (-wL[139] + wR[139]);
    flux[140] = x351 * x450 - 0.21036791196637658 * x418 +
                0.21036791196637658 * x420 + 0.027863910628767641 * x515 +
                0.027863910628767641 * x516 - x6 * (-wL[140] + wR[140]);
    flux[141] = x364 * x445 - 0.22174724947584698 * x422 +
                0.22174724947584698 * x424 + 0.016087236302194673 * x517 +
                0.016087236302194673 * x518 - x6 * (-wL[141] + wR[141]);
    flux[142] = x353 * x435 - 0.23312620206007842 * x515 +
                0.23312620206007842 * x516 - x6 * (-wL[142] + wR[142]);
    flux[143] = -0.24450482346091287 * x517 + 0.24450482346091287 * x518 -
                x6 * (-wL[143] + wR[143]);
}

#endif

#else

#ifdef IS_2D

void num_flux_rus(const float wL[78], const float wR[78], const float vn[2],
                  float flux[78])
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
    const float x83 = wL[28] + wR[28];
    const float x84 = 0.241522946F * x83;
    const float x85 = wL[29] + wR[29];
    const float x86 = vn[0] * x85;
    const float x87 = vn[1] * x45;
    const float x88 = wL[34] + wR[34];
    const float x89 = vn[1] * x88;
    const float x90 = wL[35] + wR[35];
    const float x91 = 0.241522946F * x90;
    const float x92 = wL[30] + wR[30];
    const float x93 = vn[0] * x92;
    const float x94 = wL[33] + wR[33];
    const float x95 = vn[1] * x94;
    const float x96 = 0.156446555F * x48;
    const float x97 = wL[31] + wR[31];
    const float x98 = 0.0980580676F * vn[0];
    const float x99 = 0.156446555F * x51;
    const float x100 = wL[32] + wR[32];
    const float x101 = 0.0980580676F * vn[1];
    const float x102 = 0.189466187F * vn[0];
    const float x103 = 0.189466187F * vn[1];
    const float x104 = vn[0] * x94;
    const float x105 = vn[1] * x92;
    const float x106 = vn[0] * x45;
    const float x107 = vn[0] * x88;
    const float x108 = vn[1] * x38;
    const float x109 = vn[1] * x85;
    const float x110 = vn[0] * x61;
    const float x111 = wL[36] + wR[36];
    const float x112 = 0.242535625F * x111;
    const float x113 = wL[37] + wR[37];
    const float x114 = vn[0] * x113;
    const float x115 = vn[1] * x68;
    const float x116 = wL[43] + wR[43];
    const float x117 = vn[1] * x116;
    const float x118 = wL[44] + wR[44];
    const float x119 = 0.242535625F * x118;
    const float x120 = wL[38] + wR[38];
    const float x121 = vn[0] * x120;
    const float x122 = wL[42] + wR[42];
    const float x123 = vn[1] * x122;
    const float x124 = wL[39] + wR[39];
    const float x125 = vn[0] * x124;
    const float x126 = wL[41] + wR[41];
    const float x127 = vn[1] * x126;
    const float x128 = wL[40] + wR[40];
    const float x129 = 0.165683374F * x128;
    const float x130 = vn[0] * x126;
    const float x131 = vn[1] * x124;
    const float x132 = vn[0] * x122;
    const float x133 = vn[1] * x120;
    const float x134 = vn[0] * x68;
    const float x135 = vn[0] * x116;
    const float x136 = vn[1] * x61;
    const float x137 = vn[1] * x113;
    const float x138 = vn[0] * x83;
    const float x139 = wL[45] + wR[45];
    const float x140 = 0.243332132F * x139;
    const float x141 = wL[46] + wR[46];
    const float x142 = vn[0] * x141;
    const float x143 = vn[1] * x90;
    const float x144 = wL[53] + wR[53];
    const float x145 = vn[1] * x144;
    const float x146 = wL[54] + wR[54];
    const float x147 = 0.243332132F * x146;
    const float x148 = wL[47] + wR[47];
    const float x149 = vn[0] * x148;
    const float x150 = wL[52] + wR[52];
    const float x151 = vn[1] * x150;
    const float x152 = wL[48] + wR[48];
    const float x153 = vn[0] * x152;
    const float x154 = wL[51] + wR[51];
    const float x155 = vn[1] * x154;
    const float x156 = 0.148522131F * x97;
    const float x157 = wL[49] + wR[49];
    const float x158 = 0.104095693F * vn[0];
    const float x159 = 0.148522131F * x100;
    const float x160 = wL[50] + wR[50];
    const float x161 = 0.104095693F * vn[1];
    const float x162 = 0.186627226F * vn[0];
    const float x163 = 0.186627226F * vn[1];
    const float x164 = vn[0] * x154;
    const float x165 = vn[1] * x152;
    const float x166 = vn[0] * x150;
    const float x167 = vn[1] * x148;
    const float x168 = vn[0] * x90;
    const float x169 = vn[0] * x144;
    const float x170 = vn[1] * x83;
    const float x171 = vn[1] * x141;
    const float x172 = vn[0] * x111;
    const float x173 = wL[55] + wR[55];
    const float x174 = 0.243975018F * x173;
    const float x175 = wL[56] + wR[56];
    const float x176 = vn[0] * x175;
    const float x177 = vn[1] * x118;
    const float x178 = wL[64] + wR[64];
    const float x179 = vn[1] * x178;
    const float x180 = wL[65] + wR[65];
    const float x181 = 0.243975018F * x180;
    const float x182 = wL[57] + wR[57];
    const float x183 = vn[0] * x182;
    const float x184 = wL[63] + wR[63];
    const float x185 = vn[1] * x184;
    const float x186 = wL[58] + wR[58];
    const float x187 = vn[0] * x186;
    const float x188 = wL[62] + wR[62];
    const float x189 = vn[1] * x188;
    const float x190 = wL[59] + wR[59];
    const float x191 = vn[0] * x190;
    const float x192 = wL[61] + wR[61];
    const float x193 = vn[1] * x192;
    const float x194 = wL[60] + wR[60];
    const float x195 = 0.167915124F * x194;
    const float x196 = vn[0] * x192;
    const float x197 = vn[1] * x190;
    const float x198 = vn[0] * x188;
    const float x199 = vn[1] * x186;
    const float x200 = vn[0] * x184;
    const float x201 = vn[1] * x182;
    const float x202 = vn[0] * x118;
    const float x203 = vn[0] * x178;
    const float x204 = vn[1] * x111;
    const float x205 = vn[1] * x175;
    const float x206 = vn[0] * x139;
    const float x207 = 0.244504823F * wL[66] + 0.244504823F * wR[66];
    const float x208 = wL[67] + wR[67];
    const float x209 = vn[0] * x208;
    const float x210 = vn[1] * x146;
    const float x211 = wL[76] + wR[76];
    const float x212 = vn[1] * x211;
    const float x213 = 0.244504823F * wL[77] + 0.244504823F * wR[77];
    const float x214 = wL[68] + wR[68];
    const float x215 = vn[0] * x214;
    const float x216 = wL[75] + wR[75];
    const float x217 = vn[1] * x216;
    const float x218 = wL[69] + wR[69];
    const float x219 = vn[0] * x218;
    const float x220 = wL[74] + wR[74];
    const float x221 = vn[1] * x220;
    const float x222 = wL[70] + wR[70];
    const float x223 = vn[0] * x222;
    const float x224 = wL[73] + wR[73];
    const float x225 = vn[1] * x224;
    const float x226 = 0.143793921F * x157;
    const float x227 = wL[71] + wR[71];
    const float x228 = 0.107916462F * vn[0];
    const float x229 = 0.143793921F * x160;
    const float x230 = wL[72] + wR[72];
    const float x231 = 0.107916462F * vn[1];
    const float x232 = 0.184828273F * vn[0];
    const float x233 = 0.184828273F * vn[1];
    const float x234 = vn[0] * x224;
    const float x235 = vn[1] * x222;
    const float x236 = vn[0] * x220;
    const float x237 = vn[1] * x218;
    const float x238 = vn[0] * x216;
    const float x239 = vn[1] * x214;
    const float x240 = vn[0] * x146;
    const float x241 = vn[0] * x211;
    const float x242 = vn[1] * x139;
    const float x243 = vn[1] * x208;
    const float x244 = vn[0] * x173;
    const float x245 = vn[1] * x180;
    const float x246 = vn[0] * x180;
    const float x247 = vn[1] * x173;
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
    flux[21] = -vn[0] * x84 + vn[1] * x91 - x4 * (-wL[21] + wR[21]) -
               0.240192231F * x82 + 0.0253184842F * x86 - 0.240192231F * x87 +
               0.0253184842F * x89;
    flux[22] = -x4 * (-wL[22] + wR[22]) - 0.198332207F * x41 -
               0.198332207F * x44 + 0.0295656198F * x82 - 0.205688338F * x86 -
               0.0295656198F * x87 + 0.205688338F * x89 + 0.0620173673F * x93 +
               0.0620173673F * x95;
    flux[23] = -vn[0] * x96 - vn[1] * x99 + x100 * x101 -
               x4 * (-wL[23] + wR[23]) + 0.0724206824F * x41 -
               0.0724206824F * x44 - 0.169841555F * x93 + 0.169841555F * x95 +
               x97 * x98;
    flux[24] = 0.161937569F * vn[0] * x51 + 0.161937569F * vn[1] * x48 -
               x100 * x102 - x103 * x97 - x4 * (-wL[24] + wR[24]);
    flux[25] = -vn[0] * x99 + vn[1] * x96 + x100 * x98 - x101 * x97 -
               0.169841555F * x104 - 0.169841555F * x105 -
               x4 * (-wL[25] + wR[25]) + 0.0724206824F * x56 +
               0.0724206824F * x58;
    flux[26] =
        0.0620173673F * x104 - 0.0620173673F * x105 + 0.0295656198F * x106 -
        0.205688338F * x107 + 0.0295656198F * x108 - 0.205688338F * x109 -
        x4 * (-wL[26] + wR[26]) - 0.198332207F * x56 + 0.198332207F * x58;
    flux[27] = -vn[0] * x91 - vn[1] * x84 - 0.240192231F * x106 +
               0.0253184842F * x107 + 0.240192231F * x108 -
               0.0253184842F * x109 - x4 * (-wL[27] + wR[27]);
    flux[28] = -vn[0] * x112 + vn[1] * x119 - 0.241522946F * x110 +
               0.0221403721F * x114 - 0.241522946F * x115 +
               0.0221403721F * x117 - x4 * (-wL[28] + wR[28]);
    flux[29] =
        0.0253184842F * x110 - 0.211205689F * x114 - 0.0253184842F * x115 +
        0.211205689F * x117 + 0.0542326145F * x121 + 0.0542326145F * x123 -
        x4 * (-wL[29] + wR[29]) - 0.205688338F * x64 - 0.205688338F * x67;
    flux[30] = -0.179869234F * x121 + 0.179869234F * x123 +
               0.0857492926F * x125 + 0.0857492926F * x127 -
               x4 * (-wL[30] + wR[30]) + 0.0620173673F * x64 -
               0.0620173673F * x67 - 0.169841555F * x71 - 0.169841555F * x73;
    flux[31] = vn[1] * x129 - x103 * x74 - 0.148522131F * x125 +
               0.148522131F * x127 - x4 * (-wL[31] + wR[31]) +
               0.0980580676F * x71 - 0.0980580676F * x73;
    flux[32] = vn[0] * x129 - x102 * x74 - 0.148522131F * x130 -
               0.148522131F * x131 - x4 * (-wL[32] + wR[32]) +
               0.0980580676F * x76 + 0.0980580676F * x77;
    flux[33] = 0.0857492926F * x130 - 0.0857492926F * x131 -
               0.179869234F * x132 - 0.179869234F * x133 -
               x4 * (-wL[33] + wR[33]) - 0.169841555F * x76 +
               0.169841555F * x77 + 0.0620173673F * x79 + 0.0620173673F * x81;
    flux[34] =
        0.0542326145F * x132 - 0.0542326145F * x133 + 0.0253184842F * x134 -
        0.211205689F * x135 + 0.0253184842F * x136 - 0.211205689F * x137 -
        x4 * (-wL[34] + wR[34]) - 0.205688338F * x79 + 0.205688338F * x81;
    flux[35] = -vn[0] * x119 - vn[1] * x112 - 0.241522946F * x134 +
               0.0221403721F * x135 + 0.241522946F * x136 -
               0.0221403721F * x137 - x4 * (-wL[35] + wR[35]);
    flux[36] = -vn[0] * x140 + vn[1] * x147 - 0.242535625F * x138 +
               0.0196722369F * x142 - 0.242535625F * x143 +
               0.0196722369F * x145 - x4 * (-wL[36] + wR[36]);
    flux[37] =
        0.0221403721F * x138 - 0.215498558F * x142 - 0.0221403721F * x143 +
        0.215498558F * x145 + 0.0481869425F * x149 + 0.0481869425F * x151 -
        x4 * (-wL[37] + wR[37]) - 0.211205689F * x86 - 0.211205689F * x89;
    flux[38] = -0.187661179F * x149 + 0.187661179F * x151 +
               0.0761902458F * x153 + 0.0761902458F * x155 -
               x4 * (-wL[38] + wR[38]) + 0.0542326145F * x86 -
               0.0542326145F * x89 - 0.179869234F * x93 - 0.179869234F * x95;
    flux[39] = -vn[0] * x156 - vn[1] * x159 - 0.159818008F * x153 +
               0.159818008F * x155 + x157 * x158 + x160 * x161 -
               x4 * (-wL[39] + wR[39]) + 0.0857492926F * x93 -
               0.0857492926F * x95;
    flux[40] = 0.165683374F * vn[0] * x100 + 0.165683374F * vn[1] * x97 -
               x157 * x163 - x160 * x162 - x4 * (-wL[40] + wR[40]);
    flux[41] = -vn[0] * x159 + vn[1] * x156 + 0.0857492926F * x104 +
               0.0857492926F * x105 - x157 * x161 + x158 * x160 -
               0.159818008F * x164 - 0.159818008F * x165 -
               x4 * (-wL[41] + wR[41]);
    flux[42] =
        -0.179869234F * x104 + 0.179869234F * x105 + 0.0542326145F * x107 +
        0.0542326145F * x109 + 0.0761902458F * x164 - 0.0761902458F * x165 -
        0.187661179F * x166 - 0.187661179F * x167 - x4 * (-wL[42] + wR[42]);
    flux[43] =
        -0.211205689F * x107 + 0.211205689F * x109 + 0.0481869425F * x166 -
        0.0481869425F * x167 + 0.0221403721F * x168 - 0.215498558F * x169 +
        0.0221403721F * x170 - 0.215498558F * x171 - x4 * (-wL[43] + wR[43]);
    flux[44] = -vn[0] * x147 - vn[1] * x140 - 0.242535625F * x168 +
               0.0196722369F * x169 + 0.242535625F * x170 -
               0.0196722369F * x171 - x4 * (-wL[44] + wR[44]);
    flux[45] = -vn[0] * x174 + vn[1] * x181 - 0.243332132F * x172 +
               0.0176998081F * x176 - 0.243332132F * x177 +
               0.0176998081F * x179 - x4 * (-wL[45] + wR[45]);
    flux[46] =
        -0.215498558F * x114 - 0.215498558F * x117 + 0.0196722369F * x172 -
        0.218934535F * x176 - 0.0196722369F * x177 + 0.218934535F * x179 +
        0.0433554985F * x183 + 0.0433554985F * x185 - x4 * (-wL[46] + wR[46]);
    flux[47] = 0.0481869425F * x114 - 0.0481869425F * x117 -
               0.187661179F * x121 - 0.187661179F * x123 - 0.193891684F * x183 +
               0.193891684F * x185 + 0.0685510621F * x187 +
               0.0685510621F * x189 - x4 * (-wL[47] + wR[47]);
    flux[48] = 0.0761902458F * x121 - 0.0761902458F * x123 -
               0.159818008F * x125 - 0.159818008F * x127 - 0.168845408F * x187 +
               0.168845408F * x189 + 0.0936585812F * x191 +
               0.0936585812F * x193 - x4 * (-wL[48] + wR[48]);
    flux[49] = vn[1] * x195 + 0.104095693F * x125 - 0.104095693F * x127 -
               x128 * x163 - 0.143793921F * x191 + 0.143793921F * x193 -
               x4 * (-wL[49] + wR[49]);
    flux[50] = vn[0] * x195 - x128 * x162 + 0.104095693F * x130 +
               0.104095693F * x131 - 0.143793921F * x196 - 0.143793921F * x197 -
               x4 * (-wL[50] + wR[50]);
    flux[51] =
        -0.159818008F * x130 + 0.159818008F * x131 + 0.0761902458F * x132 +
        0.0761902458F * x133 + 0.0936585812F * x196 - 0.0936585812F * x197 -
        0.168845408F * x198 - 0.168845408F * x199 - x4 * (-wL[51] + wR[51]);
    flux[52] =
        -0.187661179F * x132 + 0.187661179F * x133 + 0.0481869425F * x135 +
        0.0481869425F * x137 + 0.0685510621F * x198 - 0.0685510621F * x199 -
        0.193891684F * x200 - 0.193891684F * x201 - x4 * (-wL[52] + wR[52]);
    flux[53] =
        -0.215498558F * x135 + 0.215498558F * x137 + 0.0433554985F * x200 -
        0.0433554985F * x201 + 0.0196722369F * x202 - 0.218934535F * x203 +
        0.0196722369F * x204 - 0.218934535F * x205 - x4 * (-wL[53] + wR[53]);
    flux[54] = -vn[0] * x181 - vn[1] * x174 - 0.243332132F * x202 +
               0.0176998081F * x203 + 0.243332132F * x204 -
               0.0176998081F * x205 - x4 * (-wL[54] + wR[54]);
    flux[55] = -vn[0] * x207 + vn[1] * x213 - 0.243975018F * x206 +
               0.0160872363F * x209 - 0.243975018F * x210 +
               0.0160872363F * x212 - x4 * (-wL[55] + wR[55]);
    flux[56] =
        -0.218934535F * x142 - 0.218934535F * x145 + 0.0176998081F * x206 -
        0.221747249F * x209 - 0.0176998081F * x210 + 0.221747249F * x212 +
        0.0394055203F * x215 + 0.0394055203F * x217 - x4 * (-wL[56] + wR[56]);
    flux[57] = 0.0433554985F * x142 - 0.0433554985F * x145 -
               0.193891684F * x149 - 0.193891684F * x151 - 0.198988124F * x215 +
               0.198988124F * x217 + 0.0623055983F * x219 +
               0.0623055983F * x221 - x4 * (-wL[57] + wR[57]);
    flux[58] = 0.0685510621F * x149 - 0.0685510621F * x151 -
               0.168845408F * x153 - 0.168845408F * x155 - 0.176226844F * x219 +
               0.176226844F * x221 + 0.0851256531F * x223 +
               0.0851256531F * x225 - x4 * (-wL[58] + wR[58]);
    flux[59] = -vn[0] * x226 - vn[1] * x229 + 0.0936585812F * x153 -
               0.0936585812F * x155 - 0.153462454F * x223 +
               0.153462454F * x225 + x227 * x228 + x230 * x231 -
               x4 * (-wL[59] + wR[59]);
    flux[60] = 0.167915124F * vn[0] * x160 + 0.167915124F * vn[1] * x157 -
               x227 * x233 - x230 * x232 - x4 * (-wL[60] + wR[60]);
    flux[61] = -vn[0] * x229 + vn[1] * x226 + 0.0936585812F * x164 +
               0.0936585812F * x165 - x227 * x231 + x228 * x230 -
               0.153462454F * x234 - 0.153462454F * x235 -
               x4 * (-wL[61] + wR[61]);
    flux[62] =
        -0.168845408F * x164 + 0.168845408F * x165 + 0.0685510621F * x166 +
        0.0685510621F * x167 + 0.0851256531F * x234 - 0.0851256531F * x235 -
        0.176226844F * x236 - 0.176226844F * x237 - x4 * (-wL[62] + wR[62]);
    flux[63] =
        -0.193891684F * x166 + 0.193891684F * x167 + 0.0433554985F * x169 +
        0.0433554985F * x171 + 0.0623055983F * x236 - 0.0623055983F * x237 -
        0.198988124F * x238 - 0.198988124F * x239 - x4 * (-wL[63] + wR[63]);
    flux[64] =
        -0.218934535F * x169 + 0.218934535F * x171 + 0.0394055203F * x238 -
        0.0394055203F * x239 + 0.0176998081F * x240 - 0.221747249F * x241 +
        0.0176998081F * x242 - 0.221747249F * x243 - x4 * (-wL[64] + wR[64]);
    flux[65] = -vn[0] * x213 - vn[1] * x207 - 0.243975018F * x240 +
               0.0160872363F * x241 + 0.243975018F * x242 -
               0.0160872363F * x243 - x4 * (-wL[65] + wR[65]);
    flux[66] =
        -0.244504823F * x244 - 0.244504823F * x245 - x4 * (-wL[66] + wR[66]);
    flux[67] = -0.221747249F * x176 - 0.221747249F * x179 +
               0.0160872363F * x244 - 0.0160872363F * x245 -
               x4 * (-wL[67] + wR[67]);
    flux[68] = 0.0394055203F * x176 - 0.0394055203F * x179 -
               0.198988124F * x183 - 0.198988124F * x185 -
               x4 * (-wL[68] + wR[68]);
    flux[69] = 0.0623055983F * x183 - 0.0623055983F * x185 -
               0.176226844F * x187 - 0.176226844F * x189 -
               x4 * (-wL[69] + wR[69]);
    flux[70] = 0.0851256531F * x187 - 0.0851256531F * x189 -
               0.153462454F * x191 - 0.153462454F * x193 -
               x4 * (-wL[70] + wR[70]);
    flux[71] = 0.107916462F * x191 - 0.107916462F * x193 - x194 * x233 -
               x4 * (-wL[71] + wR[71]);
    flux[72] = -x194 * x232 + 0.107916462F * x196 + 0.107916462F * x197 -
               x4 * (-wL[72] + wR[72]);
    flux[73] = -0.153462454F * x196 + 0.153462454F * x197 +
               0.0851256531F * x198 + 0.0851256531F * x199 -
               x4 * (-wL[73] + wR[73]);
    flux[74] = -0.176226844F * x198 + 0.176226844F * x199 +
               0.0623055983F * x200 + 0.0623055983F * x201 -
               x4 * (-wL[74] + wR[74]);
    flux[75] = -0.198988124F * x200 + 0.198988124F * x201 +
               0.0394055203F * x203 + 0.0394055203F * x205 -
               x4 * (-wL[75] + wR[75]);
    flux[76] = -0.221747249F * x203 + 0.221747249F * x205 +
               0.0160872363F * x246 + 0.0160872363F * x247 -
               x4 * (-wL[76] + wR[76]);
    flux[77] =
        -0.244504823F * x246 + 0.244504823F * x247 - x4 * (-wL[77] + wR[77]);
}

#else

void num_flux_rus(const float wL[144], const float wR[144], const float vn[3],
                  float flux[144])
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
    const float x159 = wL[49] + wR[49];
    const float x160 = 0.241522946F * x159;
    const float x161 = wL[51] + wR[51];
    const float x162 = vn[0] * x161;
    const float x163 = vn[1] * x75;
    const float x164 = wL[61] + wR[61];
    const float x165 = vn[1] * x164;
    const float x166 = wL[63] + wR[63];
    const float x167 = 0.241522946F * x166;
    const float x168 = wL[50] + wR[50];
    const float x169 = 0.129099445F * vn[2];
    const float x170 = vn[0] * x77;
    const float x171 = wL[52] + wR[52];
    const float x172 = vn[0] * x171;
    const float x173 = vn[1] * x86;
    const float x174 = wL[60] + wR[60];
    const float x175 = vn[1] * x174;
    const float x176 = wL[62] + wR[62];
    const float x177 = 0.175411604F * vn[2];
    const float x178 = wL[53] + wR[53];
    const float x179 = vn[0] * x178;
    const float x180 = wL[59] + wR[59];
    const float x181 = vn[1] * x180;
    const float x182 = 0.205688338F * vn[2];
    const float x183 = wL[54] + wR[54];
    const float x184 = vn[0] * x183;
    const float x185 = wL[58] + wR[58];
    const float x186 = vn[1] * x185;
    const float x187 = 0.226455407F * vn[2];
    const float x188 = 0.156446555F * x90;
    const float x189 = wL[55] + wR[55];
    const float x190 = 0.0980580676F * vn[0];
    const float x191 = 0.156446555F * x93;
    const float x192 = wL[57] + wR[57];
    const float x193 = 0.0980580676F * vn[1];
    const float x194 = 0.240192231F * vn[2];
    const float x195 = wL[56] + wR[56];
    const float x196 = 0.164082531F * x195;
    const float x197 = 0.248069469F * vn[2];
    const float x198 = 0.189466187F * vn[0];
    const float x199 = 0.189466187F * vn[1];
    const float x200 = 0.250640206F * vn[2];
    const float x201 = vn[0] * x185;
    const float x202 = vn[1] * x183;
    const float x203 = vn[0] * x180;
    const float x204 = vn[1] * x178;
    const float x205 = vn[0] * x86;
    const float x206 = vn[0] * x174;
    const float x207 = vn[1] * x77;
    const float x208 = vn[1] * x171;
    const float x209 = vn[0] * x75;
    const float x210 = vn[0] * x164;
    const float x211 = vn[1] * x67;
    const float x212 = vn[1] * x161;
    const float x213 = vn[0] * x109;
    const float x214 = wL[64] + wR[64];
    const float x215 = 0.242535625F * x214;
    const float x216 = wL[66] + wR[66];
    const float x217 = vn[0] * x216;
    const float x218 = vn[1] * x116;
    const float x219 = wL[78] + wR[78];
    const float x220 = vn[1] * x219;
    const float x221 = wL[80] + wR[80];
    const float x222 = 0.242535625F * x221;
    const float x223 = wL[65] + wR[65];
    const float x224 = 0.121267813F * vn[2];
    const float x225 = 0.226871303F * x223;
    const float x226 = wL[67] + wR[67];
    const float x227 = vn[0] * x226;
    const float x228 = wL[77] + wR[77];
    const float x229 = vn[1] * x228;
    const float x230 = wL[79] + wR[79];
    const float x231 = 0.226871303F * x230;
    const float x232 = 0.165683374F * vn[2];
    const float x233 = wL[68] + wR[68];
    const float x234 = vn[0] * x233;
    const float x235 = wL[76] + wR[76];
    const float x236 = vn[1] * x235;
    const float x237 = 0.195538472F * x226;
    const float x238 = 0.043852901F * vn[0];
    const float x239 = wL[69] + wR[69];
    const float x240 = vn[0] * x239;
    const float x241 = 0.043852901F * vn[1];
    const float x242 = wL[75] + wR[75];
    const float x243 = vn[1] * x242;
    const float x244 = 0.216930458F * vn[2];
    const float x245 = wL[70] + wR[70];
    const float x246 = vn[0] * x245;
    const float x247 = wL[74] + wR[74];
    const float x248 = vn[1] * x247;
    const float x249 = 0.232210182F * vn[2];
    const float x250 = 0.151910905F * x136;
    const float x251 = wL[71] + wR[71];
    const float x252 = 0.101459931F * vn[0];
    const float x253 = 0.151910905F * x139;
    const float x254 = wL[73] + wR[73];
    const float x255 = 0.101459931F * vn[1];
    const float x256 = 0.242535625F * vn[2];
    const float x257 = wL[72] + wR[72];
    const float x258 = 0.165683374F * x257;
    const float x259 = 0.248525061F * vn[2];
    const float x260 = 0.187867287F * vn[0];
    const float x261 = 0.187867287F * vn[1];
    const float x262 = 0.250489716F * vn[2];
    const float x263 = vn[0] * x247;
    const float x264 = vn[1] * x245;
    const float x265 = vn[0] * x242;
    const float x266 = vn[1] * x239;
    const float x267 = vn[0] * x235;
    const float x268 = vn[1] * x233;
    const float x269 = 0.195538472F * x228;
    const float x270 = vn[0] * x116;
    const float x271 = vn[0] * x219;
    const float x272 = vn[1] * x109;
    const float x273 = vn[1] * x216;
    const float x274 = 0.0383482494F * vn[0];
    const float x275 = 0.0383482494F * vn[1];
    const float x276 = vn[0] * x159;
    const float x277 = wL[81] + wR[81];
    const float x278 = 0.243332132F * x277;
    const float x279 = wL[83] + wR[83];
    const float x280 = vn[0] * x279;
    const float x281 = vn[1] * x166;
    const float x282 = wL[97] + wR[97];
    const float x283 = vn[1] * x282;
    const float x284 = wL[99] + wR[99];
    const float x285 = 0.243332132F * x284;
    const float x286 = wL[82] + wR[82];
    const float x287 = 0.114707867F * vn[2];
    const float x288 = 0.226871303F * x168;
    const float x289 = 0.229415734F * x286;
    const float x290 = wL[84] + wR[84];
    const float x291 = vn[0] * x290;
    const float x292 = 0.226871303F * x176;
    const float x293 = wL[96] + wR[96];
    const float x294 = vn[1] * x293;
    const float x295 = wL[98] + wR[98];
    const float x296 = 0.229415734F * x295;
    const float x297 = 0.157377895F * vn[2];
    const float x298 = wL[85] + wR[85];
    const float x299 = vn[0] * x298;
    const float x300 = wL[95] + wR[95];
    const float x301 = vn[1] * x300;
    const float x302 = 0.186627226F * vn[2];
    const float x303 = wL[86] + wR[86];
    const float x304 = vn[0] * x303;
    const float x305 = wL[94] + wR[94];
    const float x306 = vn[1] * x305;
    const float x307 = 0.195538472F * vn[2];
    const float x308 = 0.208191386F * vn[2];
    const float x309 = wL[87] + wR[87];
    const float x310 = vn[0] * x309;
    const float x311 = wL[93] + wR[93];
    const float x312 = vn[1] * x311;
    const float x313 = 0.224298011F * vn[2];
    const float x314 = wL[88] + wR[88];
    const float x315 = vn[0] * x314;
    const float x316 = wL[92] + wR[92];
    const float x317 = vn[1] * x316;
    const float x318 = 0.236066843F * vn[2];
    const float x319 = 0.148522131F * x189;
    const float x320 = wL[89] + wR[89];
    const float x321 = 0.104095693F * vn[0];
    const float x322 = 0.148522131F * x192;
    const float x323 = wL[91] + wR[91];
    const float x324 = 0.104095693F * vn[1];
    const float x325 = 0.24412604F * vn[2];
    const float x326 = wL[90] + wR[90];
    const float x327 = 0.166924465F * x326;
    const float x328 = 0.248836301F * vn[2];
    const float x329 = 0.186627226F * vn[0];
    const float x330 = 0.186627226F * vn[1];
    const float x331 = 0.250386698F * vn[2];
    const float x332 = vn[0] * x316;
    const float x333 = vn[1] * x314;
    const float x334 = vn[0] * x311;
    const float x335 = vn[1] * x309;
    const float x336 = vn[0] * x305;
    const float x337 = vn[1] * x303;
    const float x338 = vn[0] * x300;
    const float x339 = vn[1] * x298;
    const float x340 = vn[0] * x293;
    const float x341 = vn[1] * x290;
    const float x342 = vn[0] * x166;
    const float x343 = vn[0] * x282;
    const float x344 = vn[1] * x159;
    const float x345 = vn[1] * x279;
    const float x346 = wL[100] + wR[100];
    const float x347 = 0.243975018F * x346;
    const float x348 = wL[102] + wR[102];
    const float x349 = vn[0] * x348;
    const float x350 = vn[0] * x214;
    const float x351 = wL[118] + wR[118];
    const float x352 = vn[1] * x351;
    const float x353 = wL[120] + wR[120];
    const float x354 = 0.243975018F * x353;
    const float x355 = vn[1] * x221;
    const float x356 = wL[101] + wR[101];
    const float x357 = 0.109108945F * vn[2];
    const float x358 = 0.231455025F * x356;
    const float x359 = wL[103] + wR[103];
    const float x360 = vn[0] * x359;
    const float x361 = vn[0] * x223;
    const float x362 = wL[117] + wR[117];
    const float x363 = vn[1] * x362;
    const float x364 = wL[119] + wR[119];
    const float x365 = 0.231455025F * x364;
    const float x366 = vn[1] * x230;
    const float x367 = 0.150187852F * vn[2];
    const float x368 = wL[104] + wR[104];
    const float x369 = vn[0] * x368;
    const float x370 = wL[116] + wR[116];
    const float x371 = vn[1] * x370;
    const float x372 = 0.1787593F * vn[2];
    const float x373 = wL[105] + wR[105];
    const float x374 = vn[0] * x373;
    const float x375 = wL[115] + wR[115];
    const float x376 = vn[1] * x375;
    const float x377 = 0.20025047F * vn[2];
    const float x378 = wL[106] + wR[106];
    const float x379 = vn[0] * x378;
    const float x380 = wL[114] + wR[114];
    const float x381 = vn[1] * x380;
    const float x382 = 0.216777492F * vn[2];
    const float x383 = wL[107] + wR[107];
    const float x384 = vn[0] * x383;
    const float x385 = wL[113] + wR[113];
    const float x386 = vn[1] * x385;
    const float x387 = 0.229415734F * vn[2];
    const float x388 = wL[108] + wR[108];
    const float x389 = vn[0] * x388;
    const float x390 = wL[112] + wR[112];
    const float x391 = vn[1] * x390;
    const float x392 = 0.238783466F * vn[2];
    const float x393 = wL[109] + wR[109];
    const float x394 = 0.106198849F * vn[0];
    const float x395 = 0.145893213F * x251;
    const float x396 = wL[111] + wR[111];
    const float x397 = 0.106198849F * vn[1];
    const float x398 = 0.145893213F * x254;
    const float x399 = 0.245255736F * vn[2];
    const float x400 = wL[110] + wR[110];
    const float x401 = 0.167915124F * x400;
    const float x402 = 0.249058377F * vn[2];
    const float x403 = 0.185637154F * vn[0];
    const float x404 = 0.185637154F * vn[1];
    const float x405 = 0.250313087F * vn[2];
    const float x406 = vn[0] * x390;
    const float x407 = vn[1] * x388;
    const float x408 = vn[0] * x385;
    const float x409 = vn[1] * x383;
    const float x410 = vn[0] * x380;
    const float x411 = vn[1] * x378;
    const float x412 = vn[0] * x375;
    const float x413 = vn[0] * x228;
    const float x414 = vn[1] * x373;
    const float x415 = vn[1] * x226;
    const float x416 = vn[0] * x370;
    const float x417 = vn[1] * x368;
    const float x418 = vn[0] * x362;
    const float x419 = vn[0] * x230;
    const float x420 = vn[1] * x359;
    const float x421 = vn[1] * x223;
    const float x422 = vn[0] * x351;
    const float x423 = vn[0] * x221;
    const float x424 = vn[1] * x348;
    const float x425 = vn[1] * x214;
    const float x426 = 0.244504823F * wL[121] + 0.244504823F * wR[121];
    const float x427 = wL[123] + wR[123];
    const float x428 = vn[0] * x427;
    const float x429 = vn[0] * x277;
    const float x430 = wL[141] + wR[141];
    const float x431 = vn[1] * x430;
    const float x432 = 0.244504823F * wL[143] + 0.244504823F * wR[143];
    const float x433 = vn[1] * x284;
    const float x434 = wL[122] + wR[122];
    const float x435 = 0.104257207F * vn[2];
    const float x436 = 0.233126202F * x434;
    const float x437 = wL[124] + wR[124];
    const float x438 = vn[0] * x437;
    const float x439 = vn[0] * x286;
    const float x440 = wL[140] + wR[140];
    const float x441 = vn[1] * x440;
    const float x442 = wL[142] + wR[142];
    const float x443 = 0.233126202F * x442;
    const float x444 = vn[1] * x295;
    const float x445 = 0.143888616F * vn[2];
    const float x446 = wL[125] + wR[125];
    const float x447 = vn[0] * x446;
    const float x448 = wL[139] + wR[139];
    const float x449 = vn[1] * x448;
    const float x450 = 0.171764681F * vn[2];
    const float x451 = wL[126] + wR[126];
    const float x452 = vn[0] * x451;
    const float x453 = wL[138] + wR[138];
    const float x454 = vn[1] * x453;
    const float x455 = 0.193046836F * vn[2];
    const float x456 = wL[127] + wR[127];
    const float x457 = vn[0] * x456;
    const float x458 = wL[137] + wR[137];
    const float x459 = vn[1] * x458;
    const float x460 = 0.209751899F * vn[2];
    const float x461 = wL[128] + wR[128];
    const float x462 = vn[0] * x461;
    const float x463 = wL[136] + wR[136];
    const float x464 = vn[1] * x463;
    const float x465 = 0.222911285F * vn[2];
    const float x466 = wL[129] + wR[129];
    const float x467 = vn[0] * x466;
    const float x468 = wL[135] + wR[135];
    const float x469 = vn[1] * x468;
    const float x470 = 0.233126202F * vn[2];
    const float x471 = wL[130] + wR[130];
    const float x472 = vn[0] * x471;
    const float x473 = wL[134] + wR[134];
    const float x474 = vn[1] * x473;
    const float x475 = 0.240771706F * vn[2];
    const float x476 = wL[131] + wR[131];
    const float x477 = 0.107916462F * vn[0];
    const float x478 = 0.143793921F * x320;
    const float x479 = wL[133] + wR[133];
    const float x480 = 0.107916462F * vn[1];
    const float x481 = 0.143793921F * x323;
    const float x482 = 0.246087395F * vn[2];
    const float x483 = wL[132] + wR[132];
    const float x484 = 0.168724358F * x483;
    const float x485 = 0.249222393F * vn[2];
    const float x486 = 0.184828273F * vn[0];
    const float x487 = 0.184828273F * vn[1];
    const float x488 = 0.250258665F * vn[2];
    const float x489 = vn[0] * x473;
    const float x490 = vn[1] * x471;
    const float x491 = vn[0] * x468;
    const float x492 = vn[1] * x466;
    const float x493 = vn[0] * x463;
    const float x494 = vn[1] * x461;
    const float x495 = vn[0] * x458;
    const float x496 = vn[1] * x456;
    const float x497 = vn[0] * x453;
    const float x498 = vn[1] * x451;
    const float x499 = vn[0] * x448;
    const float x500 = vn[1] * x446;
    const float x501 = vn[0] * x440;
    const float x502 = vn[0] * x295;
    const float x503 = vn[1] * x437;
    const float x504 = vn[1] * x286;
    const float x505 = vn[0] * x430;
    const float x506 = vn[0] * x284;
    const float x507 = vn[1] * x427;
    const float x508 = vn[1] * x277;
    const float x509 = vn[0] * x346;
    const float x510 = vn[1] * x353;
    const float x511 = vn[0] * x356;
    const float x512 = vn[1] * x364;
    const float x513 = 0.142078624F * x393;
    const float x514 = 0.142078624F * x396;
    const float x515 = vn[0] * x364;
    const float x516 = vn[1] * x356;
    const float x517 = vn[0] * x353;
    const float x518 = vn[1] * x346;
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
    flux[36] = -vn[0] * x160 + vn[1] * x167 - 0.240192231F * x158 +
               0.0253184842F * x162 - 0.240192231F * x163 +
               0.0253184842F * x165 + x168 * x169 - x6 * (-wL[36] + wR[36]);
    flux[37] = x119 * x67 + x13 * x176 + x161 * x177 - x168 * x8 -
               0.219264505F * x170 + 0.043852901F * x172 - 0.219264505F * x173 +
               0.043852901F * x175 - x6 * (-wL[37] + wR[37]);
    flux[38] = x129 * x77 + 0.0295656198F * x158 - 0.205688338F * x162 -
               0.0295656198F * x163 + 0.205688338F * x165 + x171 * x182 +
               0.0620173673F * x179 + 0.0620173673F * x181 -
               x6 * (-wL[38] + wR[38]) - 0.198332207F * x70 -
               0.198332207F * x74;
    flux[39] = x134 * x69 + 0.0512091557F * x170 - 0.187766904F * x172 -
               0.0512091557F * x173 + 0.187766904F * x175 + x178 * x187 +
               0.0800640769F * x184 + 0.0800640769F * x186 -
               x6 * (-wL[39] + wR[39]) - 0.177393719F * x82 -
               0.177393719F * x85;
    flux[40] = -vn[0] * x188 - vn[1] * x191 + x141 * x81 - 0.169841555F * x179 +
               0.169841555F * x181 + x183 * x194 + x189 * x190 + x192 * x193 -
               x6 * (-wL[40] + wR[40]) + 0.0724206824F * x70 -
               0.0724206824F * x74;
    flux[41] = vn[1] * x196 + x144 * x90 - x146 * x96 - 0.151910905F * x184 +
               0.151910905F * x186 + x189 * x197 - x6 * (-wL[41] + wR[41]) +
               0.093494699F * x82 - 0.093494699F * x85;
    flux[42] = 0.161937569F * vn[0] * x93 + 0.161937569F * vn[1] * x90 +
               x147 * x96 - x189 * x199 - x192 * x198 + x195 * x200 -
               x6 * (-wL[42] + wR[42]);
    flux[43] = vn[0] * x196 + 0.093494699F * x102 + 0.093494699F * x103 +
               x144 * x93 - x145 * x96 + x192 * x197 - 0.151910905F * x201 -
               0.151910905F * x202 - x6 * (-wL[43] + wR[43]);
    flux[44] = -vn[0] * x191 + vn[1] * x188 + 0.0724206824F * x105 +
               0.0724206824F * x106 + x141 * x84 + x185 * x194 - x189 * x193 +
               x190 * x192 - 0.169841555F * x203 - 0.169841555F * x204 -
               x6 * (-wL[44] + wR[44]);
    flux[45] = -0.177393719F * x102 + 0.177393719F * x103 + x134 * x73 +
               x180 * x187 + 0.0800640769F * x201 - 0.0800640769F * x202 +
               0.0512091557F * x205 - 0.187766904F * x206 +
               0.0512091557F * x207 - 0.187766904F * x208 -
               x6 * (-wL[45] + wR[45]);
    flux[46] = -0.198332207F * x105 + 0.198332207F * x106 + x129 * x86 +
               x174 * x182 + 0.0620173673F * x203 - 0.0620173673F * x204 +
               0.0295656198F * x209 - 0.205688338F * x210 +
               0.0295656198F * x211 - 0.205688338F * x212 -
               x6 * (-wL[46] + wR[46]);
    flux[47] = x119 * x75 - x13 * x168 + x164 * x177 - x176 * x8 -
               0.219264505F * x205 + 0.043852901F * x206 + 0.219264505F * x207 -
               0.043852901F * x208 - x6 * (-wL[47] + wR[47]);
    flux[48] = -vn[0] * x167 - vn[1] * x160 + x169 * x176 -
               0.240192231F * x209 + 0.0253184842F * x210 +
               0.240192231F * x211 - 0.0253184842F * x212 -
               x6 * (-wL[48] + wR[48]);
    flux[49] = -vn[0] * x215 + vn[1] * x222 - 0.241522946F * x213 +
               0.0221403721F * x217 - 0.241522946F * x218 +
               0.0221403721F * x220 + x223 * x224 - x6 * (-wL[49] + wR[49]);
    flux[50] = -vn[0] * x225 + vn[1] * x231 + x109 * x169 - x118 * x8 -
               x127 * x13 + x216 * x232 + 0.0383482494F * x227 +
               0.0383482494F * x229 - x6 * (-wL[50] + wR[50]);
    flux[51] = vn[2] * x237 - 0.205688338F * x112 - 0.205688338F * x115 +
               x118 * x177 + 0.0253184842F * x213 - 0.211205689F * x217 -
               0.0253184842F * x218 + 0.211205689F * x220 +
               0.0542326145F * x234 + 0.0542326145F * x236 -
               x6 * (-wL[51] + wR[51]);
    flux[52] = x111 * x182 + x118 * x238 - 0.187766904F * x123 -
               0.187766904F * x126 - x127 * x241 - 0.195538472F * x227 +
               0.195538472F * x229 + x233 * x244 + 0.0700140042F * x240 +
               0.0700140042F * x243 - x6 * (-wL[52] + wR[52]);
    flux[53] = 0.0620173673F * x112 - 0.0620173673F * x115 + x122 * x187 -
               0.169841555F * x131 - 0.169841555F * x133 - 0.179869234F * x234 +
               0.179869234F * x236 + x239 * x249 + 0.0857492926F * x246 +
               0.0857492926F * x248 - x6 * (-wL[53] + wR[53]);
    flux[54] = -vn[0] * x250 - vn[1] * x253 + 0.0800640769F * x123 -
               0.0800640769F * x126 + x130 * x194 - 0.164197394F * x240 +
               0.164197394F * x243 + x245 * x256 + x251 * x252 + x254 * x255 -
               x6 * (-wL[54] + wR[54]);
    flux[55] = vn[1] * x258 + 0.0980580676F * x131 - 0.0980580676F * x133 +
               x136 * x197 - x142 * x199 - 0.148522131F * x246 +
               0.148522131F * x248 + x251 * x259 - x6 * (-wL[55] + wR[55]);
    flux[56] = 0.164082531F * vn[0] * x139 + 0.164082531F * vn[1] * x136 +
               x142 * x200 - x251 * x261 - x254 * x260 + x257 * x262 -
               x6 * (-wL[56] + wR[56]);
    flux[57] = vn[0] * x258 + x139 * x197 - x142 * x198 + 0.0980580676F * x148 +
               0.0980580676F * x149 + x254 * x259 - 0.148522131F * x263 -
               0.148522131F * x264 - x6 * (-wL[57] + wR[57]);
    flux[58] = -vn[0] * x253 + vn[1] * x250 + x132 * x194 +
               0.0800640769F * x151 + 0.0800640769F * x153 + x247 * x256 -
               x251 * x255 + x252 * x254 - 0.164197394F * x265 -
               0.164197394F * x266 - x6 * (-wL[58] + wR[58]);
    flux[59] = x125 * x187 - 0.169841555F * x148 + 0.169841555F * x149 +
               0.0620173673F * x155 + 0.0620173673F * x157 + x242 * x249 +
               0.0857492926F * x263 - 0.0857492926F * x264 -
               0.179869234F * x267 - 0.179869234F * x268 -
               x6 * (-wL[59] + wR[59]);
    flux[60] = -vn[0] * x269 - vn[1] * x237 + x114 * x182 + x118 * x241 +
               x127 * x238 - 0.187766904F * x151 + 0.187766904F * x153 +
               x235 * x244 + 0.0700140042F * x265 - 0.0700140042F * x266 -
               x6 * (-wL[60] + wR[60]);
    flux[61] = vn[2] * x269 + x127 * x177 - 0.205688338F * x155 +
               0.205688338F * x157 + 0.0542326145F * x267 -
               0.0542326145F * x268 + 0.0253184842F * x270 -
               0.211205689F * x271 + 0.0253184842F * x272 -
               0.211205689F * x273 - x6 * (-wL[61] + wR[61]);
    flux[62] = -vn[0] * x231 - vn[1] * x225 + x116 * x169 + x118 * x13 -
               x127 * x8 + x219 * x232 - x226 * x275 + x228 * x274 -
               x6 * (-wL[62] + wR[62]);
    flux[63] = -vn[0] * x222 - vn[1] * x215 + x224 * x230 -
               0.241522946F * x270 + 0.0221403721F * x271 +
               0.241522946F * x272 - 0.0221403721F * x273 -
               x6 * (-wL[63] + wR[63]);
    flux[64] = -vn[0] * x278 + vn[1] * x285 - 0.242535625F * x276 +
               0.0196722369F * x280 - 0.242535625F * x281 +
               0.0196722369F * x283 + x286 * x287 - x6 * (-wL[64] + wR[64]);
    flux[65] = -vn[0] * x288 - vn[0] * x289 - vn[1] * x292 + vn[1] * x296 +
               x159 * x224 + x279 * x297 + 0.0340733138F * x291 +
               0.0340733138F * x294 - x6 * (-wL[65] + wR[65]);
    flux[66] = -0.211205689F * x162 - 0.211205689F * x165 + x168 * x232 +
               0.0221403721F * x276 - 0.215498558F * x280 -
               0.0221403721F * x281 + 0.215498558F * x283 + x290 * x302 +
               0.0481869425F * x299 + 0.0481869425F * x301 -
               x6 * (-wL[66] + wR[66]);
    flux[67] = x161 * x307 + x168 * x274 - 0.195538472F * x172 -
               0.195538472F * x175 - x176 * x275 - 0.201580443F * x291 +
               0.201580443F * x294 + x298 * x308 + 0.0622090752F * x304 +
               0.0622090752F * x306 - x6 * (-wL[67] + wR[67]);
    flux[68] = 0.0542326145F * x162 - 0.0542326145F * x165 + x171 * x244 -
               0.179869234F * x179 - 0.179869234F * x181 - 0.187661179F * x299 +
               0.187661179F * x301 + x303 * x313 + 0.0761902458F * x310 +
               0.0761902458F * x312 - x6 * (-wL[68] + wR[68]);
    flux[69] = 0.0700140042F * x172 - 0.0700140042F * x175 + x178 * x249 -
               0.164197394F * x184 - 0.164197394F * x186 - 0.173740492F * x304 +
               0.173740492F * x306 + x309 * x318 + 0.0901495146F * x315 +
               0.0901495146F * x317 - x6 * (-wL[69] + wR[69]);
    flux[70] = -vn[0] * x319 - vn[1] * x322 + 0.0857492926F * x179 -
               0.0857492926F * x181 + x183 * x256 - 0.159818008F * x310 +
               0.159818008F * x312 + x314 * x325 + x320 * x321 + x323 * x324 -
               x6 * (-wL[70] + wR[70]);
    flux[71] = vn[1] * x327 + 0.101459931F * x184 - 0.101459931F * x186 +
               x189 * x259 - x195 * x261 - 0.145893213F * x315 +
               0.145893213F * x317 + x320 * x328 - x6 * (-wL[71] + wR[71]);
    flux[72] = 0.165683374F * vn[0] * x192 + 0.165683374F * vn[1] * x189 +
               x195 * x262 - x320 * x330 - x323 * x329 + x326 * x331 -
               x6 * (-wL[72] + wR[72]);
    flux[73] = vn[0] * x327 + x192 * x259 - x195 * x260 + 0.101459931F * x201 +
               0.101459931F * x202 + x323 * x328 - 0.145893213F * x332 -
               0.145893213F * x333 - x6 * (-wL[73] + wR[73]);
    flux[74] = -vn[0] * x322 + vn[1] * x319 + x185 * x256 +
               0.0857492926F * x203 + 0.0857492926F * x204 + x316 * x325 -
               x320 * x324 + x321 * x323 - 0.159818008F * x334 -
               0.159818008F * x335 - x6 * (-wL[74] + wR[74]);
    flux[75] = x180 * x249 - 0.164197394F * x201 + 0.164197394F * x202 +
               0.0700140042F * x206 + 0.0700140042F * x208 + x311 * x318 +
               0.0901495146F * x332 - 0.0901495146F * x333 -
               0.173740492F * x336 - 0.173740492F * x337 -
               x6 * (-wL[75] + wR[75]);
    flux[76] = x174 * x244 - 0.179869234F * x203 + 0.179869234F * x204 +
               0.0542326145F * x210 + 0.0542326145F * x212 + x305 * x313 +
               0.0761902458F * x334 - 0.0761902458F * x335 -
               0.187661179F * x338 - 0.187661179F * x339 -
               x6 * (-wL[76] + wR[76]);
    flux[77] = x164 * x307 + x168 * x275 + x176 * x274 - 0.195538472F * x206 +
               0.195538472F * x208 + x300 * x308 + 0.0622090752F * x336 -
               0.0622090752F * x337 - 0.201580443F * x340 -
               0.201580443F * x341 - x6 * (-wL[77] + wR[77]);
    flux[78] = x176 * x232 - 0.211205689F * x210 + 0.211205689F * x212 +
               x293 * x302 + 0.0481869425F * x338 - 0.0481869425F * x339 +
               0.0221403721F * x342 - 0.215498558F * x343 +
               0.0221403721F * x344 - 0.215498558F * x345 -
               x6 * (-wL[78] + wR[78]);
    flux[79] = -vn[0] * x292 - vn[0] * x296 + vn[1] * x288 - vn[1] * x289 +
               x166 * x224 + x282 * x297 + 0.0340733138F * x340 -
               0.0340733138F * x341 - x6 * (-wL[79] + wR[79]);
    flux[80] = -vn[0] * x285 - vn[1] * x278 + x287 * x295 -
               0.242535625F * x342 + 0.0196722369F * x343 +
               0.242535625F * x344 - 0.0196722369F * x345 -
               x6 * (-wL[80] + wR[80]);
    flux[81] = -vn[0] * x347 + vn[1] * x354 + 0.0176998081F * x349 -
               0.243332132F * x350 + 0.0176998081F * x352 -
               0.243332132F * x355 + x356 * x357 - x6 * (-wL[81] + wR[81]);
    flux[82] = -vn[0] * x358 + vn[1] * x365 + x214 * x287 + x348 * x367 +
               0.030656967F * x360 - 0.229415734F * x361 + 0.030656967F * x363 -
               0.229415734F * x366 - x6 * (-wL[82] + wR[82]);
    flux[83] = -0.215498558F * x217 - 0.215498558F * x220 + x223 * x297 -
               0.218934535F * x349 + 0.0196722369F * x350 +
               0.218934535F * x352 - 0.0196722369F * x355 + x359 * x372 +
               0.0433554985F * x369 + 0.0433554985F * x371 -
               x6 * (-wL[83] + wR[83]);
    flux[84] = x216 * x302 - 0.201580443F * x227 - 0.201580443F * x229 -
               0.20641346F * x360 + 0.0340733138F * x361 + 0.20641346F * x363 -
               0.0340733138F * x366 + x368 * x377 + 0.0559717079F * x374 +
               0.0559717079F * x376 - x6 * (-wL[84] + wR[84]);
    flux[85] = 0.0481869425F * x217 - 0.0481869425F * x220 + x226 * x308 -
               0.187661179F * x234 - 0.187661179F * x236 - 0.193891684F * x369 +
               0.193891684F * x371 + x373 * x382 + 0.0685510621F * x379 +
               0.0685510621F * x381 - x6 * (-wL[85] + wR[85]);
    flux[86] = 0.0622090752F * x227 - 0.0622090752F * x229 + x233 * x313 -
               0.173740492F * x240 - 0.173740492F * x243 - 0.181369063F * x374 +
               0.181369063F * x376 + x378 * x387 + 0.0811107106F * x384 +
               0.0811107106F * x386 - x6 * (-wL[86] + wR[86]);
    flux[87] = 0.0761902458F * x234 - 0.0761902458F * x236 + x239 * x318 -
               0.159818008F * x246 - 0.159818008F * x248 - 0.168845408F * x379 +
               0.168845408F * x381 + x383 * x392 + 0.0936585812F * x389 +
               0.0936585812F * x391 - x6 * (-wL[87] + wR[87]);
    flux[88] = -vn[0] * x395 - vn[1] * x398 + 0.0901495146F * x240 -
               0.0901495146F * x243 + x245 * x325 - 0.156320473F * x384 +
               0.156320473F * x386 + x388 * x399 + x393 * x394 + x396 * x397 -
               x6 * (-wL[88] + wR[88]);
    flux[89] = vn[1] * x401 + 0.104095693F * x246 - 0.104095693F * x248 +
               x251 * x328 - x257 * x330 - 0.143793921F * x389 +
               0.143793921F * x391 + x393 * x402 - x6 * (-wL[89] + wR[89]);
    flux[90] = 0.166924465F * vn[0] * x254 + 0.166924465F * vn[1] * x251 +
               x257 * x331 - x393 * x404 - x396 * x403 + x400 * x405 -
               x6 * (-wL[90] + wR[90]);
    flux[91] = vn[0] * x401 + x254 * x328 - x257 * x329 + 0.104095693F * x263 +
               0.104095693F * x264 + x396 * x402 - 0.143793921F * x406 -
               0.143793921F * x407 - x6 * (-wL[91] + wR[91]);
    flux[92] = -vn[0] * x398 + vn[1] * x395 + x247 * x325 +
               0.0901495146F * x265 + 0.0901495146F * x266 + x390 * x399 -
               x393 * x397 + x394 * x396 - 0.156320473F * x408 -
               0.156320473F * x409 - x6 * (-wL[92] + wR[92]);
    flux[93] = x242 * x318 - 0.159818008F * x263 + 0.159818008F * x264 +
               0.0761902458F * x267 + 0.0761902458F * x268 + x385 * x392 +
               0.0936585812F * x406 - 0.0936585812F * x407 -
               0.168845408F * x410 - 0.168845408F * x411 -
               x6 * (-wL[93] + wR[93]);
    flux[94] = x235 * x313 - 0.173740492F * x265 + 0.173740492F * x266 +
               x380 * x387 + 0.0811107106F * x408 - 0.0811107106F * x409 -
               0.181369063F * x412 + 0.0622090752F * x413 -
               0.181369063F * x414 + 0.0622090752F * x415 -
               x6 * (-wL[94] + wR[94]);
    flux[95] = x228 * x308 - 0.187661179F * x267 + 0.187661179F * x268 +
               0.0481869425F * x271 + 0.0481869425F * x273 + x375 * x382 +
               0.0685510621F * x410 - 0.0685510621F * x411 -
               0.193891684F * x416 - 0.193891684F * x417 -
               x6 * (-wL[95] + wR[95]);
    flux[96] = x219 * x302 + x370 * x377 + 0.0559717079F * x412 -
               0.201580443F * x413 - 0.0559717079F * x414 +
               0.201580443F * x415 - 0.20641346F * x418 + 0.0340733138F * x419 -
               0.20641346F * x420 + 0.0340733138F * x421 -
               x6 * (-wL[96] + wR[96]);
    flux[97] = x230 * x297 - 0.215498558F * x271 + 0.215498558F * x273 +
               x362 * x372 + 0.0433554985F * x416 - 0.0433554985F * x417 -
               0.218934535F * x422 + 0.0196722369F * x423 -
               0.218934535F * x424 + 0.0196722369F * x425 -
               x6 * (-wL[97] + wR[97]);
    flux[98] = -vn[0] * x365 - vn[1] * x358 + x221 * x287 + x351 * x367 +
               0.030656967F * x418 - 0.229415734F * x419 - 0.030656967F * x420 +
               0.229415734F * x421 - x6 * (-wL[98] + wR[98]);
    flux[99] = -vn[0] * x354 - vn[1] * x347 + x357 * x364 +
               0.0176998081F * x422 - 0.243332132F * x423 -
               0.0176998081F * x424 + 0.243332132F * x425 -
               x6 * (-wL[99] + wR[99]);
    flux[100] = -vn[0] * x426 + vn[1] * x432 + 0.0160872363F * x428 -
                0.243975018F * x429 + 0.0160872363F * x431 -
                0.243975018F * x433 + x434 * x435 - x6 * (-wL[100] + wR[100]);
    flux[101] = -vn[0] * x436 + vn[1] * x443 + x277 * x357 + x427 * x445 +
                0.0278639106F * x438 - 0.231455025F * x439 +
                0.0278639106F * x441 - 0.231455025F * x444 -
                x6 * (-wL[101] + wR[101]);
    flux[102] = -0.218934535F * x280 - 0.218934535F * x283 + x286 * x367 -
                0.221747249F * x428 + 0.0176998081F * x429 +
                0.221747249F * x431 - 0.0176998081F * x433 + x437 * x450 +
                0.0394055203F * x447 + 0.0394055203F * x449 -
                x6 * (-wL[102] + wR[102]);
    flux[103] = x279 * x372 - 0.20641346F * x291 - 0.20641346F * x294 -
                0.210367912F * x438 + 0.030656967F * x439 +
                0.210367912F * x441 - 0.030656967F * x444 + x446 * x455 +
                0.050872308F * x452 + 0.050872308F * x454 -
                x6 * (-wL[103] + wR[103]);
    flux[104] = 0.0433554985F * x280 - 0.0433554985F * x283 + x290 * x377 -
                0.193891684F * x299 - 0.193891684F * x301 -
                0.198988124F * x447 + 0.198988124F * x449 + x451 * x460 +
                0.0623055983F * x457 + 0.0623055983F * x459 -
                x6 * (-wL[104] + wR[104]);
    flux[105] = 0.0559717079F * x291 - 0.0559717079F * x294 + x298 * x382 -
                0.181369063F * x304 - 0.181369063F * x306 -
                0.187607802F * x452 + 0.187607802F * x454 + x456 * x465 +
                0.0737209781F * x462 + 0.0737209781F * x464 -
                x6 * (-wL[105] + wR[105]);
    flux[106] = 0.0685510621F * x299 - 0.0685510621F * x301 + x303 * x387 -
                0.168845408F * x310 - 0.168845408F * x312 -
                0.176226844F * x457 + 0.176226844F * x459 + x461 * x470 +
                0.0851256531F * x467 + 0.0851256531F * x469 -
                x6 * (-wL[106] + wR[106]);
    flux[107] = 0.0811107106F * x304 - 0.0811107106F * x306 + x309 * x392 -
                0.156320473F * x315 - 0.156320473F * x317 -
                0.164845118F * x462 + 0.164845118F * x464 + x466 * x475 +
                0.0965234178F * x472 + 0.0965234178F * x474 -
                x6 * (-wL[107] + wR[107]);
    flux[108] = -vn[0] * x478 - vn[1] * x481 + 0.0936585812F * x310 -
                0.0936585812F * x312 + x314 * x399 - 0.153462454F * x467 +
                0.153462454F * x469 + x471 * x482 + x476 * x477 + x479 * x480 -
                x6 * (-wL[108] + wR[108]);
    flux[109] = vn[1] * x484 + 0.106198849F * x315 - 0.106198849F * x317 +
                x320 * x402 - x326 * x404 - 0.142078624F * x472 +
                0.142078624F * x474 + x476 * x485 - x6 * (-wL[109] + wR[109]);
    flux[110] = 0.167915124F * vn[0] * x323 + 0.167915124F * vn[1] * x320 +
                x326 * x405 - x476 * x487 - x479 * x486 + x483 * x488 -
                x6 * (-wL[110] + wR[110]);
    flux[111] = vn[0] * x484 + x323 * x402 - x326 * x403 + 0.106198849F * x332 +
                0.106198849F * x333 + x479 * x485 - 0.142078624F * x489 -
                0.142078624F * x490 - x6 * (-wL[111] + wR[111]);
    flux[112] = -vn[0] * x481 + vn[1] * x478 + x316 * x399 +
                0.0936585812F * x334 + 0.0936585812F * x335 + x473 * x482 -
                x476 * x480 + x477 * x479 - 0.153462454F * x491 -
                0.153462454F * x492 - x6 * (-wL[112] + wR[112]);
    flux[113] = x311 * x392 - 0.156320473F * x332 + 0.156320473F * x333 +
                0.0811107106F * x336 + 0.0811107106F * x337 + x468 * x475 +
                0.0965234178F * x489 - 0.0965234178F * x490 -
                0.164845118F * x493 - 0.164845118F * x494 -
                x6 * (-wL[113] + wR[113]);
    flux[114] = x305 * x387 - 0.168845408F * x334 + 0.168845408F * x335 +
                0.0685510621F * x338 + 0.0685510621F * x339 + x463 * x470 +
                0.0851256531F * x491 - 0.0851256531F * x492 -
                0.176226844F * x495 - 0.176226844F * x496 -
                x6 * (-wL[114] + wR[114]);
    flux[115] = x300 * x382 - 0.181369063F * x336 + 0.181369063F * x337 +
                0.0559717079F * x340 + 0.0559717079F * x341 + x458 * x465 +
                0.0737209781F * x493 - 0.0737209781F * x494 -
                0.187607802F * x497 - 0.187607802F * x498 -
                x6 * (-wL[115] + wR[115]);
    flux[116] = x293 * x377 - 0.193891684F * x338 + 0.193891684F * x339 +
                0.0433554985F * x343 + 0.0433554985F * x345 + x453 * x460 +
                0.0623055983F * x495 - 0.0623055983F * x496 -
                0.198988124F * x499 - 0.198988124F * x500 -
                x6 * (-wL[116] + wR[116]);
    flux[117] = x282 * x372 - 0.20641346F * x340 + 0.20641346F * x341 +
                x448 * x455 + 0.050872308F * x497 - 0.050872308F * x498 -
                0.210367912F * x501 + 0.030656967F * x502 -
                0.210367912F * x503 + 0.030656967F * x504 -
                x6 * (-wL[117] + wR[117]);
    flux[118] = x295 * x367 - 0.218934535F * x343 + 0.218934535F * x345 +
                x440 * x450 + 0.0394055203F * x499 - 0.0394055203F * x500 -
                0.221747249F * x505 + 0.0176998081F * x506 -
                0.221747249F * x507 + 0.0176998081F * x508 -
                x6 * (-wL[118] + wR[118]);
    flux[119] = -vn[0] * x443 - vn[1] * x436 + x284 * x357 + x430 * x445 +
                0.0278639106F * x501 - 0.231455025F * x502 -
                0.0278639106F * x503 + 0.231455025F * x504 -
                x6 * (-wL[119] + wR[119]);
    flux[120] = -vn[0] * x432 - vn[1] * x426 + x435 * x442 +
                0.0160872363F * x505 - 0.243975018F * x506 -
                0.0160872363F * x507 + 0.243975018F * x508 -
                x6 * (-wL[120] + wR[120]);
    flux[121] =
        -0.244504823F * x509 - 0.244504823F * x510 - x6 * (-wL[121] + wR[121]);
    flux[122] = x346 * x435 - 0.233126202F * x511 - 0.233126202F * x512 -
                x6 * (-wL[122] + wR[122]);
    flux[123] = -0.221747249F * x349 - 0.221747249F * x352 + x356 * x445 +
                0.0160872363F * x509 - 0.0160872363F * x510 -
                x6 * (-wL[123] + wR[123]);
    flux[124] = x348 * x450 - 0.210367912F * x360 - 0.210367912F * x363 +
                0.0278639106F * x511 - 0.0278639106F * x512 -
                x6 * (-wL[124] + wR[124]);
    flux[125] = 0.0394055203F * x349 - 0.0394055203F * x352 + x359 * x455 -
                0.198988124F * x369 - 0.198988124F * x371 -
                x6 * (-wL[125] + wR[125]);
    flux[126] = 0.050872308F * x360 - 0.050872308F * x363 + x368 * x460 -
                0.187607802F * x374 - 0.187607802F * x376 -
                x6 * (-wL[126] + wR[126]);
    flux[127] = 0.0623055983F * x369 - 0.0623055983F * x371 + x373 * x465 -
                0.176226844F * x379 - 0.176226844F * x381 -
                x6 * (-wL[127] + wR[127]);
    flux[128] = 0.0737209781F * x374 - 0.0737209781F * x376 + x378 * x470 -
                0.164845118F * x384 - 0.164845118F * x386 -
                x6 * (-wL[128] + wR[128]);
    flux[129] = 0.0851256531F * x379 - 0.0851256531F * x381 + x383 * x475 -
                0.153462454F * x389 - 0.153462454F * x391 -
                x6 * (-wL[129] + wR[129]);
    flux[130] = -vn[0] * x513 - vn[1] * x514 + 0.0965234178F * x384 -
                0.0965234178F * x386 + x388 * x482 - x6 * (-wL[130] + wR[130]);
    flux[131] = 0.107916462F * x389 - 0.107916462F * x391 + x393 * x485 -
                x400 * x487 - x6 * (-wL[131] + wR[131]);
    flux[132] = 0.168724358F * vn[0] * x396 + 0.168724358F * vn[1] * x393 +
                x400 * x488 - x6 * (-wL[132] + wR[132]);
    flux[133] = x396 * x485 - x400 * x486 + 0.107916462F * x406 +
                0.107916462F * x407 - x6 * (-wL[133] + wR[133]);
    flux[134] = -vn[0] * x514 + vn[1] * x513 + x390 * x482 +
                0.0965234178F * x408 + 0.0965234178F * x409 -
                x6 * (-wL[134] + wR[134]);
    flux[135] = x385 * x475 - 0.153462454F * x406 + 0.153462454F * x407 +
                0.0851256531F * x410 + 0.0851256531F * x411 -
                x6 * (-wL[135] + wR[135]);
    flux[136] = x380 * x470 - 0.164845118F * x408 + 0.164845118F * x409 +
                0.0737209781F * x412 + 0.0737209781F * x414 -
                x6 * (-wL[136] + wR[136]);
    flux[137] = x375 * x465 - 0.176226844F * x410 + 0.176226844F * x411 +
                0.0623055983F * x416 + 0.0623055983F * x417 -
                x6 * (-wL[137] + wR[137]);
    flux[138] = x370 * x460 - 0.187607802F * x412 + 0.187607802F * x414 +
                0.050872308F * x418 + 0.050872308F * x420 -
                x6 * (-wL[138] + wR[138]);
    flux[139] = x362 * x455 - 0.198988124F * x416 + 0.198988124F * x417 +
                0.0394055203F * x422 + 0.0394055203F * x424 -
                x6 * (-wL[139] + wR[139]);
    flux[140] = x351 * x450 - 0.210367912F * x418 + 0.210367912F * x420 +
                0.0278639106F * x515 + 0.0278639106F * x516 -
                x6 * (-wL[140] + wR[140]);
    flux[141] = x364 * x445 - 0.221747249F * x422 + 0.221747249F * x424 +
                0.0160872363F * x517 + 0.0160872363F * x518 -
                x6 * (-wL[141] + wR[141]);
    flux[142] = x353 * x435 - 0.233126202F * x515 + 0.233126202F * x516 -
                x6 * (-wL[142] + wR[142]);
    flux[143] =
        -0.244504823F * x517 + 0.244504823F * x518 - x6 * (-wL[143] + wR[143]);
}

#endif

#endif
#endif
