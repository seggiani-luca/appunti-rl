// un multiplexer decodificato da 8 a 1 che prende @x7_x0 come 
// ingresso, @b2_b0 come comando e @z0 come uscita
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
	assign x7_x0[7] = s7_s0[7] ? x7_x0[7] : 1'BZ; 
	assign x7_x0[6] = s7_s0[6] ? x7_x0[6] : 1'BZ; 
  assign x7_x0[5] = s7_s0[5] ? x7_x0[5] : 1'BZ;
  assign x7_x0[4] = s7_s0[4] ? x7_x0[4] : 1'BZ;
	assign x7_x0[3] = s7_s0[3] ? x7_x0[3] : 1'BZ; 
	assign x7_x0[2] = s7_s0[2] ? x7_x0[2] : 1'BZ; 
  assign x7_x0[1] = s7_s0[1] ? x7_x0[1] : 1'BZ;
  assign x7_x0[0] = s7_s0[0] ? x7_x0[0] : 1'BZ;
endmodule
