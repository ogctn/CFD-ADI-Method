%%	Calculates solution matrix [T]  of
%%	a[i] * T[i] = b[i] * T[i + 1] + c[i] * T[i - 1] + d[i], where i=[1:N]
%%	Inputs: [a], [b], [c], [d],	Output: [T]

function [T] = TDMA(a, b, c, d)
	N = length(a);
	P = zeros(N, 1);
	Q = zeros(N, 1);
	T = zeros(N, 1);
	for i = 1 : N
		if (i == 1)
				P(i) = b(1) / a(1);
				Q(i) = d(1) / a(1);
		else
			P(i) = b(i) / (a(i) - c(i) * P (i - 1));
			Q(i) = (d(i) + c(i) * Q(i - 1)) / (a(i) - c(i) * P (i - 1));
		end
	end
	for i = N : -1 : 1
		if (i == N)
			T(i) = Q(i);
		else
			T(i) = P(i) * T(i + 1) + Q(i);
		end
	end
end

