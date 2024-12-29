// un half subtractor in base 2 che calcola @x - @bin, mettendo il 
// risultato in @d e il prestito in @bout
module b2_halfsubtractor(x, bin, d, bout);
	input x, bin;
	output d, bout;

	assign {d, bout} = ({x, bin} == 'B00) ? 'B00:
										 ({x, bin} == 'B01) ? 'B11:
										 ({x, bin} == 'B10) ? 'B10:
									 /*({x, bin} == 'B11)?*/'B00;
endmodule

// implementazione a porte logiche
module b2_halfsubtractor_p(x, bin, d, bout);
	input x, bin;
	output d, bout;

	assign d = x ^ bin;
	assign bout = ~x & bin;
endmodule
