// un decoder con enabler da 3 a 8 che prende @x2_x0 come ingresso,
// @e come enabler e attiva l'uscita @z7_z0 in codifica one-hot
module b3to8_enb_decoder(x2_x0, e, z7_z0);
	input[2:0] x2_x0;
	input e;
	output[7:0] z7_z0;

	assign z7_z0 = ({e, x2_x0} == 'B1000) ? 'B0000_0001:
								 ({e, x2_x0} == 'B1001) ? 'B0000_0010:
								 ({e, x2_x0} == 'B1010) ? 'B0000_0100:
								 ({e, x2_x0} == 'B1011) ? 'B0000_1000:
 								 ({e, x2_x0} == 'B1100) ? 'B0001_0000:
 								 ({e, x2_x0} == 'B1101) ? 'B0010_0000:
 								 ({e, x2_x0} == 'B1110) ? 'B0100_0000:
 							 	 ({e, x2_x0} == 'B1111) ? 'B1000_0000:
								 /*  		 don't care	 	 */ 'B0000_0000;
endmodule

// implementazione a porte logiche
module b3to8_enb_decoder_p(x2_x0, e, z7_z0);
	input[2:0] x2_x0;
	input e;
	output[7:0] z7_z0;

	assign z7_z0[0] = ~x2_x0[2] & ~x2_x0[1] & ~x2_x0[0] & e;
	assign z7_z0[1] = ~x2_x0[2] & ~x2_x0[1] & x2_x0[0] & e; 
	assign z7_z0[2] = ~x2_x0[2] & x2_x0[1] & ~x2_x0[0] & e; 
	assign z7_z0[3] = ~x2_x0[2] & x2_x0[1] & x2_x0[0] & e; 
	assign z7_z0[4] = x2_x0[2] & ~x2_x0[1] & ~x2_x0[0] & e; 
	assign z7_z0[5] = x2_x0[2] & ~x2_x0[1] & x2_x0[0] & e; 
	assign z7_z0[6] = x2_x0[2] & x2_x0[1] & ~x2_x0[0] & e; 
	assign z7_z0[7] = x2_x0[2] & x2_x0[1] & x2_x0[0] & e; 
endmodule

// implementazione gerarchica
module b3to8_enb_decoder_g(x2_x0, e, z7_z0);
	input[2:0] x2_x0;
	input e;
	output[7:0] z7_z0;
  
	wire[1:0] enb;
	
  b2to4_decoder b2to4_1 (x2_x0[1:0], enb[1], z7_z0[7:4]);
  b2to4_decoder b2to4_2 (x2_x0[1:0], enb[0], z7_z0[3:0]);
  b1to2_decoder b1to2_c (x2_x0[2], e, enb);
endmodule
