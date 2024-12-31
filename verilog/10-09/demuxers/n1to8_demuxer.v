// un demultiplexer da 1 a 8 che prende @x0 come ingresso, @b2_b0 
// come comando e @z7_z0 come uscita 
module b1to8_demuxer(x0, b2_b0, z7_z0);
	input x0;
	input[2:0] b2_b0;
	output[7:0] z7_z0;

	assign z7_z0 = ({x0, b2_b0} == 'B1000) ? 'B0000_0001:
								 ({x0, b2_b0} == 'B1001) ? 'B0000_0010:
								 ({x0, b2_b0} == 'B1010) ? 'B0000_0100:
								 ({x0, b2_b0} == 'B1011) ? 'B0000_1000:
 								 ({x0, b2_b0} == 'B1100) ? 'B0001_0000:
 								 ({x0, b2_b0} == 'B1101) ? 'B0010_0000:
 								 ({x0, b2_b0} == 'B1110) ? 'B0100_0000:
 							 	 ({x0, b2_b0} == 'B1111) ? 'B1000_0000:
								 /*  	   don't care	 	  */ 'B0000_0000;
endmodule

// implementazione a porte logiche
module b1to8_demuxer_p(x0, b2_b0, z7_z0);
	input x0;
	input[2:0] b2_b0;
	output[7:0] z7_z0;

	assign z7_z0[0] = ~b2_b0[2] & ~b2_b0[1] & ~b2_b0[0] & x0;
	assign z7_z0[1] = ~b2_b0[2] & ~b2_b0[1] & b2_b0[0] & x0; 
	assign z7_z0[2] = ~b2_b0[2] & b2_b0[1] & ~b2_b0[0] & x0; 
	assign z7_z0[3] = ~b2_b0[2] & b2_b0[1] & b2_b0[0] & x0; 
	assign z7_z0[4] = b2_b0[2] & ~b2_b0[1] & ~b2_b0[0] & x0; 
	assign z7_z0[5] = b2_b0[2] & ~b2_b0[1] & b2_b0[0] & x0; 
	assign z7_z0[6] = b2_b0[2] & b2_b0[1] & ~b2_b0[0] & x0; 
	assign z7_z0[7] = b2_b0[2] & b2_b0[1] & b2_b0[0] & x0; 
endmodule

// implementazione gerarchica
module b1to8_demuxer_g(x0, b2_b0, z7_z0);
	input x0;
	input[2:0] b2_b0;
	output[7:0] z7_z0;
  
	wire[1:0] enb;
	
  b2to4_demuxer b2to4_1 (b2_b0[1:0], enb[1], z7_z0[7:4]);
  b2to4_demuxer b2to4_2 (b2_b0[1:0], enb[0], z7_z0[3:0]);
  b1to2_demuxer b1to2_c (b2_b0[2], x0, enb);
endmodule
