// un decoder da 3 a 8 che prende @x2_x0 come ingresso e attiva 
// l'uscita @z7_z0 in codifica one-hot
module b3to8_decoder(x2_x0, z7_z0);
	input[2:0] x2_x0;
	output[7:0] z7_z0;

	assign z7_z0 = (x2_x0 == 'B000) ? 'B0000_0001:
								 (x2_x0 == 'B001) ? 'B0000_0010:
								 (x2_x0 == 'B010) ? 'B0000_0100:
								 (x2_x0 == 'B011) ? 'B0000_1000:
 								 (x2_x0 == 'B100) ? 'B0001_0000:
 								 (x2_x0 == 'B101) ? 'B0010_0000:
 								 (x2_x0 == 'B110) ? 'B0100_0000:
 							 /*(x2_x0 == 'B111)?*/'B1000_0000;
endmodule

// implementazione a porte logiche
module b3to8_decoder_p(x2_x0, z7_z0);
	input[2:0] x2_x0;
	output[7:0] z7_z0;

	assign z7_z0[0] = ~x2_x0[2] & ~x2_x0[1] & ~x2_x0[0]; 
	assign z7_z0[1] = ~x2_x0[2] & ~x2_x0[1] & x2_x0[0]; 
	assign z7_z0[2] = ~x2_x0[2] & x2_x0[1] & ~x2_x0[0]; 
	assign z7_z0[3] = ~x2_x0[2] & x2_x0[1] & x2_x0[0]; 
	assign z7_z0[4] = x2_x0[2] & ~x2_x0[1] & ~x2_x0[0]; 
	assign z7_z0[5] = x2_x0[2] & ~x2_x0[1] & x2_x0[0]; 
	assign z7_z0[6] = x2_x0[2] & x2_x0[1] & ~x2_x0[0]; 
	assign z7_z0[7] = x2_x0[2] & x2_x0[1] & x2_x0[0]; 
endmodule

// implementazione gerarchica
module b3to8_decoder_g(x2_x0, z7_z0);
	input[2:0] x2_x0;
	output[7:0] z7_z0;

  wire[1:0] x2_d;
  wire[3:0] x1_x0_d;
  
  b1to2_decoder b1to2 (x2_x0[2], x2_d);
  b2to4_decoder b2to4 (x2_x0[1:0], x1_x0_d);

 	assign z7_z0[0] = x2_d[0] & x1_x0_d[0];
 	assign z7_z0[1] = x2_d[0] & x1_x0_d[1];
 	assign z7_z0[2] = x2_d[0] & x1_x0_d[2];
 	assign z7_z0[3] = x2_d[0] & x1_x0_d[3];
 	assign z7_z0[4] = x2_d[1] & x1_x0_d[0];
 	assign z7_z0[5] = x2_d[1] & x1_x0_d[1];
 	assign z7_z0[6] = x2_d[1] & x1_x0_d[2];
 	assign z7_z0[7] = x2_d[1] & x1_x0_d[3];
endmodule
