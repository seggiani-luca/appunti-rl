// un negatore a 4 cifre in complemento a 2 @x3_x0 che mette il
// risultato in @z3_z0. ow è il flag di overflow
module n4_c2_negator(x3_x0, z3_z0, ow);
	input[3:0] x3_x0;	
	output[3:0] z3_z0;
	output ow;

	wire[3:0] x3_x0_neg;
	assign x3_x0_neg = ~x3_x0;
	
	wire[3:0] s3_s0;

	n4_b2_incrementer inc (
		.x3_x0(x3_x0_neg), .cin('B1),
		.s3_s0(s3_s0)
	);

	assign z3_z0 = s3_s0;
	assign ow = x3_x0[3] & s3_s0[3];
endmodule
