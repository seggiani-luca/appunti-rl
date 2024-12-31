// una porta tri-state con @x variabile di ingresso, @z variabile di
// uscita e @b variabile di controllo attiva alta
module tristate(x, b, z);
	input x, b;
	output z;

	assign z = b ? x : 'BZ;
endmodule
