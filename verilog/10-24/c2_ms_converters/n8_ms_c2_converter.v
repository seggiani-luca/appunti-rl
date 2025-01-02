// un convertitore da modulo e segno a complemento a 2 di un intero
// su 8 bit @x7_x0_abs e @sgn che mette la rappresentazione in @z7_z0
module n8_ms_c2_converter(x7_x0_abs, sgn, z7_z0, ow);
	input[7:0] x7_x0_abs;	
	input sgn;
	output[7:0] z7_z0;
	output ow;

	wire[7:0] x7_x0_neg;

	n8_c2_negator neg (
		.x7_x0(x7_x0_abs), .z7_z0(x7_x0_neg),
	);

	assign ow = ~((x7_x0_abs == 'B10000000) & sgn | ~x7_x0_abs[7]);
	
	assign z7_z0 = (sgn) ? x7_x0_neg : x7_x0_abs; 
endmodule
