#ifndef _CHEMISTRY_CL
#define _CHEMISTRY_CL

// Light Speed
#define LIGHT_SPEED 299792458.F

float gamma_h0(const float T)
{
    float res = 5.85e-11F;
    res *= sqrt(T);
    res *= 1.0F / (1.0F + sqrt(T / 1.e5F));
    res *= exp(-157809.1F / T);
    res *= 1e-6F; // to cube meter
    return res;
}

float alpha_ah(const float T)
{
    float lambda = 2.0F * 157807.0F / T;
    float res = 1.269e-13F;
    res *= pow(lambda, 1.503F);
    res /= pow(1.0F + pow(lambda / 0.522F, 0.47F), 1.923F);
    res *= 1e-6F; // to cube meter
    return res;
}

float recombination_cooling_rate_ah(const float T)
{
    float lambda = 2.0F * 157807.0F / T;
    float res = 1.778e-29F * pow(lambda, 1.965F);
    res /= pow(1.0F + pow(lambda / 0.541F, 0.502F), 2.697F);
    res *= 1e-6F; // to cube meter
    res *= 1e-7F; // to cube joule
    return res;
}

float alpha_bh(const float T)
{
    float lambda = 2.0F * 157807.0F / T;
    float res = 2.753e-14F;
    res *= pow(lambda, 1.5F);
    res /= pow(1.0F + pow(lambda / 2.74F, 0.407F), 2.242F);
    res *= 1e-6F; // to cube meter
    return res;
}

float beta_h(const float T)
{
    float lambda = 2.0F * 157807.0F / T;
    float res =
        21.11F * pow(T, -1.5F) * exp(-lambda / 2.0F) * pow(lambda, -1.089F);
    res /= pow(1.0F + pow(lambda / 0.354F, 0.874F), 1.01F);
    res *= 1e-6F; // to cube meter
    return res;
}

// Collisional ionisation cooling
float ksi_h0(const float T)
{
    float res = 1.27e-21F * sqrt(T) / (1.0F + sqrt(T / 1.e5F));
    res *= exp(-157809.1F / T);
    res *= 1e-6F; // to cube meter
    res *= 1e-7F; // to cube joule
    return res;
}

// Recombination cooling
float eta_h0(const float T)
{
    float res = 8.7e-27F * sqrt(T) * pow(T / 1.e3F, -0.2F) /
                (1.0F + pow(T / 1.e6F, 0.7F));
    res *= 1e-6F; // to cube meter
    res *= 1e-7F; // to cube joule
    return res;
}

// Collisional excitation cooling
float psi_h0(const float T)
{
    float res = 7.5e-19F / (1.0F + sqrt(T / 1.e5F));
    res *= exp(-118348.0F / T);
    res *= 1e-6F; // to cube meter
    res *= 1e-7F; // to cube joule
    return res;
}

float beta_bremsstrahlung(const float T)
{
    float res = 1.42e-27F * sqrt(T);
    res *= 1e-6F; // to cube meter
    res *= 1e-7F; // to cube joule
    return res;
}

// Gives result in erg cm^3 s⁻1
// Multiply by rho^2

float cooling_rate(const float T, const float x)
{
    const float t0 = x * x;
    const float t1 = 1.0F - x;
    const float t2 = t1 * t1;
    float res = (beta_bremsstrahlung(T) + eta_h0(T)) * t0 +
                (psi_h0(T) + ksi_h0(T)) * t2;
    return res;
}

float cooling_rate_density(const float T, const float rho, const float x_n)
{
    const float t0 = rho * x_n;
    const float t1 = t0 * t0;
    const float t2 = t0 * rho - t1;

    return (beta_bremsstrahlung(T) + eta_h0(T)) * t1 +
           (psi_h0(T) + ksi_h0(T)) * t2;
}

float heating_rate(const float rho, const float x, const float x_n,
                   const float N, const float al_i)
{
    const float e = (20.28F - 13.6F) * 1.60218e-19F;
    // Short time step
    return rho * (1 - x_n) * N * al_i * e * LIGHT_SPEED;
}

// TODO: FUNCTION IS NOT SAFE !!!!!!!!!
float get_root_newton_raphson(const float a, const float b, const float c,
                              const float d)
{
    const float eps = 1e-6F;

    float x = 0.5F;
    float res = 1.0;

    float f, df, t2, t3;

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