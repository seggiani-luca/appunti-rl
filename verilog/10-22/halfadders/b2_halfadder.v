// un half adder in base 2 che calcola @x + @cin, mettendo il 
// risultato in @s e il riporto in @cout
module b2_halfadder(x, cin, s, cout);
	input x, cin;
	output s, cout;

	assign {s, cout} = ({x, cin} == 'B00) ? 'B00:
										 ({x, cin} == 'B01) ? 'B10:
										 ({x, cin} == 'B10) ? 'B10:
									 /*({x, cin} == 'B11)?*/'B01;
endmodule

// implementazione a porte logiche
module b2_halfadder_p(x, cin, s, cout);
	input x, cin;
	output s, cout;

	assign s = x ^ cin;
	assign cout = x & cin;
endmodule
