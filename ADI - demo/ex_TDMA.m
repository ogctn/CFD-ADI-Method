%	ref:	https://www.youtube.com/watch?v=nHt64KA_iDY
%	a[i] * T[i] = b[i] * T[i + 1] + c[i] * T[i - 1] + d[i]
%			where i = [1:N]
%	
%	if i = 1 inserted;  T[0] = 0; C[0]
%	if i = N inserted;  T[N + 1] = 0; b[N] = 0
%
% 
% 	[ a1,	 b1,	  0,	  0,	0,		...	]	[T1	]		[d1	]
% 	| c2,	 a2,	 b2,	  0,	...		...	|	|T2	|		|d2	|
% 	|  0,	 c3,	 a3,	 b3,	0,		...	|	|T3	|	=	|d3	|
% 	|  0,	  0,	...		...		...		...	|	|...|		|...|
% 	|  0,	  0,	...		...		...		...	|	|...|		|...|
% 	[  0,	  0,	  0,	...,	c_N,	a_N	]	[T_N]		[d_N]
%
%	T will be the solution
%
%	TDMA: 
%	c_1 = 0; b_n = 0
%	p_1 = b1 / a1;	Q_1 = d1 / a1
%	once P1 and Q1 are known, we can calculate P2 and Q2 
%	once P2 and Q2 are known, we can calculate P3 and Q3 and so on ...
%
%	We have:
%
%	T_i = P_i * T_(i+1) + Q_i
%	
%	because of b_n = 0 --> P_n = 0 --> T_n = Q_n
%	T_(n-1) = P_(n-1) + Q_(n-1) ...
%
%	Implementation:

clear all; clear; clc

%	Initialization

a = [3000; 2000; 2000; 3000];
b = [1000; 1000; 1000; 0];
c = [-0; 1000; 1000; 1000];
d = [2500 + 2000 * 100; 2500; 2500; 2500 + 2000 * 400];
N = length(a);
P = zeros(N, 1);
Q = zeros(N, 1);
T = zeros(N, 1);

%	Forward elimination
for i = 1 : N
	if (i == 1)
			P(i) = b(1) / a(1);
			Q(i) = d(1) / a(1);
	else
		P(i) = b(i) / (a(i) - c(i) * P (i - 1));
		Q(i) = (d(i) + c(i) * Q(i - 1)) / (a(i) - c(i) * P (i - 1));
	end
end

%	Back Substitution
for i = N : -1 : 1
	if (i == N)
		T(i) = Q(i);
	else
		T(i) = P(i) * T(i + 1) + Q(i);
	end
end









