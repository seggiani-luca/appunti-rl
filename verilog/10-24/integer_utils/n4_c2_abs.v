// un modulo che calcola il valore assoluto di un numero intero
// @x3_x0 e lo mette in @z3_z0
module n4_c2_abs(x3_x0, z3_z0);
	input[3:0] x3_x0;
	output[3:0] z3_z0;

	wire[3:0] x3_x0_neg;
	assign x3_x0_neg = ~x3_x0;
	
	wire[3:0] s3_s0;

	n4_b2_incrementer inc (
		.x3_x0(x3_x0_neg), .cin('B1),
		.s3_s0(s3_s0)
	);

	assign z3_z0 = (x3_x0[3] == 'B1) ? s3_s0 : x3_x0;	
endmodule

// implementazione a porte XOR
module n4_c2_abs_x(x3_x0, z3_z0);
	input[3:0] x3_x0;
	output[3:0] z3_z0;

	wire[3:0] x3_x0_xor;
	assign x3_x0_xor = x3_x0 ^ {4{x3_x0[3]}};
	
	wire[3:0] z3_z0;

	n4_b2_incrementer inc (
		.x3_x0(x3_x0_xor), .cin(x3_x0[3]),
		.s3_s0(z3_z0)
	);
endmodule
