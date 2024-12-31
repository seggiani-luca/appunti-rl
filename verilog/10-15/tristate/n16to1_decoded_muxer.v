// un multiplexer decodificato da 16 a 1 che prende @x15_x0 come 
// ingresso, @b3_b0 come comando e @z0 come uscita
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
	assign x15_x0[15] = s15_s0[15] ? x15_x0[15] : 1'BZ; 
	assign x15_x0[14] = s15_s0[14] ? x15_x0[14] : 1'BZ; 
	assign x15_x0[13] = s15_s0[13] ? x15_x0[13] : 1'BZ; 
  assign x15_x0[12] = s15_s0[12] ? x15_x0[12] : 1'BZ;
  assign x15_x0[11] = s15_s0[11] ? x15_x0[11] : 1'BZ;
	assign x15_x0[10] = s15_s0[10] ? x15_x0[10] : 1'BZ; 
  assign x15_x0[9] = s15_s0[9] ? x15_x0[0] : 1'BZ;
  assign x15_x0[8] = s15_s0[8] ? x15_x0[0] : 1'BZ;
	assign x15_x0[7] = s15_s0[7] ? x15_x0[1] : 1'BZ; 
	assign x15_x0[6] = s15_s0[6] ? x15_x0[1] : 1'BZ; 
	assign x15_x0[5] = s15_s0[5] ? x15_x0[1] : 1'BZ; 
  assign x15_x0[4] = s15_s0[4] ? x15_x0[0] : 1'BZ;
  assign x15_x0[3] = s15_s0[3] ? x15_x0[0] : 1'BZ;
	assign x15_x0[2] = s15_s0[2] ? x15_x0[1] : 1'BZ; 
  assign x15_x0[1] = s15_s0[1] ? x15_x0[0] : 1'BZ;
  assign x15_x0[0] = s15_s0[0] ? x15_x0[0] : 1'BZ;
endmodule
