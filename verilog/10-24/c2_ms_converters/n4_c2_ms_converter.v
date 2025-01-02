// un convertitore da complemento a 2 a modulo e segno di un intero
// su 4 bit @x3_x0 che mette la rappresentazione in @z3_z0 e @sgn
module n4_c2_ms_converter(x3_x0, z3_z0, sgn);
	input[3:0] x3_x0;	
	output[3:0] z3_z0;
	output sgn;

	n4_c2_abs abs (
		.x3_x0(x3_x0), .z3_z0(z3_z0)
	);

	assign sgn = x3_x0[3];
endmodule
