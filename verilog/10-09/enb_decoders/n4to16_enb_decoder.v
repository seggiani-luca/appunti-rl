// un decoder con enabler da 4 a 16 che prende @x3_x0 come ingresso,
// @e come enabler e attiva l'uscita @z15_z0 in codifica one-hot
module b4to16_enb_decoder(x3_x0, e, z15_z0);
	input[3:0] x3_x0;
	input e;
	output[15:0] z15_z0;

	assign z15_z0 = ({e, x3_x0} == 'B10000) ? 'B0000_0000_0000_0001:
									({e, x3_x0} == 'B10001) ? 'B0000_0000_0000_0010:
									({e, x3_x0} == 'B10010) ? 'B0000_0000_0000_0100:
									({e, x3_x0} == 'B10011) ? 'B0000_0000_0000_1000:
									({e, x3_x0} == 'B10100) ? 'B0000_0000_0001_0000:
									({e, x3_x0} == 'B10101) ? 'B0000_0000_0010_0000:
									({e, x3_x0} == 'B10110) ? 'B0000_0000_0100_0000:
									({e, x3_x0} == 'B10111) ? 'B0000_0000_1000_0000:
									({e, x3_x0} == 'B11000) ? 'B0000_0001_0000_0000:
									({e, x3_x0} == 'B11001) ? 'B0000_0010_0000_0000:
									({e, x3_x0} == 'B11010) ? 'B0000_0100_0000_0000:
									({e, x3_x0} == 'B11011) ? 'B0000_1000_0000_0000:
									({e, x3_x0} == 'B11100) ? 'B0001_0000_0000_0000:
									({e, x3_x0} == 'B11101) ? 'B0010_0000_0000_0000:
									({e, x3_x0} == 'B11110) ? 'B0100_0000_0000_0000:
									({e, x3_x0} == 'B11111) ? 'B1000_0000_0000_0000:
									/* 	 		 don't care 	 */ 'B0000_0000_0000_0000;
endmodule

// implementazione a porte logiche
module b4to16_enb_decoder_p(x3_x0, e, z15_z0);
	input[3:0] x3_x0;
	input e;
	output[15:0] z15_z0;

	assign z15_z0[0] = ~x3_x0[3] & ~x3_x0[2] & ~x3_x0[1] & ~x3_x0[0] 
																																 & e; 
	assign z15_z0[1] = ~x3_x0[3] & ~x3_x0[2] & ~x3_x0[1] & x3_x0[0] 
																																 & e; 
	assign z15_z0[2] = ~x3_x0[3] & ~x3_x0[2] & x3_x0[1] & ~x3_x0[0]
																																 & e; 
	assign z15_z0[3] = ~x3_x0[3] & ~x3_x0[2] & x3_x0[1] & x3_x0[0] & e; 
	assign z15_z0[4] = ~x3_x0[3] & x3_x0[2] & ~x3_x0[1] & ~x3_x0[0]
																																 & e; 
	assign z15_z0[5] = ~x3_x0[3] & x3_x0[2] & ~x3_x0[1] & x3_x0[0] & e;  
	assign z15_z0[6] = ~x3_x0[3] & x3_x0[2] & x3_x0[1] & ~x3_x0[0] & e;  
	assign z15_z0[7] = ~x3_x0[3] & x3_x0[2] & x3_x0[1] & x3_x0[0] & e;   
	assign z15_z0[8] = x3_x0[3] & ~x3_x0[2] & ~x3_x0[1] & ~x3_x0[0]
																																 & e;
	assign z15_z0[9] = x3_x0[3] & ~x3_x0[2] & ~x3_x0[1] & x3_x0[0] & e; 
	assign z15_z0[10] = x3_x0[3] & ~x3_x0[2] & x3_x0[1] & ~x3_x0[0]
																																 & e;  
	assign z15_z0[11] = x3_x0[3] & ~x3_x0[2] & x3_x0[1] & x3_x0[0] & e;   
	assign z15_z0[12] = x3_x0[3] & x3_x0[2] & ~x3_x0[1] & ~x3_x0[0]
																																 & e;
	assign z15_z0[13] = x3_x0[3] & x3_x0[2] & ~x3_x0[1] & x3_x0[0] & e; 
	assign z15_z0[14] = x3_x0[3] & x3_x0[2] & x3_x0[1] & ~x3_x0[0] & e; 
	assign z15_z0[15] = x3_x0[3] & x3_x0[2] & x3_x0[1] & x3_x0[0] & e; 
endmodule

// implementazione gerarchica
module b4to16_enb_decoder_g(x3_x0, e, z15_z0);
	input[3:0] x3_x0;
	input e;
	output[15:0] z15_z0;

	wire[3:0] enb;

  b2to4_enb_decoder b2to4_1 (x3_x0[1:0], enb[3], z15_z0[15:12]);
  b2to4_enb_decoder b2to4_2 (x3_x0[1:0], enb[2], z15_z0[11:8]);
  b2to4_enb_decoder b2to4_3 (x3_x0[1:0], enb[1], z15_z0[7:4]);
  b2to4_enb_decoder b2to4_4 (x3_x0[1:0], enb[0], z15_z0[3:0]);
  b2to4_enb_decoder b2to4_c (x3_x0[3:2], e, enb);
endmodule
