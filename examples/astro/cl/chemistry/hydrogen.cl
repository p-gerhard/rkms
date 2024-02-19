#ifndef _CHEMISTRY_CL
#define _CHEMISTRY_CL

// Physical constantes (dim) (double)
#define PHY_CST_KB      (1.380649e-23)
#define PHY_CST_ALPHA_I (2.493e-22)

// Newton convergence criterion
#define NEWTON_EPS      (1e-8)

// Collisional ionisation rate in cm^{3}.s^{-1} (Maselli et al. 2003)
double gamma_h0(const double T)
{
    double res = 5.85e-11;
    res *= sqrt(T);
    res *= 1.0 / (1.0 + sqrt(T / 1.e5));
    res *= exp(-157809.1 / T);

    // Convert to m^{3}.s^{-1}
    res *= 1e-6;
    return res;
}

// @TODO finish
// double get_al_alb_bt(const double T)
// {
//     const double lambda = 2.0 * 157807.0 / T;
//     double alpha_ah = 1.269e-13;
//     alpha_ah *= pow(lambda, 1.503);
//     alpha_ah /= pow(1.0 + pow(lambda / 0.522, 0.47), 1.923);

//     // Convert to m^{3}.s^{-1}
//     alpha_ah *= 1e-6;

//     double alpha_bh = 2.753e-14;
//     alpha_bh *= pow(lambda, 1.5);
//     alpha_bh /= pow(1.0 + pow(lambda / 2.74, 0.407), 2.242);

//     // Convert to m^{3}.s^{-1}
//     alpha_bh *= 1e-6;
//     alpha_bh;

//     double beta_h =
//         21.11 * pow(T, -3.0 / 2.0) * exp(-lambda / 2.0) * pow(lambda, -1.089);
//     beta_h /= pow(1.0 + pow(lambda / 0.354, 0.874), 1.01);

//     // Convert to m^{3}.s^{-1}
//     beta_h *= 1e-6;

// }

// Case A - Recombination rate in cm^{3}.s^{-1} (Hui & Gnedin 1997)
double alpha_ah(const double T)
{
    const double lambda = 2.0 * 157807.0 / T;
    double res = 1.269e-13;
    res *= pow(lambda, 1.503);
    res /= pow(1.0 + pow(lambda / 0.522, 0.47), 1.923);

    // Convert to m^{3}.s^{-1}
    res *= 1e-6;
    return res;
}

// Case A - HII recombination cooling rate in erg.cm^{3}.s^{-1} (Hui & Gnedin
// 1997)
double recombination_cooling_rate_ah(const double T)
{
    const double lambda = 2.0 * 157807.0 / T;
    double res = 1.778e-29 * pow(lambda, 1.965);
    res /= pow(1.0 + pow(lambda / 0.541, 0.502), 2.697);

    // Convert to J.m^{3}.s^{-1}
    res *= 1e-13;
    return res;
}

// Case B - Recombination rate from in cm^{3}.s^{-1} (Hui & Gnedin 1997)
double alpha_bh(const double T)
{
    const double lambda = 2.0 * 157807.0 / T;
    double res = 2.753e-14;

    res *= lambda * lambda / sqrt(lambda);

    // @NON-OPTIMIZED
    // res *= pow(lambda, 1.5);
    res /= pow(1.0 + pow(lambda / 2.74, 0.407), 2.242);

    // Convert to m^{3}.s^{-1}
    res *= 1e-6;
    return res;
}

// HI collisional ionisation coefficient in cm^{3}.s^{-1}.K^{3/2} (Hui & Gnedin
// 1997)
double beta_h(const double T)
{
    const double lambda = 2.0 * 157807.0 / T;
    double res =
        21.11 * sqrt(T) / (T * T) * exp(-0.5 * lambda) * pow(lambda, -1.089);

    // @NON-OPTIMIZED
    // double res =
    //     21.11 * pow(T, -3.0 / 2.0) * exp(-lambda / 2.0) * pow(lambda, -1.089);
    res /= pow(1.0 + pow(lambda / 0.354, 0.874), 1.01);

    // Convert to m^{3}.s^{-1}
    res *= 1e-6;
    return res;
}

// Collisional ionisation cooling in erg.cm^{3}.s^{-1} (Maselli et al. 2003)
double ksi_h0(const double T)
{
    const double t0 = sqrt(T);
    // t1 = 1 / sqrt(1e5)
    const double t1 = 0.0031622776601683;
    double res = 1.27e-21 * t0 / (1.0 + t0 * t1);

    // @NON-OPTIMIZED
    // double res = 1.27e-21 * sqrt(T) / (1.0 + pow(T / 1.e5, 0.5));

    res *= exp(-157809.1 / T);

    // Convert to J.m^{3}.s^{-1}
    res *= 1e-13;
    return res;
}

// Recombination cooling for H0 in erg.cm^{3}.s^{-1} (Maselli et al. 2003)
// Case A or B or total ?
double eta_h0(const double T)
{
    double res =
        8.7e-27 * sqrt(T) * pow(T / 1.e3, -0.2) / (1.0 + pow(T / 1.e6, 0.7));

    // Convert to J.m^{3}.s^{-1}
    res *= 1e-13;
    return res;
}

// Collisional exciation cooling for H0 in erg.cm^{3}.s^{-1} (Maselli et al.
// 2003)
double psi_h0(const double T)
{
    const double t0 = 0.0031622776601683;
    double res = 7.5e-19 / (1.0 + t0 * sqrt(T));

    // @NON-OPTIMIZED
    // double res = 7.5e-19 / (1.0 + pow(T / 1.e5, 0.5));

    res *= exp(-118348.0 / T);

    // Convert to J.m^{3}.s^{-1}
    res *= 1e-13;
    return res;
}

