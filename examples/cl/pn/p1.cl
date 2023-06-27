#ifndef P1_CL
#define P1_CL

#ifdef IS_2D
/* P1 2D MODEL :
 *
 * Type 2 filter lookup datas :
 * - fpn_type_2_filter_den          = N / (N + 1),
 * - fpn_type_2_filter_num_tab[iw]  = l[iw] / (N + 1),
 * 
 * with l[iw] the associated Pn degree 'l' for a given conservative 
 * variable 'iw'.
 */
#ifdef USE_FPN_TYPE_2
__constant const float fpn_type_2_filter_den = 0.500000000f;
__constant const float fpn_type_2_filter_num_tab[3] = { 0.000000000f,
                                                        0.500000000f,
                                                        0.500000000f };
#endif

void pn_num_flux_rusanov(const float wL[4], const float wR[4],
                         const float vn[3], float flux[4])
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

#else
/* P1 3D MODEL :
 *
 * Type 2 filter lookup datas :
 * - fpn_type_2_filter_den          = N / (N + 1),
 * - fpn_type_2_filter_num_tab[iw]  = l[iw] / (N + 1),
 * 
 * with l[iw] the associated Pn degree 'l' for a given conservative 
 * variable 'iw'.
 */
#ifdef USE_FPN_TYPE_2
__constant const float fpn_type_2_filter_den = 0.500000000f;
__constant const float fpn_type_2_filter_num_tab[4] = {
    0.000000000f, 0.500000000f, 0.500000000f, 0.500000000f
};
#endif
void pn_num_flux_rusanov(const float wL[4], const float wR[4],
                         const float vn[3], float flux[4])
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