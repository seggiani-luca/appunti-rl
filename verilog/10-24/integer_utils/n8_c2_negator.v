// un negatore a 8 cifre in complemento a 2 @x7_x0 che mette il
// risultato in @z7_z0. ow è il flag di overflow
module n8_c2_negator(x7_x0, z7_z0, ow);
	input[7:0] x7_x0;	
	output[7:0] z7_z0;
	output ow;

	wire[7:0] x7_x0_neg;
	assign x7_x0_neg = ~x7_x0;
	
	wire[7:0] s7_s0;
	// sarebbe un incrementatore a 8 cifre binarie
	assign s7_s0 = x7_x0_neg + 1;

	assign z7_z0 = s7_s0;
	assign ow = x7_x0[7] & s7_s0[7];
endmodule
