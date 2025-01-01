// un comparatore a 3 bit che confronta @x2_x0 e @y2_y0 e produce i
// flag:
// - flag_eq: @x2_x0 = @y2_y0 
// - flag_gr: @x2_x0 > @y2_y0
// - flag_lr: @x2_x0 < @y2_y0
module n3_b2_comparator(x2_x0, y2_y0, flag_eq, flag_gr, flag_lr);
	input[2:0] x2_x0, y2_y0;
	output flag_eq, flag_gr, flag_lr;

	wire[2:0] d2_d0;
	wire bout;

	n3_b2_subtractor subr(
		.x2_x0(x2_x0), .y2_y0(y2_y0),
		.bin('B0),
		.d2_d0(d2_d0),
		.bout(bout)
	);

	assign flag_eq = (d2_d0 == 'B0000) & ~bout;
	assign flag_gr = ~(d2_d0 == 'B0000) & ~bout;
	assign flag_lr = bout;
endmodule
