// un decoder con enabler da 1 a 2 che prende @x0 come ingresso, @e
// come enabler e attiva l'uscita @z1_z0 in codifica one-hot
module b1to2_enb_decoder(x0, e, z1_z0);
	input x0;
	input e;
	output[1:0] z1_z0;

	assign z1_z0 = ({e, x0} == 'B10) ? 'B01:
								 ({e, x0} == 'B11) ? 'B10:
								 /* 	don't care	*/ 'B00;
endmodule

// implementazione a porte logiche
module b1to2_enb_decoder_p(x0, e, z1_z0);
	input x0;
	input e;
	output[1:0] z1_z0;

	assign z1_z0[0] = ~x0 & e;
	assign z1_z0[1] = x0 & e;
endmodule
