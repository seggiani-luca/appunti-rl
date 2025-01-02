// un modulo che calcola il valore assoluto di un numero intero
// @x1_x0 e lo mette in @z1_z0
module n2_c2_abs(x1_x0, z1_z0);
	input[1:0] x1_x0;
	output[1:0] z1_z0;

	wire[1:0] x1_x0_neg;
	assign x1_x0_neg = ~x1_x0;
	
	wire[1:0] s1_s0;
	// sarebbe un incrementatore a 2 cifre binarie
	assign s1_s0 = x1_x0_neg + 1;

	assign z1_z0 = (x1_x0[1] == 'B1) ? s1_s0 : x1_x0;	
endmodule
