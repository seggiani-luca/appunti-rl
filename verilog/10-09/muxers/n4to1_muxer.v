// un multiplexer da 4 a 1 che prende @x3_x0 come ingresso, @b1_b0 
// come comando e @z0 come uscita
module b4to1_muxer(x3_x0, b1_b0, z0);
	input[3:0] x3_x0;
	input[1:0] b1_b0;
	output z0;

	assign z0 = (b1_b0 == 'B00) ? x3_x0[0]:
							(b1_b0 == 'B01) ? x3_x0[1]:
							(b1_b0 == 'B10) ? x3_x0[2]:
						/*(b1_b0 == 'B11)?*/x3_x0[3];
endmodule

// implementazione a porte logiche
module b4to1_muxer_p(x3_x0, b1_b0, z0);
	input[3:0] x3_x0;
	input[1:0] b1_b0;
	output z0;

	assign z0 = b1_b0[1] & b1_b0[0] & x3_x0[3]
						|	b1_b0[1] & ~b1_b0[0] & x3_x0[2]
						|	~b1_b0[1] & b1_b0[0] & x3_x0[1]
						|	~b1_b0[1] & ~b1_b0[0] & x3_x0[0];
endmodule

// implementazione via decoder
module b4to1_muxer_d(x3_x0, b1_b0, z0);
	input[3:0] x3_x0;
	input[1:0] b1_b0;
	output z0;

	wire[3:0] s3_s0;

	b2to4_decoder b2to4(b1_b0, s3_s0);

	assign z0 = s3_s0[3] & x3_x0[3] | s3_s0[2] & x3_x0[2] 
						| s3_s0[1] & x3_x0[1] | s3_s0[0] & x3_x0[0];
endmodule

// implementazione gerarchica
module b4to1_muxer_g(x3_x0, b1_b0, z0);
	input[3:0] x3_x0;
	input[1:0] b1_b0;
	output z0;

	wire [1:0] s1_s0;

	b2to1_muxer b2to1_1 (x3_x0[3:2], b1_b0[0], s1_s0[1]);
	b2to1_muxer b2to1_2 (x3_x0[1:0], b1_b0[0], s1_s0[0]);
	b2to1_muxer b2to1_f (s1_s0, b1_b0[1], z0);
endmodule
