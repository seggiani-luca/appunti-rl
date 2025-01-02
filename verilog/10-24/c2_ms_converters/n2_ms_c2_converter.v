// un convertitore da modulo e segno a complemento a 2 di un intero
// su 2 bit @x1_x0_abs e @sgn che mette la rappresentazione in @z1_z0
module n2_ms_c2_converter(x1_x0_abs, sgn, z1_z0, ow);
	input[1:0] x1_x0_abs;	
	input sgn;
	output[1:0] z1_z0;
	output ow;

	wire[1:0] x1_x0_neg;

	n2_c2_negator neg (
		.x1_x0(x1_x0_abs), .z1_z0(x1_x0_neg)
	);

	assign ow = ~((x1_x0_abs == 'B10) & sgn | ~x1_x0_abs[1]);

	assign z1_z0 = (sgn) ? x1_x0_neg : x1_x0_abs;
endmodule
