// un convertitore da modulo e segno a complemento a 2 di un intero
// su 4 bit @x3_x0_abs e @sgn che mette la rappresentazione in @z3_z0
module n4_ms_c2_converter(x3_x0_abs, sgn, z3_z0, ow);
	input[3:0] x3_x0_abs;	
	input sgn;
	output[3:0] z3_z0;
	output ow;

	wire[3:0] x3_x0_neg;

	n4_c2_negator neg (
		.x3_x0(x3_x0_abs), .z3_z0(x3_x0_neg)
	);

	assign ow = ~((x3_x0_abs == 'B1000) & sgn | ~x3_x0_abs[3]);

	assign z3_z0 = (sgn) ? x3_x0_neg : x3_x0_abs; 
endmodule
