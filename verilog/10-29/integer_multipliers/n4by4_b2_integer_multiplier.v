// un moltiplicatore per interi a 4 * 4 cifre che calcola 
// @x3_x0 * @y3_y0 e lo mette in @p7_p0
module n4by4_b2_integer_multiplier(x3_x0, y3_y0, p7_p0);
	input[3:0] x3_x0, y3_y0;
	output[7:0] p7_p0;
	
	wire[3:0] x3_x0_abs, y3_y0_abs;
	wire x_sgn, y_sgn;

	n4_c2_ms_converter x_conv (
		.x3_x0(x3_x0), 
		.z3_z0(x3_x0_abs), .sgn(x_sgn)
	);
	
	n4_c2_ms_converter y_conv (
		.x3_x0(y3_y0), 
		.z3_z0(y3_y0_abs), .sgn(y_sgn)
	);
	
	wire[7:0] p7_p0_abs;	
	wire p_sgn;

	n4by4_b2_multiplier mul (
		.x3_x0(x3_x0_abs), .y3_y0(y3_y0_abs), .c3_c0('B0000),
		.p7_p0(p7_p0_abs)
	);

	assign p_sgn = x_sgn ^ y_sgn;

	n8_ms_c2_converter p_conv (
		.x7_x0_abs(p7_p0_abs), .sgn(p_sgn),
		.z7_z0(p7_p0)
	);
endmodule
