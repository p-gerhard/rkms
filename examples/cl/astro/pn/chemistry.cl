#ifndef _CHEMISTRY_CL
#define _CHEMISTRY_CL

#pragma OPENCL EXTENSION cl_khr_fp64 : enable

// Speed of light in vaccum
#define C_LIGHT_VACCUM 299792458.

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

// Case A - Recombination rate in cm^{3}.s^{-1} (Hui & Gnedin 1997)
double alpha_ah(const double T)
{
    double lambda = 2.0 * 157807.0 / T;
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
    double lambda = 2.0 * 157807.0 / T;
    double res = 1.778e-29 * pow(lambda, 1.965);
    res /= pow(1.0 + pow(lambda / 0.541, 0.502), 2.697);

    // Convert to erg.m^{3}.s^{-1}
    res *= 1e-6;

    // Convert to J.m^{3}.s^{-1}
    res *= 1e-7;
    return res;
}

// Case B - Recombination rate from in cm^{3}.s^{-1} (Hui & Gnedin 1997)
double alpha_bh(const double T)
{
    double lambda = 2.0 * 157807.0 / T;
    double res = 2.753e-14;
    res *= pow(lambda, 1.5);
    res /= pow(1.0 + pow(lambda / 2.74, 0.407), 2.242);

    // Convert to m^{3}.s^{-1}
    res *= 1e-6;
    return res;
}

// HI collisional ionisation coefficient in cm^{3}.s^{-1}.K^{3/2} (Hui & Gnedin
// 1997)
double beta_h(const double T)
{
    double lambda = 2.0 * 157807.0 / T;
    double res =
        21.11 * pow(T, -1.5) * exp(-lambda / 2.0) * pow(lambda, -1.089);
    res /= pow(1.0 + pow(lambda / 0.354, 0.874), 1.01);

    // Convert to m^{3}.s^{-1}
    res *= 1e-6;
    return res;
}

// Collisional ionisation cooling in erg.cm^{3}.s^{-1} (Maselli et al. 2003)
double ksi_h0(const double T)
{
    double res = 1.27e-21 * sqrt(T) / (1.0 + sqrt(T / 1.e5));
    res *= exp(-157809.1 / T);

    // Convert to erg.m^{3}.s^{-1}
    res *= 1e-6;

    // Convert to J.m^{3}.s^{-1}
    res *= 1e-7;
    return res;
}

// Recombination cooling for H0 in erg.cm^{3}.s^{-1} (Maselli et al. 2003)
// Case A or B or total ?
double eta_h0(const double T)
{
    double res =
        8.7e-27 * sqrt(T) * pow(T / 1.e3, -0.2) / (1.0 + pow(T / 1.e6, 0.7));

    // Convert to erg.m^{3}.s^{-1}
    res *= 1e-6;

    // Convert to J.m^{3}.s^{-1}
    res *= 1e-7;
    return res;
}

// Collisional exciation cooling for H0 in erg.cm^{3}.s^{-1} (Maselli et al.
// 2003)
double psi_h0(const double T)
{
    double res = 7.5e-19 / (1.0 + sqrt(T / 1.e5));
    res *= exp(-118348.0 / T);

    // Convert to erg.m^{3}.s^{-1}
    res *= 1e-6;

    // Convert to J.m^{3}.s^{-1}
    res *= 1e-7;
    return res;
}

// Bremsstrahlung cooling in erg.cm^{3}.s^{-1} (Maselli et al. 2003) WARNING: we
// took the densities out of the formula so one needs to multiply the result by
// rho_electrons^2 (in case of pure Hydrogen chemistry)
double beta_bremsstrahlung(const double T)
{
    double res = 1.42e-27 * sqrt(T);
    // Convert to erg.m^{3}.s^{-1}
    res *= 1e-6;

    // Convert to J.m^{3}.s^{-1}
    res *= 1e-7;
    return res;
}