// Bremsstrahlung cooling in erg.cm^{3}.s^{-1} (Maselli et al. 2003) WARNING: we
// took the densities out of the formula so one needs to multiply the result by
// rho_electrons^2 (in case of pure Hydrogen chemistry)
double beta_bremsstrahlung(const double T)
{
    // Convert to J.m^{3}.s^{-1} using * 1e-13
    return 1.42e-40 * sqrt(T);
}

// Total cooling rate (sum of terms below) in erg.cm^{3}.s^{-1}
double cooling_rate(const double T, const double x)
{
    const double t0 = x * x;
    const double t1 = 1.0 - x;
    const double t2 = t1 * t1;
    return (beta_bremsstrahlung(T) + eta_h0(T)) * t0 +
           (psi_h0(T) + ksi_h0(T)) * t2;

    // @NON-OPTIMIZED
    // return beta_bremsstrahlung(T) * x * x + psi_h0(T) * (1.0 - x) * (1.0 - x) +
    //        ksi_h0(T) * (1.0 - x) * (1.0 - x) + eta_h0(T) * x * x;
}

double cooling_rate_density(const double T, const double nH, const double x_n)
{
    const double t0 = nH * x_n;
    const double t1 = t0 * t0;
    const double t2 = t0 * nH - t1;

    return (beta_bremsstrahlung(T) + eta_h0(T)) * t1 +
           (psi_h0(T) + ksi_h0(T)) * t2;

    // @NON-OPTIMIZED
    // return beta_bremsstrahlung(T) * (nH * x_n) * (nH * x_n) +
    //        psi_h0(T) * (nH * x_n) * (nH * (1. - x_n)) +
    //        ksi_h0(T) * (nH * x_n) * (nH * (1. - x_n)) +
    //        eta_h0(T) * (nH * x_n) * (nH * x_n);
}

double heating_rate(const double nH, const double x, const double x_n,
                    const double N, const double al_i)
{
    const double e = (20.28 - 13.6) * 1.60218e-19;
    // Short time step
    return nH * (1. - x_n) * N * al_i * e * PHY_C_DIM;
}

// TODO: FUNCTION IS NOT SAFE !!!!!!!!!
double get_root_newton_raphson(const double a, const double b, const double c,
                               const double d, const double guess)
{
    double x = guess;
    double f = HUGE_VAL;
    double df, t2, t3;

    while (fabs(f) >= NEWTON_EPS) {
        // Intermediate variables
        t2 = x * x;
        t3 = x * t2;

        // Polynomial and derivative evaluation
        f = a * t3 + b * t2 + c * x + d;
        df = 3. * a * t2 + 2. * b * x + c;

        x -= f / df;
    }
    return x;
}

__kernel void chem_init_sol(__global real_t *nh, __global real_t *temp,
                            __global real_t *xi)
{
    // Current cell ID
    const long id = get_global_id(0);


    // Stromgren sphere test case values
    xi[id] = (real_t)1.2e-3;
        
    temp[id] = (real_t)100.;
    
    // TO COMMENT IF MAP IS LOADED
    nh[id] = (real_t)1e3;

}

__kernel void chem_step(__global const real_t *nh, __global real_t *wn,
                        __global real_t *temp, __global real_t *xi)
{
    // Current cell ID
    const long id = get_global_id(0);

    // Use PHY_W0_DIM to give physical dimension
    const double N = (double)(wn[id] * PHY_W0_DIM);
    const double N_pos = max(0., N);

    const double x = (double)xi[id];
    const double T = (double)temp[id];
    const double nH = (double)nh[id];

    // Chemistry coefficients
    const double al = alpha_ah(T);
    const double al_b = alpha_bh(T);
    const double bt = beta_h(T);

    // Intermediate vars
    const double t0 = nH * nH;
    const double t1 = t0 * PHY_DT_DIM;
    const double t2 = PHY_CST_ALPHA_I * PHY_C_DIM;
    const double t3 = nH / t2;
    const double t4 = 1. / (t2 * PHY_DT_DIM);

    // Compute x
    const double m = (al_b + bt) * t1;
    const double n = nH - (al + bt) * t3 - (al_b + 2. * bt) * t1;
    const double p = -nH * (1. + x) - N_pos - t4 + bt * (t3 + t1);
    const double q = N_pos + x * (nH + t4);
    const double x_n = get_root_newton_raphson(m, n, p, q, x);

    // Compute N
    const double t5 = x_n * x_n;
    const double c1 = bt * t1 * (x_n - t5);
    const double c2 = -al_b * t1 * t5;
    const double N_n = N + c1 + c2 + -nH * (x_n - x);

    // Compute T
    const double L = cooling_rate_density(T, nH, x_n);
    const double H = heating_rate(nH, x, x_n, N_pos, PHY_CST_ALPHA_I);
    const double coef =
        2. * (H - L) * PHY_DT_DIM / (3. * nH * (1. + x_n) * PHY_CST_KB);
    const double T_n = max((coef + T) / (1. + x_n - x), 10.);

    // Update N (moment 0)
    // Use PHY_W0_DIM to remove physical dimension
#ifdef USE_DOUBLE
    wn[id] = max(DBL_EPSILON, N_n / PHY_W0_DIM);
#else
    wn[id] = max(FLT_EPSILON, (float)(N_n) / PHY_W0_DIM);
#endif

    // Update moments > 0
    const real_t ratio = (real_t)(N_n / N);
    for (int k = 1; k < M; k++) {
        long imem = id + k * NGRID;
        wn[imem] = wn[imem] * ratio;
    }

    // Update x
    xi[id] = (real_t)x_n;

    // Update T
    temp[id] = (real_t)T_n;
}
#endif
