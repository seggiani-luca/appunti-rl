// un divisore a 3 / 2 cifre che calcola @x2_x0 / @y1_y0, mette il
// quoziente in @q e il resto in @r1_r0
module n3by2_b2_divider(x2_x0, y1_y0, q, r1_r0);
	input[2:0] x2_x0;
	input[1:0] y1_y0;
	output q;
	output[1:0] r1_r0;

	wire[2:0] y2_y0;
	assign y2_y0 = {1'B0, y1_y0};

	wire[2:0] d2_d0;
	wire bout;

	n3_b2_subtractor cmp (
		.x2_x0(x2_x0), .y2_y0(y2_y0),
		.bin('B0),
		.d2_d0(d2_d0),
		.bout(bout)
	);

	// dal n3_b2_comparator (tecnicamente)
	wire flag_geq;
	assign flag_geq = ~bout;
	
	assign q = flag_geq;
	
	// un multiplexer a due vie
	assign r1_r0 = flag_geq ? d2_d0[1:0] : x2_x0[1:0];
endmodule
