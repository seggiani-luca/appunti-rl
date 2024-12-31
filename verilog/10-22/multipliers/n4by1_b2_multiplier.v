// un moltiplicatore a 4 * 1 cifre che calcola @x3_x0 * @y + @c3_c0
// e lo mette in @p4_p0
module n4by1_multiplier(x3_x0, y, c3_c0, p4_p0);
	input[3:0] x3_x0, c3_c0;
	input y;
	output[4:0] p4_p0;

	wire[3:0] lhs;

	assign lhs = x3_x0 & {4{y}};

	n4_b2_adder addr (
		.x3_x0(lhs), .y3_y0(c3_c0),
		.cin('B0),
		.s3_s0(p4_p0[3:0]),
		.cout(p4_p0[4])
	);
endmodule
