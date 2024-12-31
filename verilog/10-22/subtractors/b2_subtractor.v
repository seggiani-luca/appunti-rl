// un sottrattore in base 2 che calcola @x - @y, mettendo il 
// risultato in @d e il prestito uscente in @bout
module b2_subtractor(x, y, bin, d, bout);
	input x, y, bin;
	output d, bout;

	wire y_;
	assign y_ = ~y;
	
	wire cin;
	assign cin = ~bin;

	wire cout;
	assign bout = ~cout;

	b2_adder addr(x, y_, cin, d, cout);
endmodule
