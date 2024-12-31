// un convertitore da codifica BCD a codifica binaria, che prende le 
// 2 cifre @a3_a0 e @b3_b0 e mette la loro codifica binaria in @x7_x0
module n2_bcd_b2_converter(a3_a0, b3_b0, x7_x0);
	input[3:0] a3_a0, b3_b0;
	output[7:0] x7_x0;

	wire[7:0] a3_a0_ext_1;
	wire[7:0] a3_a0_ext_2;
	wire[7:0] b3_b0_ext;

	assign a3_a0_ext_1 = {1'B0, a3_a0, 3'B000};
	assign a3_a0_ext_2 = {3'B000, a3_a0, 1'B0};
	assign b3_b0_ext = {4'B000, b3_b0};

	// sarebbe un sommatore a 8 cifre binarie
	assign x7_x0 = a3_a0_ext_1 + a3_a0_ext_2 + b3_b0_ext;
endmodule
