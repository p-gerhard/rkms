#ifndef TP_CL
#define TP_CL

// VF Solver injected values (DO NOT REMOVE/MODIFY)
#define NGRID __NGRID__
#define M	  (1)
#define DT	  __DT__
#define DX	  __DX__
#define DY	  __DY__
#define DIM	  __DIM__

#if DIM == 2
#define IS_2D
#else
#undef IS_2D
#define DZ __DZ__
#endif

#include <solver/muscl_finite_volume.cl>

// Model injected values
#define SRC_X	 __SRC_X__
#define SRC_Y	 __SRC_Y__
#define SRC_Z	 __SRC_Z__
#define SRC_R	 __SRC_R__
#define SRC_TOFF __SRC_TOFF__
#define VX		 __VX__
#define VY		 __VY__
#define VZ		 __VZ__

void tp_num_flux_upwind(const float wL[M], const float wR[M],
						const float vn[DIM], float flux[M])
{
#ifdef IS_2D
	const float v_dot_n = vn[0] * VX + vn[1] * VY;
#else
	const float v_dot_n = vn[0] * VX + vn[1] * VY + vn[2] * VZ;
#endif

	const float vp = v_dot_n > 0.f ? v_dot_n : 0.f;
	const float vm = v_dot_n - vp;

	flux[0] = vp * wL[0] + vm * wR[0];
}

static void tp_src_gaussian_line_source(const float t, const float x[DIM],
										float w[M])
{
#ifdef IS_2D
	const float d =
		(x[0] - SRC_X) * (x[0] - SRC_X) + (x[1] - SRC_Y) * (x[1] - SRC_Y);
#else
	const float d = (x[0] - SRC_X) * (x[0] - SRC_X) +
					(x[1] - SRC_Y) * (x[1] - SRC_Y) +
					(x[2] - SRC_Z) * (x[2] - SRC_Z);
#endif

	const float vaccum = 0.f;
	const float omega = 0.03f;
	const float omega2 = omega * omega;
	const float gauss = exp(-10 * d / (omega2));

	w[0] = max(gauss, vaccum);
}

void tp_src_circle(const float t, const float x[DIM], float w[M])
{
#ifdef IS_2D
	const float d =
		(x[0] - SRC_X) * (x[0] - SRC_X) + (x[1] - SRC_Y) * (x[1] - SRC_Y);
#else
	const float d = (x[0] - SRC_X) * (x[0] - SRC_X) +
					(x[1] - SRC_Y) * (x[1] - SRC_Y) +
					(x[2] - SRC_Z) * (x[2] - SRC_Z);
#endif

	if (d <= SRC_R * SRC_R) {
		w[0] = 1.f;
	}
}

void tp_source(const float t, const float x[DIM], float s[M])
{
	// tp_src_circle(t, x, s);
	tp_src_gaussian_line_source(t, x, s);
}

void model_init_cond(const float t, const float x[DIM], float s[M])
{
	tp_source(t, x, s);
}

void model_src(const float t, const float x[DIM], const float wn[M], float s[M])
{
	// tp_source(t, x, s);
	s[0] = 0.f;
}

void model_flux_num(const float wL[M], const float wR[M], const float vn[DIM],
					float flux[M])
{
	tp_num_flux_upwind(wL, wR, vn, flux);
}

void model_flux_num_bd(const float wL[M], const float wR[M],
					   const float vn[DIM], float flux[M])
{
	tp_num_flux_upwind(wL, wL, vn, flux);
}
#endif