// un multiplexer decodificato da 2 a 1 che prende @x1_x0 come 
// ingresso, @b0 come comando e @z0 come uscita
module b2to1_decoded_muxer(x1_x0, b0, z0);
	inout[1:0] x1_x0;
	input b0;
	output z0;

	wire[1:0] s1_s0;

	b1to2_decoder b1to2(b0, s1_s0);

	assign z0 = s1_s0[1] & x1_x0[1] | s1_s0[0] & x1_x0[0];
	assign x1_x0[1] = s1_s0[1] ? x1_x0[1] : 1'BZ; 
  assign x1_x0[0] = s1_s0[0] ? x1_x0[0] : 1'BZ;
endmodule
