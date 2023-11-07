#ifndef _CHEMISTRY_CL
#define _CHEMISTRY_CL

#pragma OPENCL EXTENSION cl_khr_fp64 : enable

// Light Speed
#define LIGHT_SPEED 299792458.F

typedef double real_t;

real_t gamma_h0(const real_t T)
{
    real_t res = 5.85e-11F;
    res *= sqrt(T);
    res *= 1.0F / (1.0F + sqrt(T / 1.e5F));
    res *= exp(-157809.1F / T);
    res *= 1e-6F; // to cube meter
    return res;
}

real_t gamma_h0_opt(const real_t T)
{
    real_t t0 = -37.37750491965501150289710039036636229079507786927246280283;
    real_t t1 = 0.0031622776601683793319988935444327185337195551393252168268;
    real_t t2 = t1 + rsqrt(T);
    real_t t3 = exp(t0 - 157809.1 / T);

    return t3 / t2;
}

real_t alpha_ah(const real_t T)
{
    real_t lambda = 2.0 * 157807.0 / T;
    real_t res = 1.269e-13;
    res *= pow(lambda, 1.503);
    res /= pow(1.0 + pow(lambda / 0.522, 0.47), 1.923);
    res *= 1e-6F; // to cube meter
    return res;
}

real_t recombination_cooling_rate_ah(const real_t T)
{
    real_t lambda = 2.0 * 157807.0 / T;
    real_t res = 1.778e-29 * pow(lambda, 1.965);
    res /= pow(1.0 + pow(lambda / 0.541, 0.502), 2.697);
    res *= 1e-6; // to cube meter
    res *= 1e-7; // to cube joule
    return res;
}

real_t alpha_bh(const real_t T)
{
    real_t lambda = 2.0 * 157807.0 / T;
    real_t res = 2.753e-14;
    res *= pow(lambda, 1.5);
    res /= pow(1.0 + pow(lambda / 2.74, 0.407), 2.242);
    res *= 1e-6F; // to cube meter
    return res;
}

real_t beta_h(const real_t T)
{
    real_t lambda = 2.0 * 157807.0 / T;
    real_t res =
        21.11 * pow(T, -1.5) * exp(-lambda / 2.0) * pow(lambda, -1.089);
    res /= pow(1.0 + pow(lambda / 0.354, 0.874), 1.01);
    res *= 1e-6; // to cube meter
    return res;
}

// Collisional ionisation cooling
real_t ksi_h0(const real_t T)
{
    real_t res = 1.27e-21 * sqrt(T) / (1.0 + sqrt(T / 1.e5));
    res *= exp(-157809.1 / T);
    res *= 1e-6; // to cube meter
    res *= 1e-7; // to cube joule
    return res;
}

// Recombination cooling
real_t eta_h0(const real_t T)
{
    real_t res =
        8.7e-27 * sqrt(T) * pow(T / 1.e3, -0.2) / (1.0 + pow(T / 1.e6, 0.7));
    res *= 1e-6; // to cube meter
    res *= 1e-7; // to cube joule
    return res;
}

// Collisional excitation cooling
real_t psi_h0(const real_t T)
{
    real_t res = 7.5e-19 / (1.0 + sqrt(T / 1.e5));
    res *= exp(-118348.0 / T);
    res *= 1e-6; // to cube meter
    res *= 1e-7; // to cube joule
    return res;
}

real_t beta_bremsstrahlung(const real_t T)
{
    real_t res = 1.42e-27 * sqrt(T);
    res *= 1e-6; // to cube meter
    res *= 1e-7; // to cube joule
    return res;
}

// Gives result in erg cm^3 s⁻1
// Multiply by rho^2

real_t cooling_rate(const real_t T, const real_t x)
{
    const real_t t0 = x * x;
    const real_t t1 = 1.0 - x;
    const real_t t2 = t1 * t1;
    real_t res = (beta_bremsstrahlung(T) + eta_h0(T)) * t0 +
                 (psi_h0(T) + ksi_h0(T)) * t2;
    return res;
}

real_t cooling_rate_density(const real_t T, const real_t rho, const real_t x_n)
{
    const real_t t0 = rho * x_n;
    const real_t t1 = t0 * t0;
    const real_t t2 = t0 * rho - t1;

    return (beta_bremsstrahlung(T) + eta_h0(T)) * t1 +
           (psi_h0(T) + ksi_h0(T)) * t2;
}

real_t heating_rate(const real_t rho, const real_t x, const real_t x_n,
                    const real_t N, const real_t al_i)
{
    const real_t e = (20.28 - 13.6) * 1.60218e-19;
    // Short time step
    return rho * (1 - x_n) * N * al_i * e * LIGHT_SPEED;
}

// TODO: FUNCTION IS NOT SAFE !!!!!!!!!
real_t get_root_newton_raphson(const real_t a, const real_t b, const real_t c,
                               const real_t d)
{
    const real_t eps = 1e-6;

    real_t x = 0.5;
    real_t res = 1.0;

    real_t f, df, t2, t3;

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

    xi[id] = 1e-4F;
    nh[id] = 1e6F;
    temp[id] = 2e3F;
}

__kernel void chem_step(__global const float *nh, __global float *wn,
                        __global float *temp, __global float *xi)
{
    // Current cell ID
    const long id = get_global_id(0);

    // Photon density
    const float N = wn[id];
    const float N_pos = max(0.F, wn[id]);

    const float x = xi[id];
    const float T = temp[id];
    const float rho = nh[id];

    // Chemistry coefficients
    //const float al_i = 1.09e-18*c;
    const float al_i = 2.493e-22F;
    const float al = alpha_ah(T);
    const float al_b = alpha_bh(T);
    const float bt = beta_h(T);

    // Intermediate vars
    const float t0 = rho * rho;
    const float t1 = t0 * DT;
    const float t2 = al_i * LIGHT_SPEED;
    const float t3 = rho / t2;
    const float t4 = 1.F / (t2 * DT);

    // Compute new x (x_n)
    const float m = (al_b + bt) * t1;
    const float n = rho - (al + bt) * t3 - (al_b + 2.F * bt) * t1;
    const float p = -rho * (1.F + x) - N_pos - t4 + bt * (t3 + t1);
    const float q = N_pos + x * (rho + t4);

    float x_n = get_root_newton_raphson(m, n, p, q);

    // Compute new T (T_n)
    const float kB = 1.380649e-23;
    const float L = cooling_rate_density(T, rho, x_n);
    const float H = heating_rate(rho, x, x_n, N_pos, al_i);

    const float coef = 2.F * (H - L) * DT / (3.F * rho * (1.F + x_n) * kB);
    float T_n = (coef + T) / (1 + x_n - x);
    T_n = max(T_n, 10.F);

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