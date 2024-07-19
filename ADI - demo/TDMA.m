% TDMA for a tridiagonal system Ax = d
% A is the tridiagonal matrix in reduced form (nx3 matrix), d (nx1)
% Output: x - solution vector (nx1)
function phi = TDMA(A, d)
	a = A(1, :);
	b = A(2, :);
	c = A(3, :);
	n = length(b);
	P = zeros(n, 1);
	Q = zeros(n, 1);
	P(1) = b(1) / a(1);
	Q(1) = d(1) / a(1);
	for i = 2 : n
		P(i) = b(i) / (a(i) - c(i) * P(i - 1));
		Q(i) = (d(i) + c(i) * Q(i - 1)) / (a(i) - c(i) * P(i - 1));
	end
	phi = zeros(n, 1);
	phi(n) = Q(n);
	for i = n-1 : -1 : 1
		phi(i) = P(i) * phi(i + 1) + Q(i);
	end
end
