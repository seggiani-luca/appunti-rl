// un complementatore a una cifra in base 10 con ingresso @x e uscita
// @z
module b10_complementer(x3_x0, z3_z0);
	input[3:0] x3_x0;
	output[3:0] z3_z0;

	assign z3_z0 = (x3_x0 == 'B0000) ? 'B1001:
								 (x3_x0 == 'B0001) ? 'B1000:
								 (x3_x0 == 'B0010) ? 'B0111:
								 (x3_x0 == 'B0011) ? 'B0110:
								 (x3_x0 == 'B0100) ? 'B0101:
								 (x3_x0 == 'B0101) ? 'B0100:
								 (x3_x0 == 'B0110) ? 'B0011:
								 (x3_x0 == 'B0111) ? 'B0010:
								 (x3_x0 == 'B1000) ? 'B0001:
								 (x3_x0 == 'B1001) ? 'B0000:
								 /*		don't care	*/ 'BXXXX;
endmodule

// implementazione a porte logiche
module b10_complementer_b(x3_x0, z3_z0);
	input[3:0] x3_x0;
	output[3:0] z3_z0;
	
	assign z3_z0[3] = ~x3_x0[3] & ~x3_x0[2] & ~x3_x0[1];
	assign z3_z0[2] = ~x3_x0[3] & ~x3_x0[2] & x3_x0[1] | x3_x0[2] & ~x3_x0[1];
	assign z3_z0[1] = x3_x0[1];
	assign z3_z0[0] = ~x3_x0[0];
endmodule
