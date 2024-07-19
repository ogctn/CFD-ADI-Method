function	print_temp_map(T, hh)
	fprintf(1, "\n");
	if (nargin > 1)
		ii = size(T, 1) : -1 : 1;
		jj =  1 : size(T, 2);
	else
		ii = size(T, 1) - 1 : -1 : 2;
		jj =  2 : size(T, 2) - 1;
	end
	for i = ii
		fprintf(1, "|  ");
		for	j = jj
			fprintf(1, "%.2f  ", T(i, j));
		end
		fprintf(1, "|\n");
	end
	fprintf(1, "\n");
end
