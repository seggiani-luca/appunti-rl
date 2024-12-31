// un decoder con enabler da 2 a 4 che prende @x1_x0 come ingresso,
// @e come enabler e attiva l'uscita @z4_z0 in codifica one-hot
module b2to4_enb_decoder(x1_x0, e, z3_z0);
	input[1:0] x1_x0;
	input e;
	output[3:0] z3_z0;

	assign z3_z0 = ({e, x1_x0} == 'B100) ? 'B0001:
								 ({e, x1_x0} == 'B101) ? 'B0010:
								 ({e, x1_x0} == 'B110) ? 'B0100:
								 ({e, x1_x0} == 'B111) ? 'B1000:
							 	 /* 		don't care		*/ 'B0000;
endmodule

// implementazione a porte logiche
module b2to4_enb_decoder_p(x1_x0, e, z3_z0);
	input[1:0] x1_x0;
	input e;
	output[3:0] z3_z0;

	assign z3_z0[0] = ~x1_x0[1] & ~x1_x0[0] & e;
	assign z3_z0[1] = ~x1_x0[1] & x1_x0[0] & e; 
	assign z3_z0[2] = x1_x0[1] & ~x1_x0[0] & e; 
	assign z3_z0[3] = x1_x0[1] & x1_x0[0] & e; 
endmodule

// implementazione gerarchica
module b2to4_enb_decoder_g(x1_x0, e, z3_z0);
	input[1:0] x1_x0;
	input e;
	output[3:0] z3_z0;

	wire[1:0] enb;

  b1to2_enb_decoder b1to2_1 (x1_x0[0], enb[1], z3_z0[3:2]);
  b1to2_enb_decoder b1to2_2 (x1_x0[0], enb[0], z3_z0[1:0]);
  b1to2_enb_decoder b1to2_c (x1_x0[1], e, enb);
endmodule
