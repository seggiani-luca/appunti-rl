// un divisore a 4 cifre che calcola @x3_x0 / @y1_y0, mette il
// quoziente in @q1_q0 e il resto in @r1_r0. no_div rappresenta la
// non fattibilita'
module n4by4_b2_divider(x3_x0, y1_y0, q1_q0, r1_r0, no_div);
	input[3:0] x3_x0;
	input[1:0] y1_y0;
	output[1:0] q1_q0;
	output[1:0] r1_r0;
	output no_div;

	wire[1:0] res;

	feasibility_checker fes (
		.x3_x0(x3_x0), .y1_y0(y1_y0),
		.no_div(no_div)
	);

	n3by2_divider div_1 (
		.x2_x0(x3_x0[3:1]), .y1_y0(y1_y0),
		.q(q1_q0[1]), .r1_r0(res)
	);

	n3by2_divider div_2 (
		.x2_x0({res, x3_x0[0]}), .y1_y0(y1_y0),
		.q(q1_q0[0]), .r1_r0(r1_r0)
	);
endmodule

// modulo che controlla la fattibilita' della divisione
module feasibility_checker(x3_x0, y1_y0, no_div);
	input[3:0] x3_x0;
	input[1:0] y1_y0;
	output no_div;

	wire[3:0] y1_y0_by4;
	assign y1_y0_by4 = {y1_y0, 2'B1};
	
	wire flag_lr;

	n4_b2_comparator cmp (
		.x3_x0(x3_x0), .y3_y0(y1_y0_by4),
		.flag_lr(flag_lr)
	);

	assign no_div = ~(flag_lr & |y1_y0);
endmodule
