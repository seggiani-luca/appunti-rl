// un half adder in base 3 che calcola @x1_x0 + @cin, mettendo il 
// risultato in @s1_s0 e il riporto in @cout
module b3_halfadder(x1_x0, cin, s1_s0, cout);
	input[1:0] x1_x0;
	input cin;
	output[1:0] s1_s0;
	output cout;

	assign {s1_s0, cout} = ({x1_x0, cin} == 'B000) ? 'B000:
										 		 ({x1_x0, cin} == 'B001) ? 'B010:
										 		 ({x1_x0, cin} == 'B010) ? 'B010:
										 		 ({x1_x0, cin} == 'B011) ? 'B100:
										 		 ({x1_x0, cin} == 'B100) ? 'B100:
										 		 ({x1_x0, cin} == 'B101) ? 'B001:
										 		 /* 		 don't care 		*/ 'BXXX;
endmodule

// implementazione a porte logiche
module b3_halfadder_p(x1_x0, cin, s1_s0, cout);
	input[1:0] x1_x0;
	wire x1 = x1_x0[1];
	wire x0 = x1_x0[0];

	input cin;
	
	output[1:0] s1_s0;	
	output cout;

	assign s1_s0[1] = (x1 & ~cin) | (x0 & cin);
	assign s1_s0[0] = (x0 & ~cin) | ~x1 & ~x0 & cin;
	assign cout = x1 & cin;
endmodule
