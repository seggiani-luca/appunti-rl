// una forchetta sulla variabile bidirezionale @x controllata da @b,
// su cui il modulo scrive quanto rileva nel filo @z
module tristate(x);
	inout x;
	wire z;
	wire b;

	assign x = b ? z : 1'BZ;
endmodule