// Total cooling rate (sum of terms below) in erg.cm^{3}.s^{-1}
double cooling_rate(const double T, const double x)
{
    const double t0 = x * x;
    const double t1 = 1.0 - x;
    const double t2 = t1 * t1;
    double res = (beta_bremsstrahlung(T) + eta_h0(T)) * t0 +
                 (psi_h0(T) + ksi_h0(T)) * t2;
    return res;
}

double cooling_rate_density(const double T, const double rho, const double x_n)
{
    const double t0 = rho * x_n;
    const double t1 = t0 * t0;
    const double t2 = t0 * rho - t1;

    return (beta_bremsstrahlung(T) + eta_h0(T)) * t1 +
           (psi_h0(T) + ksi_h0(T)) * t2;
}

double heating_rate(const double rho, const double x, const double x_n,
                    const double N, const double al_i)
{
    const double e = (20.28 - 13.6) * 1.60218e-19;
    // Short time step
    return rho * (1 - x_n) * N * al_i * e * C_LIGHT_VACCUM;
}

// TODO: FUNCTION IS NOT SAFE !!!!!!!!!
double get_root_newton_raphson(const double a, const double b, const double c,
                               const double d)
{
    const double eps = 1e-6;

    double x = 0.5;
    double res = 1.0;

    double f, df, t2, t3;

    while (fabs(res) >= eps) {
        // Intermediate variables
        t2 = x * x;
        t3 = x * x * x;

        // Polynomial and derivative evaluation
        f = a * t3 + b * t2 + c * x + d;
        df = 3 * a * t2 + 2 * b * x + c;

        x -= f / df;
    }

    return x;
}

__kernel void chem_init_sol(__global float *nh, __global float *temp,
                            __global float *xi)
{
    // Current cell ID
    const long id = get_global_id(0);

    xi[id] = 1e-4;
    nh[id] = 1e6;
    temp[id] = 2e3;
}

__kernel void chem_step(__global const float *nh, __global float *wn,
                        __global float *temp, __global float *xi)
{
    // Current cell ID
    const long id = get_global_id(0);

    // Photon density
    const float N = wn[id];
    const float N_pos = max(0, wn[id]);

    const float x = xi[id];
    const float T = temp[id];
    const float rho = nh[id];

    // Chemistry coefficients
    //const float al_i = 1.09e-18*c;
    const float al_i = 2.493e-22;
    const float al = alpha_ah(T);
    const float al_b = alpha_bh(T);
    const float bt = beta_h(T);

    // Intermediate vars
    const float t0 = rho * rho;
    const float t1 = t0 * DT;
    const float t2 = al_i * C_LIGHT_VACCUM;
    const float t3 = rho / t2;
    const float t4 = 1. / (t2 * DT);

    // Compute new x (x_n)
    const float m = (al_b + bt) * t1;
    const float n = rho - (al + bt) * t3 - (al_b + 2. * bt) * t1;
    const float p = -rho * (1. + x) - N_pos - t4 + bt * (t3 + t1);
    const float q = N_pos + x * (rho + t4);

    float x_n = get_root_newton_raphson(m, n, p, q);

    // Compute new T (T_n)
    const float kB = 1.380649e-23;
    const float L = cooling_rate_density(T, rho, x_n);
    const float H = heating_rate(rho, x, x_n, N_pos, al_i);

    const float coef = 2. * (H - L) * DT / (3. * rho * (1. + x_n) * kB);
    float T_n = (coef + T) / (1. + x_n - x);
    T_n = max(T_n, 10.);

    // Compute new N (N_n)
    const float t5 = x_n * x_n;
    const float c1 = bt * t1 * (x_n - t5);
    const float c2 = -al_b * t1 * t5;
    const float N_n = N + c1 + c2 + -rho * (x_n - x);

    // Update moments global buffer
    // const float ratio = N_n / N;
    const float ratio = 0.95;
    // wn[id] = 0.95 * wn[id];
    // wn[id] = N_n;
    for (int k = 1; k < M; k++) {
        long imem = id + k * NGRID;
        wn[imem] = wn[imem] * ratio;
    }

    // Update x global buffer
    xi[id] = x_n;

    // Update temperature global buffer
    temp[id] = T_n;
}

#endif