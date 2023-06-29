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

| PN Order | MUSCL | Nb. var. | Memory (MB) | Comp. Time (sec) | *Tot. DOF  | Tot. DOF per sec |
| -------- | ----- | -------- | ----------- | ---------------- | --------- | ---------------- |
| 1        | NO    | 4        | 90          | 0.7              | 2.668e9   | 3.8114e9         |
| 1        | YES   | 4        | 90          | 2                | 2.668e9   | 1.3340e9         |
| 3        | NO    | 16       | 190         | 2                | 1.0672e10 | 5.3360e9         |
| 3        | YES   | 16       | 190         | 15               | 1.0672e10 | 7.1145e8         |
| 5        | NO    | 36       | 350         | 4                | 2.4012e10 | 6.0030e9         |
| 5        | YES   | 36       | 50          | 36               | 2.4012e10 | 6.6700e8         |
| 7        | NO    | 64       | 600         | 13               | 4.2688e10 | 3.2836e9         |
| 7        | YES   | 64       | 600         | 83               | 4.2688e10 | 5.1431e8         |
| 9        | NO    | 100      | 860         | 26               | 6.6700e10 | 2.5653e9         |
| 9        | YES   | 100      | 860         | 333              | 6.6700e10 | 2.0030e8         |
| 11       | NO    | 144      | 1200        | 62               | 9.6048e10 | 1.5491e9         |

*Tot. DOF = (Nb. Macro variable) * (Cell Number) * (Iterations)
