// un sottrattore a 5 cifre in base 2 che calcola @x4_x0 - @y4_y0, 
// mettendo il risultato in @d4_d0 e il riporto in @bout, aggiornato
// con un flag di overflow @ow
module n5_b2_subtractor_i(x4_x0, y4_y0, bin, d4_d0, bout, ow);
	input[4:0] x4_x0, y4_y0;
	input bin;	
	output[4:0] d4_d0;
	output bout, ow;

	wire[3:0] borrow;
	assign bout = borrow[3];

	assign ow = borrow[3] ^ borrow[2];

	b2_subtractor sub_0 (
		.x(x4_x0[0]), .y(y4_y0[0]),
		.bin(bin),
		.d(d4_d0[0]),
		.bout(borrow[0])
	);
	
	b2_subtractor sub_1 (
		.x(x4_x0[1]), .y(y4_y0[1]),
		.bin(borrow[0]),
		.d(d4_d0[1]),
		.bout(borrow[1])
	);

	b2_subtractor sub_2 (
		.x(x4_x0[2]), .y(y4_y0[2]),
		.bin(borrow[1]),
		.d(d4_d0[2]),
		.bout(borrow[2])
	);
	
	b2_subtractor sub_3 (
		.x(x4_x0[3]), .y(y4_y0[3]),
		.bin(borrow[2]),
		.d(d4_d0[3]),
		.bout(borrow[3])
	);
endmodule
