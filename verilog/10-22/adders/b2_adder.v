// un adder in base 2 che calcola @x + @y, mettendo il risultato in 
// @s e il riporto in @cout
module b2_adder(x, y, cin, s, cout);
	input x, y, cin;
	output s, cout;

	assign {s, cout} = ({x, y, cin} == 'B000) ? 'B00:
										 ({x, y, cin} == 'B001) ? 'B10:
										 ({x, y, cin} == 'B010) ? 'B10:
										 ({x, y, cin} == 'B011) ? 'B01:
										 ({x, y, cin} == 'B100) ? 'B10:
										 ({x, y, cin} == 'B101) ? 'B01:
										 ({x, y, cin} == 'B110) ? 'B01:
									 /*({x, y, cin} == 'B111)?*/'B11;
endmodule

// implementazione a porte logiche
module b2_adder_p(x, y, cin, s, cout);
	input x, y, cin;
	output s, cout;

	wire x_xor_y;
	assign x_xor_y = x ^ y;

	assign s = (x_xor_y) ^ cin;
	assign cout = x & y | x_xor_y & cin;
endmodule
