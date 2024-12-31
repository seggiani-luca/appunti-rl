// un decoder da 1 a 2 che prende @x0 come ingresso e attiva l'uscita 
// @z1_z0 in codifica one-hot
module b1to2_decoder(x0, z1_z0);
	input x0;
	output[1:0] z1_z0;

	assign z1_z0 = (x0 == 'B0) ? 'B01:
							 /*(x0 == 'B1)?*/'B10;
endmodule

// implementazione a porte logiche
module b1to2_decoder_p(x0, z1_z0);
	input x0;
	output[1:0] z1_z0;

	assign z1_z0[0] = ~x0;
	assign z1_z0[1] = x0;
endmodule
