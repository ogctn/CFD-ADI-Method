% Line by line TDMA (LBL TDMA)
% ref: https://youtu.be/oDN2NxwMAnQ?t=2591
clear all; clear; clc;

bc_left	= 100;	bc_right	= 200;
bc_top	= 400;	bc_bottom	= 300;

data.S_c = 0;		data.S_p = 0;
data.k = 500;	% k = gamma (W/mK)
data.rho = 
data.L = 0.4;	data.H = 0.6;	% Length of plate (m)
data.nx = 4;	data.ny = 6;	% number of nodes in direction 
data.dx = data.L / data.nx;		% (m)
data.dy = data.H / data.ny;		% (m)

%	Initialize Temperature matrix with BCs
data.T = ones(data.ny + 2, data.nx + 2)...	% guess temp of all nodes
	* (bc_left + bc_right + bc_top + bc_bottom) / 4;
data.T(2 : data.ny + 1, 1) = bc_left;	data.T(2 : data.ny + 1, data.nx + 2) = bc_right;
data.T(1, 2 : data.nx + 1) = bc_bottom;	data.T(data.ny + 2, 2 : data.nx + 1) = bc_top;
data.T(1,1) = (bc_left + bc_bottom) / 2;
data.T(1, data.nx + 2) = (bc_right + bc_bottom) / 2;
data.T(data.ny + 2, data.nx + 2) = (bc_right + bc_top) / 2;
data.T(data.ny + 2, 1) = (bc_left + bc_top) / 2;
clear bc_left bc_right bc_top bc_bottom
% calculate coeffs
a_ew = data.k * data.dy / data.dx;		a_sn = data.k * data.dx / data.dy;
a_e = ones(data.ny, data.nx) * a_ew;	a_w = ones(data.ny, data.nx) * a_ew;
a_n = ones(data.ny, data.nx) * a_sn;	a_s = ones(data.ny, data.nx) * a_sn;

a_e(:, data.nx) = 2 * a_ew;		a_w(:, 1) = 2 * a_ew;
a_n(data.ny , :) = 2 * a_sn;	a_s(1, :) = 2 * a_sn;
a_p0 = (data.rho * data.) / data.dt;
b = data.S_c * data.dx * data.dy;
a_p = a_e + a_w + a_n + a_s + a_p0 - data.S_p * data.dx * data.dy;
data.a = struct('self', a_self, 'east', a_e, 'west', a_w, 'north', a_n, 'south', a_s);
clear a_self a_e a_w a_n a_s a_ew a_sn;

print_temp_map(data.T, "full");


tol = 1e-6;
iter = 0;
while 1
	iter = iter + 1;
    T_prev = data.T(2 : data.ny + 1, 2 : data.nx + 1);
    data.T = line_by_lineTDMA(data);
	if max(abs(data.T(2 : data.ny + 1, 2 : data.nx + 1) - T_prev), [], 'all') < tol
		break;
	elseif iter == 100000;
		fprintf("Didnt converge ater %d iterations.", iter);
		break;
	end
end

print_temp_map(data.T, "all");
% disp(iter);
% contourf(data.T);
% colorbar;
% title('Temperature');
% xlabel('X-axis');
% ylabel('Y-axis');
