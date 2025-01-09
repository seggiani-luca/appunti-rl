// un comparatore a 4 bit per interi che confronta @x3_x0 e @y3_y0 e 
// produce i flag:
// - flag_eq: @x3_x0 = @y3_y0 
// - flag_gr: @x3_x0 > @y3_y0
// - flag_lr: @x3_x0 < @y3_y0
module n4_b2_integer_comparator(x3_x0, y3_y0, 
																flag_eq, flag_gr, flag_lr);
	input[3:0] x3_x0, y3_y0;
	output flag_eq, flag_gr, flag_lr;

	wire[4:0] x4_x0 = {x3_x0[3], x3_x0};
	wire[4:0] y4_y0 = {y3_y0[3], y3_y0};

	wire[4:0] d4_d0;
	wire bout;

	n5_b2_subtractor sub (
		.x4_x0(x4_x0), .y4_y0(y4_y0),
		.bin('B0),
		.d4_d0(d4_d0),
		.bout(bout),
	);

	assign flag_eq = (d4_d0 == 'B00000);
	assign flag_gr = ~d4_d0[4] & ~(d4_d0 == 'B00000);
	assign flag_lr = d4_d0[4];
endmodule
