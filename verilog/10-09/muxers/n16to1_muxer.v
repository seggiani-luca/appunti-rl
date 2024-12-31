// un multiplexer da 16 a 1 che prende @x15_x0 come ingresso, @b3_b0 
// come comando e @z0 come uscita
module b16to1_muxer(x15_x0, b3_b0, z0);
	input[15:0] x15_x0;
	input[3:0] b3_b0;
	output z0;

	assign z0 = (b3_b0 == 'B0000) ? x15_x0[0]:
							(b3_b0 == 'B0001) ? x15_x0[1]:
							(b3_b0 == 'B0010) ? x15_x0[2]:
							(b3_b0 == 'B0011) ? x15_x0[3]:
							(b3_b0 == 'B0100) ? x15_x0[4]:
							(b3_b0 == 'B0101) ? x15_x0[5]:
							(b3_b0 == 'B0110) ? x15_x0[6]:
							(b3_b0 == 'B0111) ? x15_x0[7]:
							(b3_b0 == 'B1000) ? x15_x0[8]:
							(b3_b0 == 'B1001) ? x15_x0[9]:
							(b3_b0 == 'B1010) ? x15_x0[10]:
							(b3_b0 == 'B1011) ? x15_x0[11]:
							(b3_b0 == 'B1100) ? x15_x0[12]:
							(b3_b0 == 'B1101) ? x15_x0[13]:
							(b3_b0 == 'B1110) ? x15_x0[14]:
						/*(b3_b0 == 'B1111)?*/x15_x0[15];
endmodule

// implementazione a porte logiche
module b16to1_muxer_p(x15_x0, b3_b0, z0);
	input[15:0] x15_x0;
	input[3:0] b3_b0;
	output z0;

	assign z0 = b3_b0[3] & b3_b0[2] & b3_b0[1] & b3_b0[0] & x15_x0[15]
						| b3_b0[3] & b3_b0[2] & b3_b0[1] & ~b3_b0[0] & x15_x0[14]
						| b3_b0[3] & b3_b0[2] & ~b3_b0[1] & b3_b0[0] & x15_x0[13]
						| b3_b0[3] & b3_b0[2] & ~b3_b0[1] & ~b3_b0[0] 
																												 & x15_x0[12]
						| b3_b0[3] & ~b3_b0[2] & b3_b0[1] & b3_b0[0] & x15_x0[11]
						| b3_b0[3] & ~b3_b0[2] & b3_b0[1] & ~b3_b0[0]
																												 & x15_x0[10]
						| b3_b0[3] & ~b3_b0[2] & ~b3_b0[1] & b3_b0[0] & x15_x0[9]
						| b3_b0[3] & ~b3_b0[2] & ~b3_b0[1] & ~b3_b0[0]
																													& x15_x0[8]
						| ~b3_b0[3] & b3_b0[2] & b3_b0[1] & b3_b0[0] & x15_x0[7]
						| ~b3_b0[3] & b3_b0[2] & b3_b0[1] & ~b3_b0[0]
																													& x15_x0[6]
						| ~b3_b0[3] & b3_b0[2] & ~b3_b0[1] & b3_b0[0] & x15_x0[5]
						| ~b3_b0[3] & b3_b0[2] & ~b3_b0[1] & ~b3_b0[0]
																													& x15_x0[4]
						| ~b3_b0[3] & ~b3_b0[2] & b3_b0[1] & b3_b0[0] & x15_x0[3]
						| ~b3_b0[3] & ~b3_b0[2] & b3_b0[1] & ~b3_b0[0]
																													& x15_x0[2]
						| ~b3_b0[3] & ~b3_b0[2] & ~b3_b0[1] & b3_b0[0]
																													& x15_x0[1]
						| ~b3_b0[3] & ~b3_b0[2] & ~b3_b0[1] & ~b3_b0[0]
																												 & x15_x0[0];
endmodule

// implementazione via decoder
module b16to1_muxer_d(x15_x0, b3_b0, z0);
	input[15:0] x15_x0;
	input[3:0] b3_b0;
	output z0;

	wire[15:0] s15_s0;

	b4to16_decoder b3to8(b3_b0, s15_s0);

	assign z0 = s15_s0[15] & x15_x0[15] | s15_s0[14] & x15_x0[14] 
						| s15_s0[13] & x15_x0[13] | s15_s0[12] & x15_x0[12]
						| s15_s0[11] & x15_x0[11] | s15_s0[10] & x15_x0[10]
						| s15_s0[9] & x15_x0[9] | s15_s0[8] & x15_x0[8]
						| s15_s0[7] & x15_x0[7] | s15_s0[6] & x15_x0[6]
						| s15_s0[5] & x15_x0[5] | s15_s0[4] & x15_x0[4]
						| s15_s0[3] & x15_x0[3] | s15_s0[2] & x15_x0[2]
						| s15_s0[1] & x15_x0[1] | s15_s0[0] & x15_x0[0];
endmodule

// implementazione gerarchica
module b16to1_muxer_g(x15_x0, b3_b0, z0);
	input[15:0] x15_x0;
	input[3:0] b3_b0;
	output z0;

	wire [3:0] s3_s0;

	b4to1_muxer b4to1_1 (x15_x0[15:12], b3_b0[1:0], s3_s0[3]);
	b4to1_muxer b4to1_2 (x15_x0[11:8], b3_b0[1:0], s3_s0[2]);
	b4to1_muxer b4to1_3 (x15_x0[7:4], b3_b0[1:0], s3_s0[1]);
	b4to1_muxer b4to1_4 (x15_x0[3:0], b3_b0[1:0], s3_s0[0]);
	b4to1_muxer b4to1_f (s3_s0, b3_b0[3:2], z0);
endmodule
