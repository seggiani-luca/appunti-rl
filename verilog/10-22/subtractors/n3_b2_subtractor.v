// un sottrattore a 2 cifre in base 2 che calcola @x2_x0 - @y2_y0, 
// mettendo il risultato in @d2_d0 e il riporto in @bout
module n3_b2_subtractor(x2_x0, y2_y0, bin, d2_d0, bout);
	input[2:0] x2_x0, y2_y0;
	input bin;	
	output[2:0] d2_d0;
	output bout;

	wire[1:0] borrow;

	b2_subtractor sub_0 (
		.x(x2_x0[0]), .y(y2_y0[0]),
		.bin(bin),
		.d(d2_d0[0]),
		.bout(borrow[0])
	);
	
	b2_subtractor sub_1 (
		.x(x2_x0[1]), .y(y2_y0[1]),
		.bin(borrow[0]),
		.d(d2_d0[1]),
		.bout(borrow[1])
	);
	
	b2_subtractor sub_2 (
		.x(x2_x0[2]), .y(y2_y0[2]),
		.bin(borrow[1]),
		.d(d2_d0[2]),
		.bout(bout)
	);
endmodule
