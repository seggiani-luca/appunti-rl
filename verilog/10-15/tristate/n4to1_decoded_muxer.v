// un multiplexer decodificato da 4 a 1 che prende @x3_x0 come 
// ingresso, @b1_b0 come comando e @z0 come uscita
module b4to1_decoded_muxer(x3_x0, b1_b0, z0);
	input[3:0] x3_x0;
	input[1:0] b1_b0;
	output z0;

	wire[3:0] s3_s0;

	b2to4_decoder b2to4(b1_b0, s3_s0);

	assign z0 = s3_s0[3] & x3_x0[3] | s3_s0[2] & x3_x0[2] 
						| s3_s0[1] & x3_x0[1] | s3_s0[0] & x3_x0[0];
	assign x3_x0[3] = s3_s0[3] ? x3_x0[3] : 1'BZ; 
  assign x3_x0[2] = s3_s0[2] ? x3_x0[2] : 1'BZ;
	assign x3_x0[1] = s3_s0[1] ? x3_x0[1] : 1'BZ; 
  assign x3_x0[0] = s3_s0[0] ? x3_x0[0] : 1'BZ;
endmodule
