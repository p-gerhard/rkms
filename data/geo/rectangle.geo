Mesh.Algorithm = 8;
DefineConstant[xmin = {0, Name "xmin"} ];
DefineConstant[ymin = {0, Name "ymin"} ];
DefineConstant[xmax = {1, Name "xmax" , Min xmin}];
DefineConstant[ymax = {1, Name "ymax",  Min ymin}];
DefineConstant[nx = {64, Name "nx", Min 0}];
DefineConstant[ny = {64, Name "ny", Min 0}];

Point(1) = {xmin, ymin, 0};
Point(2) = {xmax, ymin, 0};
Point(3) = {xmax, ymax, 0};
Point(4) = {xmin, ymax, 0};

Line(1) = {1, 2};
Transfinite Line {1} = nx+1 Using Progression 1;
Line(2) = {2, 3};
Transfinite Line {2} = ny+1 Using Progression 1;
Line(3) = {3, 4};
Transfinite Line {3} = nx+1 Using Progression 1;
Line(4) = {4, 1};
Transfinite Line {4} = ny+1 Using Progression 1;

Line Loop(1) = {1, 2, 3, 4};
Surface(1) = {1};

Physical Surface(20) = {1};

Transfinite Surface "*";
Recombine Surface "*";
Transfinite Volume "*";