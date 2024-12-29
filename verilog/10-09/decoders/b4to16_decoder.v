// un decoder da 4 a 16 che prende @x3_x0 come ingresso e attiva 
// l'uscita @z15_z0 in codifica one-hot
module b4to16_decoder(x3_x0, z15_z0);
	input[3:0] x3_x0;
	output[15:0] z15_z0;

	assign z15_z0 = (x3_x0 == 'B0000) ? 'B0000_0000_0000_0001:
									(x3_x0 == 'B0001) ? 'B0000_0000_0000_0010:
									(x3_x0 == 'B0010) ? 'B0000_0000_0000_0100:
									(x3_x0 == 'B0011) ? 'B0000_0000_0000_1000:
									(x3_x0 == 'B0100) ? 'B0000_0000_0001_0000:
									(x3_x0 == 'B0101) ? 'B0000_0000_0010_0000:
									(x3_x0 == 'B0110) ? 'B0000_0000_0100_0000:
									(x3_x0 == 'B0111) ? 'B0000_0000_1000_0000:
									(x3_x0 == 'B1000) ? 'B0000_0001_0000_0000:
									(x3_x0 == 'B1001) ? 'B0000_0010_0000_0000:
									(x3_x0 == 'B1010) ? 'B0000_0100_0000_0000:
									(x3_x0 == 'B1011) ? 'B0000_1000_0000_0000:
									(x3_x0 == 'B1100) ? 'B0001_0000_0000_0000:
									(x3_x0 == 'B1101) ? 'B0010_0000_0000_0000:
									(x3_x0 == 'B1110) ? 'B0100_0000_0000_0000:
								/*(x3_x0 == 'B1111)?*/'B1000_0000_0000_0000;
endmodule

// implementazione a porte logiche
module b4to16_decoder_p(x3_x0, z15_z0);
	input[3:0] x3_x0;
	output[15:0] z15_z0;

	assign z15_z0[0] = ~x3_x0[3] & ~x3_x0[2] & ~x3_x0[1] & ~x3_x0[0]; 
	assign z15_z0[1] = ~x3_x0[3] & ~x3_x0[2] & ~x3_x0[1] & x3_x0[0]; 
	assign z15_z0[2] = ~x3_x0[3] & ~x3_x0[2] & x3_x0[1] & ~x3_x0[0]; 
	assign z15_z0[3] = ~x3_x0[3] & ~x3_x0[2] & x3_x0[1] & x3_x0[0]; 
	assign z15_z0[4] = ~x3_x0[3] & x3_x0[2] & ~x3_x0[1] & ~x3_x0[0]; 
	assign z15_z0[5] = ~x3_x0[3] & x3_x0[2] & ~x3_x0[1] & x3_x0[0];  
	assign z15_z0[6] = ~x3_x0[3] & x3_x0[2] & x3_x0[1] & ~x3_x0[0];  
	assign z15_z0[7] = ~x3_x0[3] & x3_x0[2] & x3_x0[1] & x3_x0[0];   
	assign z15_z0[8] = x3_x0[3] & ~x3_x0[2] & ~x3_x0[1] & ~x3_x0[0];
	assign z15_z0[9] = x3_x0[3] & ~x3_x0[2] & ~x3_x0[1] & x3_x0[0]; 
	assign z15_z0[10] = x3_x0[3] & ~x3_x0[2] & x3_x0[1] & ~x3_x0[0];  
	assign z15_z0[11] = x3_x0[3] & ~x3_x0[2] & x3_x0[1] & x3_x0[0];   
	assign z15_z0[12] = x3_x0[3] & x3_x0[2] & ~x3_x0[1] & ~x3_x0[0];
	assign z15_z0[13] = x3_x0[3] & x3_x0[2] & ~x3_x0[1] & x3_x0[0]; 
	assign z15_z0[14] = x3_x0[3] & x3_x0[2] & x3_x0[1] & ~x3_x0[0]; 
	assign z15_z0[15] = x3_x0[3] & x3_x0[2] & x3_x0[1] & x3_x0[0]; 
endmodule

// implementazione gerarchica
module b4to16_decoder_g(x3_x0, z15_z0);
	input[3:0] x3_x0;
	output[15:0] z15_z0;

	wire[3:0] x3_x2_d;
  wire[3:0] x1_x0_d;
  
  b2to4_decoder b2to4_1 (x3_x0[3:2], x3_x2_d);
  b2to4_decoder b2to4_2 (x3_x0[1:0], x1_x0_d);

 	assign z15_z0[0] = x3_x2_d[0] & x1_x0_d[0];
 	assign z15_z0[1] = x3_x2_d[0] & x1_x0_d[1];
 	assign z15_z0[2] = x3_x2_d[0] & x1_x0_d[2];
 	assign z15_z0[3] = x3_x2_d[0] & x1_x0_d[3];
 	assign z15_z0[4] = x3_x2_d[1] & x1_x0_d[0];
 	assign z15_z0[5] = x3_x2_d[1] & x1_x0_d[1];
 	assign z15_z0[6] = x3_x2_d[1] & x1_x0_d[2];
 	assign z15_z0[7] = x3_x2_d[1] & x1_x0_d[3];
 	assign z15_z0[8] = x3_x2_d[2] & x1_x0_d[0];
 	assign z15_z0[9] = x3_x2_d[2] & x1_x0_d[1];
 	assign z15_z0[10] = x3_x2_d[2] & x1_x0_d[2];
 	assign z15_z0[11] = x3_x2_d[2] & x1_x0_d[3];
 	assign z15_z0[12] = x3_x2_d[3] & x1_x0_d[0];
 	assign z15_z0[13] = x3_x2_d[3] & x1_x0_d[1];
 	assign z15_z0[14] = x3_x2_d[3] & x1_x0_d[2];
 	assign z15_z0[15] = x3_x2_d[3] & x1_x0_d[3];
endmodule
