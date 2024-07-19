% a is the struct containing coefficients, T is the initial temperature matrix
function T = line_by_lineTDMA(data)
	for i = 2 : size(data.T, 1) - 1
        self = data.a.self(i - 1, :);
        east = data.a.east(i - 1, :);
        west = data.a.west(i - 1, :);
        d_row = data.S * data.dx^2 * ones(size(data.T(i, 2:end-1))) + ...
				east' .* data.T(i, 3:end) + ...
				west' .* data.T(i, 1:end-2);
        data.T(i, 2 : end - 1) = TDMA([west'; self'; east'], d_row');
	end
	for j = 2 : size(data.T, 2) - 1
        self = data.a.self(:, j - 1);
        north = data.a.north(:, j - 1);
        south = data.a.south(:, j - 1);
        
        % Right-hand side vector for the current column
		d_col = data.S * data.dy^2 * ones(size(data.T(2:end-1, j))) + ...
				north .* data.T(3:end, j) + ...
				south .* data.T(1:end-2, j);
        
        % Solve the tridiagonal system using TDMA
        data.T(2 : end - 1, j) = TDMA([south'; self'; north'], d_col');
	end
    T = data.T;
end
