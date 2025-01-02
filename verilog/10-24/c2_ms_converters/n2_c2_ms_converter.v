// un convertitore da complemento a 2 a modulo e segno di un intero
// su 2 bit @x1_x0 che mette la rappresentazione in @z1_z0 e @sgn
module n2_c2_ms_converter(x1_x0, z1_z0, sgn);
	input[1:0] x1_x0;	
	output[1:0] z1_z0;
	output sgn;

	n2_c2_abs abs (
		.x1_x0(x1_x0), .z1_z0(z1_z0)
	);

	assign sgn = x1_x0[1];
endmodule
