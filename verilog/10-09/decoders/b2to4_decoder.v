// un decoder da 2 a 4 che prende @x1_x0 come ingresso e attiva 
// l'uscita @z4_z0 in codifica one-hot
module b2to4_decoder(x1_x0, z3_z0);
	input[1:0] x1_x0;
	output[3:0] z3_z0;

	assign z3_z0 = (x1_x0 == 'B00) ? 'B0001:
								 (x1_x0 == 'B01) ? 'B0010:
								 (x1_x0 == 'B10) ? 'B0100:
							 /*(x1_x0 == 'B11)?*/'B1000;
endmodule

// implementazione a porte logiche
module b2to4_decoder_p(x1_x0, z3_z0);
	input[1:0] x1_x0;
	output[3:0] z3_z0;

	assign z3_z0[0] = ~x1_x0[1] & ~x1_x0[0]; 
	assign z3_z0[1] = ~x1_x0[1] & x1_x0[0]; 
	assign z3_z0[2] = x1_x0[1] & ~x1_x0[0]; 
	assign z3_z0[3] = x1_x0[1] & x1_x0[0]; 
endmodule

// implementazione gerarchica
module b2to4_decoder_g(x1_x0, z3_z0);
	input[1:0] x1_x0;
	output[3:0] z3_z0;

  wire[1:0] x1_d;
  wire[1:0] x0_d;
  
  b1to2_decoder b1to2_1 (x1_x0[1], x1_d);
  b1to2_decoder b1to2_2 (x1_x0[0], x0_d);

 	assign z3_z0[0] = x1_d[0] & x0_d[0];
  assign z3_z0[1] = x1_d[0] & x0_d[1];
  assign z3_z0[2] = x1_d[1] & x0_d[0];
  assign z3_z0[3] = x1_d[1] & x0_d[1];
endmodule
