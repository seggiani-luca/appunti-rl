// un demultiplexer da 1 a 4 che prende @x0 come ingresso, @b1_b0 
// come comando e @z4_z0 come uscita 
module b1to4_demuxer(x0, b3_b0, z3_z0);
	input x0;
	input[1:0] b1_b0;
	output[3:0] z3_z0;

	assign z3_z0 = ({x0, b3_b0} == 'B100) ? 'B0001:
								 ({x0, b3_b0} == 'B101) ? 'B0010:
								 ({x0, b3_b0} == 'B110) ? 'B0100:
								 ({x0, b3_b0} == 'B111) ? 'B1000:
							 	 /* 	 	 don't care		 */ 'B0000;
endmodule

// implementazione a porte logiche
module b1to4_demuxer(x0, b1_b0, z3_z0);
	input x0;
	input[1:0] b1_b0;
	output[3:0] z3_z0;

	assign z3_z0[0] = ~b1_b0[1] & ~x1_x0[0] & x0;
	assign z3_z0[1] = ~b1_b0[1] & x1_x0[0] & x0; 
	assign z3_z0[2] = b1_b0[1] & ~x1_x0[0] & x0; 
	assign z3_z0[3] = b1_b0[1] & x1_x0[0] & x0; 
endmodule

// implementazione gerarchica
module b1to4_demuxer(x0, b1_b0, z3_z0);
	input x0;
	input[1:0] b1_b0;
	output[3:0] z3_z0;

	wire[1:0] enb;

  b1to2_demuxer b1to2_1 (b1_b0[0], enb[1], z3_z0[3:2]);
  b1to2_demuxer b1to2_2 (b1_b0[0], enb[0], z3_z0[1:0]);
  b1to2_demuxer b1to2_c (b1_b0[1], x0, enb);
endmodule
