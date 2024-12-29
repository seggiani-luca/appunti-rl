// un demultiplexer da 1 a 2 che prende @x come ingresso, @b0 come 
// comando e @z1_z0 come uscita 
module b1to2_demuxer(x0, b0, z1_z0);
	input x0;
	input b0;
	output[1:0] z1_z0;

	assign z1_z0 = ({x0, b0} == 'B10) ? 'B01:
								 ({x0, b0} == 'B11) ? 'B10:
								 /* 	 don't care	 */ 'B00;
endmodule

// implementazione a porte logiche
module b1to2_demuxer(x0, b0, z1_z0);
	input x0;
	input b0;
	output[1:0] z1_z0;

	assign z1_z0[0] = ~x0 & b0;
	assign z1_z0[1] = x0 & b0;
endmodule
