# Summary on PN simulation

**Note:** No filter were applied.

## Simulation parameters

| Quantity    | Value         |
| ----------- | ------------- |
| Cell Number | 1e6           |
| Cell Type   | hexahedron H8 |
| Dim         | 3             |
| Node Number | 1030301       |
| Size dx     | 0.010000      |
| Size dy     | 0.010000      |
| Size dz     | 0.010000      |
| Tmax        | 1.0           |
| Time Step   | 0.0015        |
| CFL         | 0.9           |
| Iterations  | 667           |

## Source (beam) parameters

- Spatial expression: 
 
            f(x,t) = 1e-8 + exp( ||x - pos|| / (2 * sig_xyz^2) )

- Velocity expression:
  
            h(th,ph) = Intensity * exp( -(||th - th_0|| + ||ph - ph_0||) / (sig^2) )

- Source expression:
  
        s(x,th,ph,t) = f(x,t) * h(th,ph)

| Quantity  | Beam 1 | Beam 2 |
| --------- | ------ | ------ |
| pos_x     | 0.25   | 0.50   |
| pos_y     | 0.50   | 0.75   |
| pos_z     | 0.50   | 0      |
| sig_xyz   | 0.005  | 0.005  |
| Intensity | 1      | 1      |
| th_0      | Pi / 2 | 0      |
| ph_0      | Pi     | Pi / 2 |
| sig       | 0.1    | 0.1    |

# Performances on a Nvidia GTX 970 (4GB and 1664 Cuda Cores)

| Order | N   | Mem. (MB) | Duration. (s) | TDOF      | TDOF / s | MUSCL |
| ----- | --- | --------- | ------------- | --------- | -------- | ----- |
| 1     | 4   | 92        | 0.76          | 2.66800e9 | 3.8114e9 | N     |
| 1     | 4   | 92        | 2.05          | 2.66800e9 | 1.3340e9 | Y     |
| 3     | 16  | 188       | 1.87          | 1.0672e10 | 5.3360e9 | N     |
| 3     | 16  | 188       | 13.98         | 1.0672e10 | 7.1145e8 | Y     |
| 5     | 36  | 348       | 3.97          | 2.4012e10 | 6.0030e9 | N     |
| 5     | 36  | 348       | 36.67         | 2.4012e10 | 6.6700e8 | Y     |
| 7     | 64  | 572       | 13.07         | 4.2688e10 | 3.2836e9 | N     |
| 7     | 64  | 572       | 80.37         | 4.2688e10 | 5.1431e8 | Y     |
| 9     | 100 | 860       | 25.81         | 6.6700e10 | 2.5653e9 | N     |
| 9     | 100 | 860       | 330.57        | 6.6700e10 | 2.0030e8 | Y     |
| 11    | 144 | 1212      | 62.18         | 9.6048e10 | 1.5491e9 | N     |
| 11    | 144 | 1212      | 491.28        | 9.6048e10 | 1.9521e8 | Y     |

TDOF = (N) * (Cell Number) * (Iterations)
