// un comparatore a 4 bit che confronta @x3_x0 e @y3_y0 e produce i
// flag:
// - flag_eq: @x3_x0 = @y3_y0 
// - flag_gr: @x3_x0 > @y3_y0
// - flag_lr: @x3_x0 < @y3_y0
module n4_b2_comparator(x3_x0, y3_y0, flag_eq, flag_gr, flag_lr);
	input[3:0] x3_x0, y3_y0;
	output flag_eq, flag_gr, flag_lr;

	wire[3:0] d3_d0;
	wire bout;

	n4_b2_subtractor subr(
		.x3_x0(x3_x0), .y3_y0(y3_y0),
		.bin('B0),
		.d3_d0(d3_d0),
		.bout(bout)
	);

	assign flag_eq = (d3_d0 == 'B0000) & ~bout;
	assign flag_gr = ~(d3_d0 == 'B0000) & ~bout;
	assign flag_lr = bout;
endmodule
