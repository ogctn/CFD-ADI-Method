%%	Key eqns: Eq(7.12)
%	(a_p * T_p)= (a_w * T_w) + (a_e * T_e) + (a_s * T_s) + (a_n * T_n)
clear; clc;
%% Given parameters
L = 0.3;		% Length
H = 0.4;		% Heigth
dx = 0.1;
dy = 0.1;
dx2 = dx * dx;
dy2 = dy * dy;
th = 0.01;		% thickness of plate
k = 1000;		% thermal conductivity (W / m*K)
nx = L / dx;	% number nodes in x-dir
ny = H / dy;	% number of nodes in y-dir
q = 500;		% steady heat flux (kW / m^2)
T_H = 100;		% North boundary condition (°C)
%%	Initializaton
A_w = th * dx;	a_w = (k / dx) * A_w;
A_e = th * dx;	a_e = (k / dx) * A_e;
A_s = th * dy;	a_s = (k / dy) * A_s;
A_n = th * dy;	a_n = (k / dy) * A_n;

%%	row wise sweep
for j = 2 : nx-1
	dx(1) = 1;

	for i = 2 : ny-1
		dx(i) = 2 / dx2 + 2 / dy2;
		ax(i - 1) = -1 / dx2;
		cx(i) = -1 / dx2;
		bx(i) = -sij(i, j) + T(i, j + 1) / dy2 + T(i, j - 1);
	end
	dx(n) = 1;
	bx(ny) = T();
	T(:, j) = TDMA();
end
dx(nx) = 1
%%
%TDMA(a, b, c, d)