// un adder in base 3 che calcola @x1_x0 + @y1_y0, mettendo il 
// risultato in @s1_s0 e il riporto in @cout
module b3_adder(x1_x0, y1_y0, cin, s1_s0, cout);
	input[1:0] x1_x0, y1_y0;
	input cin;
	output[1:0] s1_s0;
	output cout;

	assign {s1_s0, cout} = ({x1_x0, y1_y0, cin} == 'B00000) ? 'B000:
												 ({x1_x0, y1_y0, cin} == 'B00001) ? 'B010:
												 ({x1_x0, y1_y0, cin} == 'B00010) ? 'B010:
												 ({x1_x0, y1_y0, cin} == 'B00011) ? 'B100:
												 ({x1_x0, y1_y0, cin} == 'B00100) ? 'B100:
												 ({x1_x0, y1_y0, cin} == 'B00101) ? 'B001:
												 ({x1_x0, y1_y0, cin} == 'B01000) ? 'B000:
												 ({x1_x0, y1_y0, cin} == 'B01001) ? 'B100:
												 ({x1_x0, y1_y0, cin} == 'B01010) ? 'B100:
												 ({x1_x0, y1_y0, cin} == 'B01011) ? 'B001:
												 ({x1_x0, y1_y0, cin} == 'B01100) ? 'B001:
												 ({x1_x0, y1_y0, cin} == 'B01101) ? 'B011:
												 ({x1_x0, y1_y0, cin} == 'B10000) ? 'B100:
												 ({x1_x0, y1_y0, cin} == 'B10001) ? 'B001:
												 ({x1_x0, y1_y0, cin} == 'B10010) ? 'B001:
												 ({x1_x0, y1_y0, cin} == 'B10011) ? 'B011:
												 ({x1_x0, y1_y0, cin} == 'B10100) ? 'B011:
												 ({x1_x0, y1_y0, cin} == 'B10101) ? 'B101:
												 /*					  don't care				 */ 'BXXX;
endmodule
