// un estensore di campo per interi in codifica BCD con LSD @x3_x0, 
// che mette in @x3_x0_est la nuova LSD
module b10_field_extensor(x3_x0, x3_x0_est);
	input[3:0] x3_x0;
	output[3:0] x3_x0_est;

	assign x3_x0_est = (x3_x0 == 'B0000) ? 'B0000:
										 (x3_x0 == 'B0001) ? 'B0000:
										 (x3_x0 == 'B0010) ? 'B0000:
										 (x3_x0 == 'B0011) ? 'B0000:
										 (x3_x0 == 'B0100) ? 'B0000:
										 (x3_x0 == 'B0101) ? 'B1001:
										 (x3_x0 == 'B0110) ? 'B1001:
										 (x3_x0 == 'B0111) ? 'B1001:
										 (x3_x0 == 'B1000) ? 'B1001:
										 (x3_x0 == 'B1001) ? 'B1001:
										 /* 	don't care	*/ 'BXXXX:
endmodule

// sintesi a porte NOR
module b10_field_extensor_n(x3_x0, x3_x0_est);
	input[3:0] x3_x0;
	output[3:0] x3_x0_est;

	wire out;
	assign out = ~(~(x3_x0[3] | x3_x0[2]) | ~(x3_x0[3] | x3_x0[1] | x3_x0[0]));

	assign x3_x0_est[3] = out; 
	assign x3_x0_est[2] = 'B0; 
	assign x3_x0_est[1] = 'B0; 
	assign x3_x0_est[0] = out; 
endmodule
