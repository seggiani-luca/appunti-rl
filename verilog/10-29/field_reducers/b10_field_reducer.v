// un riduttore di campo per interi in codifica BCD con LSD @a3_x0, 
// @b3_b0, che mette in @ow la fattibilità (attiva bassa) della 
// riduzione
module b10_field_reducer(a3_a0, b3_b0, ow);
	input[3:0] a3_a0, b3_b0;
	output ow;

	wire flag_lr;

	n4_b2_comparator cmp (
		.x3_x0(b3_b0), .y3_y0('B0101),
		.flag_lr(flag_lr)
	);
	
	assign ow = ~((a3_a0 == 'B1001) & ~flag_lr | 
							(a3_a0 == 'B0000) & flag_lr);
endmodule
