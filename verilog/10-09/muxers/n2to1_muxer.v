// un multiplexer da 2 a 1 che prende @x1_x0 come ingresso, @b0 come
// comando e @z0 come uscita
module b2to1_muxer(x1_x0, b0, z0);
	input[1:0] x1_x0;
	input b0;
	output z0;

	assign z0 = (b0 == 'B0) ? x1_x0[0]:
						/*(b0 == 'B1)?*/x1_x0[1];
endmodule

// implementazione a porte logiche
module b2to1_muxer_p(x1_x0, b0, z0);
	input[1:0] x1_x0;
	input b0;
	output z0;

	assign z0 = b0 & x1_x0[1] | ~b0 & x1_x0[0];
endmodule

// implementazione via decoder 
module b2to1_muxer_d(x1_x0, b0, z0);
	input[1:0] x1_x0;
	input b0;
	output z0;

	wire[1:0] s1_s0;

	b1to2_decoder b1to2(b0, s1_s0);

	assign z0 = s1_s0[1] & x1_x0[1] | s1_s0[0] & x1_x0[0];
endmodule
