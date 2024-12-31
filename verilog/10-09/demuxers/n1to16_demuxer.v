// un demultiplexer da 1 a 16 che prende @0 come ingresso, @b3_b0 
// come comando e @z15_z0 come uscita 
module b1to16_demuxer(x0, b3_b0, z15_z0);
	input x0;
	input[3:0] b3_b0;
	output[15:0] z15_z0;

	assign z15_z0 = ({x0, b3_b0} == 'B10000) ? 'B0000_0000_0000_0001:
									({x0, b3_b0} == 'B10001) ? 'B0000_0000_0000_0010:
									({x0, b3_b0} == 'B10010) ? 'B0000_0000_0000_0100:
									({x0, b3_b0} == 'B10011) ? 'B0000_0000_0000_1000:
									({x0, b3_b0} == 'B10100) ? 'B0000_0000_0001_0000:
									({x0, b3_b0} == 'B10101) ? 'B0000_0000_0010_0000:
									({x0, b3_b0} == 'B10110) ? 'B0000_0000_0100_0000:
									({x0, b3_b0} == 'B10111) ? 'B0000_0000_1000_0000:
									({x0, b3_b0} == 'B11000) ? 'B0000_0001_0000_0000:
									({x0, b3_b0} == 'B11001) ? 'B0000_0010_0000_0000:
									({x0, b3_b0} == 'B11010) ? 'B0000_0100_0000_0000:
									({x0, b3_b0} == 'B11011) ? 'B0000_1000_0000_0000:
									({x0, b3_b0} == 'B11100) ? 'B0001_0000_0000_0000:
									({x0, b3_b0} == 'B11101) ? 'B0010_0000_0000_0000:
									({x0, b3_b0} == 'B11110) ? 'B0100_0000_0000_0000:
									({x0, b3_b0} == 'B11111) ? 'B1000_0000_0000_0000:
									/* 	 		 don't care 	  */ 'B0000_0000_0000_0000;
endmodule

// implementazione a porte logiche
module b1to16_demuxer_p(x0, b3_b0, z15_z0);
	input x0;
	input b3_b0;
	output[15:0] z15_z0;

	assign z15_z0[0] = ~b3_b0[3] & ~b3_b0[2] & ~b3_b0[1] & ~b3_b0[0] 
																																& x0; 
	assign z15_z0[1] = ~b3_b0[3] & ~b3_b0[2] & ~b3_b0[1] & b3_b0[0] 
																																& x0; 
	assign z15_z0[2] = ~b3_b0[3] & ~b3_b0[2] & b3_b0[1] & ~b3_b0[0]
																																& x0; 
	assign z15_z0[3] = ~b3_b0[3] & ~b3_b0[2] & b3_b0[1] & b3_b0[0] 
																																& x0; 
	assign z15_z0[4] = ~b3_b0[3] & b3_b0[2] & ~b3_b0[1] & ~b3_b0[0]
																																& x0; 
	assign z15_z0[5] = ~b3_b0[3] & b3_b0[2] & ~b3_b0[1] & b3_b0[0] 
																																& x0;  
	assign z15_z0[6] = ~b3_b0[3] & b3_b0[2] & b3_b0[1] & ~b3_b0[0] 
																																& x0;  
	assign z15_z0[7] = ~b3_b0[3] & b3_b0[2] & b3_b0[1] & b3_b0[0] & x0;   
	assign z15_z0[8] = b3_b0[3] & ~b3_b0[2] & ~b3_b0[1] & ~b3_b0[0]
																																& x0;
	assign z15_z0[9] = b3_b0[3] & ~b3_b0[2] & ~b3_b0[1] & b3_b0[0] 
																																& x0; 
	assign z15_z0[10] = b3_b0[3] & ~b3_b0[2] & b3_b0[1] & ~b3_b0[0]
																																& x0;  
	assign z15_z0[11] = b3_b0[3] & ~b3_b0[2] & b3_b0[1] & b3_b0[0] 
																																& x0;   
	assign z15_z0[12] = b3_b0[3] & b3_b0[2] & ~b3_b0[1] & ~b3_b0[0]
																																& x0;
	assign z15_z0[13] = b3_b0[3] & b3_b0[2] & ~b3_b0[1] & b3_b0[0] 
																																& x0; 
	assign z15_z0[14] = b3_b0[3] & b3_b0[2] & b3_b0[1] & ~b3_b0[0] 
																																& x0; 
	assign z15_z0[15] = b3_b0[3] & b3_b0[2] & b3_b0[1] & b3_b0[0] & x0; 
endmodule

// implementazione gerarchica
module b1to16_enb_decoder_g(x0, b3_b0, z15_z0);
	input x0;
	input b3_b0;
	output[15:0] z15_z0;

	wire[3:0] enb;

  b2to4_enb_decoder b2to4_1 (b3_b30[1:0], enb[3], z15_z0[15:12]);
  b2to4_enb_decoder b2to4_2 (b3_b30[1:0], enb[2], z15_z0[11:8]);
  b2to4_enb_decoder b2to4_3 (b3_b30[1:0], enb[1], z15_z0[7:4]);
  b2to4_enb_decoder b2to4_4 (b3_b30[1:0], enb[0], z15_z0[3:0]);
  b2to4_enb_decoder b2to4_c (b3_b30[3:2], x0, enb);
endmodule
