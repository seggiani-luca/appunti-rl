// un multiplexer da 8 a 1 che prende @x7_x0 come ingresso, @b2_b0 
// come comando e @z0 come uscita
module b8to1_muxer(x7_x0, b2_b0, z0);
	input[7:0] x7_x0;
	input[2:0] b2_b0;
	output z0;

	assign z0 = (b2_b0 == 'B000) ? x7_x0[0]:
							(b2_b0 == 'B001) ? x7_x0[1]:
							(b2_b0 == 'B010) ? x7_x0[2]:
							(b2_b0 == 'B011) ? x7_x0[3]:
							(b2_b0 == 'B100) ? x7_x0[4]:
							(b2_b0 == 'B101) ? x7_x0[5]:
							(b2_b0 == 'B110) ? x7_x0[6]:
						/*(b2_b0 == 'B111)?*/x7_x0[7];
endmodule

// implementazione a porte logiche
module b8to1_muxer_p(x7_x0, b2_b0, z0);
	input[7:0] x7_x0;
	input[2:0] b2_b0;
	output z0;

	assign z0 = b2_b0[2] & b2_b0[1] & b2_b0[0] & x7_x0[7]
						| b2_b0[2] & b2_b0[1] & ~b2_b0[0] & x7_x0[6]
						| b2_b0[2] & ~b2_b0[1] & b2_b0[0] & x7_x0[5]
						| b2_b0[2] & ~b2_b0[1] & ~b2_b0[0] & x7_x0[4]
						| ~b2_b0[2] & b2_b0[1] & b2_b0[0] & x7_x0[3]
						| ~b2_b0[2] & b2_b0[1] & ~b2_b0[0] & x7_x0[2]
						| ~b2_b0[2] & ~b2_b0[1] & b2_b0[0] & x7_x0[1]
						| ~b2_b0[2] & ~b2_b0[1] & ~b2_b0[0] & x7_x0[0];
endmodule

// implementazione via decoder
module b8to1_muxer_d(x7_x0, b2_b0, z0);
	input[7:0] x7_x0;
	input[2:0] b2_b0;
	output z0;

	wire[7:0] s7_s0;

	b3to8_decoder b3to8(b2_b0, s7_s0);

	assign z0 = s7_s0[7] & x7_x0[7] | s7_s0[6] & x7_x0[6] 
						| s7_s0[5] & x7_x0[5] | s7_s0[4] & x7_x0[4]
						| s7_s0[3] & x7_x0[3] | s7_s0[2] & x7_x0[2]
						| s7_s0[1] & x7_x0[1] | s7_s0[0] & x7_x0[0];
endmodule

// implementazione gerarchica
module b8to1_muxer_g(x7_x0, b2_b0, z0);
	input[7:0] x7_x0;
	input[2:0] b2_b0;
	output z0;

	wire [1:0] s1_s0;

	b4to1_muxer b4to1_1 (x7_x0[7:4], b2_b0[1:0], s1_s0[1]);
	b4to1_muxer b4to1_2 (x7_x0[3:0], b2_b0[1:0], s1_s0[0]);
	b2to1_muxer b2to1_f (s1_s0, b2_b0[2], z0);
endmodule
