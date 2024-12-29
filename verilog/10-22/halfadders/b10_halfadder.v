// un half adder in base 10 che calcola @x3_x0 + @cin, mettendo il 
// risultato in @s3_s0 e il riporto in @cout
module b10_halfadder(x3_x0, cin, s3_s0, cout);
	input[3:0] x3_x0;
	input cin;
	output[3:0] s3_s0;
	output cout;

	assign {s3_s0, cout} = ({x3_x0, cin} == 'B00000) ? 'B00000:
												 ({x3_x0, cin} == 'B00001) ? 'B00010:
											 	 ({x3_x0, cin} == 'B00010) ? 'B00010:
											 	 ({x3_x0, cin} == 'B00011) ? 'B00100:
											 	 ({x3_x0, cin} == 'B00100) ? 'B00100:
											 	 ({x3_x0, cin} == 'B00101) ? 'B00110:
											 	 ({x3_x0, cin} == 'B00110) ? 'B00110:
											 	 ({x3_x0, cin} == 'B00111) ? 'B01000:
											 	 ({x3_x0, cin} == 'B01000) ? 'B01000:
											 	 ({x3_x0, cin} == 'B01001) ? 'B01010:
											 	 ({x3_x0, cin} == 'B01010) ? 'B01010:
											 	 ({x3_x0, cin} == 'B01011) ? 'B01100:
											 	 ({x3_x0, cin} == 'B01100) ? 'B01100:
											 	 ({x3_x0, cin} == 'B01101) ? 'B01110:
											 	 ({x3_x0, cin} == 'B01110) ? 'B01110:
											 	 ({x3_x0, cin} == 'B01111) ? 'B10000:
											 	 ({x3_x0, cin} == 'B10000) ? 'B10000:
											 	 ({x3_x0, cin} == 'B10001) ? 'B10010:
											 	 ({x3_x0, cin} == 'B10010) ? 'B10010:
											 	 ({x3_x0, cin} == 'B10011) ? 'B00001:
											 	 /* 		  don't care 		  */ 'BXXXXX;
endmodule

// implementazione a porte logiche
module b10_halfadder_p(x3_x0, cin, s3_s0, cout);
	input[3:0] x3_x0;
	wire x3 = x3_x0[3];
	wire x2 = x3_x0[2];
	wire x1 = x3_x0[1];
	wire x0 = x3_x0[0];

	input cin;
	
	output[3:0] s3_s0;
	output cout;
	
	assign s3_s0[3] = ~x3 & x2 & x1 & x0 & cin | x3 & ~x0 | x3 & ~cin;
	assign s3_s0[2] = ~x2 & x1 & x0 & cin | x2 & ~x1 | x2 & ~x0 |
										 x2 & ~cin;
	assign s3_s0[1] = ~x3 & ~x1 & x0 & cin | x1 & ~x0 | x1 & ~cin;
	assign s3_s0[0] = x0 ^ cin;
	assign cout = x3 & x0 & cin;
endmodule
