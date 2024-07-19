function	R = reduced_tridiagonals(A)
		[rows, cols] = size(A);
		assert(rows == cols, 'reduced_diagonals: Matrix A should be square' );
		a = isempty(nonzeros(tril(A, -2) + triu(A, 2)));
		assert(a == 1, 'reduced_diagonals: Matrix A has non-zero elements at out of diagonals' );
		R = zeros(3, rows);
		R(2, 1) = A(1, 1);
		for i = 2 : rows - 1
			R(1, i) = A(i, i - 1);
			R(2, i) = A(i, i);
			R(3, i - 1) = A(i - 1, i);
		end
		R(1, rows) = A(rows, rows - 1);
		R(2, rows) = A(rows, rows);
		R(3, rows - 1) = A(rows - 1, rows);
end
