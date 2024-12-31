// un moltiplicatore a 4 * 4 cifre che calcola 
// @x3_x0 * @y3_y0 + @c3_c0 e lo mette in @p7_p0
module n4by4_multiplier(x3_x0, y3_y0, c3_c0, p7_p0);
	input[3:0] x3_x0, y3_y0, c3_c0;
	output[7:0] p7_p0;
	
	wire[3:0] par_1;
	wire[3:0] par_2;
	wire[3:0] par_3;

	n4by1_multiplier mul_1 (
		.x3_x0(x3_x0), .y(y3_y0[0]), .c3_c0(c3_c0),
		.p4_p0({par_1, p7_p0[0]})
	);
	
	n4by1_multiplier mul_2 (
		.x3_x0(x3_x0), .y(y3_y0[1]), .c3_c0(par_1),
		.p4_p0({par_2, p7_p0[1]})
	);
	
	n4by1_multiplier mul_3 (
		.x3_x0(x3_x0), .y(y3_y0[2]), .c3_c0(par_2),
		.p4_p0({par_3, p7_p0[2]})
	);
	
	n4by1_multiplier mul_4 (
		.x3_x0(x3_x0), .y(y3_y0[3]), .c3_c0(par_3),
		.p4_p0(p7_p0[7:3])
	);
endmodule
