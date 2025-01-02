// un negatore a 2 cifre in complemento a 2 @x1_x0 che mette il
// risultato in @z1_z0. ow è il flag di overflow
module n2_c2_negator(x1_x0, z1_z0, ow);
	input[1:0] x1_x0;	
	output[1:0] z1_z0;
	output ow;

	wire[1:0] x1_x0_neg;
	assign x1_x0_neg = ~x1_x0;
	
	wire[1:0] s1_s0;
	// sarebbe un incrementatore a 2 cifre
	assign s1_s0 = x1_x0_neg + 1;

	assign z1_z0 = s1_s0;
	assign ow = x1_x0[3] & s1_s0[3];
endmodule
