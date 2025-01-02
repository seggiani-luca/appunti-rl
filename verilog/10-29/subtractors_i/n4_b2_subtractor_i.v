// un sottrattore a 4 cifre in base 2 che calcola @x3_x0 - @y3_y0, 
// mettendo il risultato in @d3_d0 e il riporto in @bout, aggiornato
// con un flag di overflow @ow
module n4_b2_subtractor_i(x3_x0, y3_y0, bin, d3_d0, bout, ow);
	input[3:0] x3_x0, y3_y0;
	input bin;	
	output[3:0] d3_d0;
	output bout, ow;

	wire[3:0] borrow;
	assign bout = borrow[3];

	assign ow = borrow[3] ^ borrow[2];

	b2_subtractor sub_0 (
		.x(x3_x0[0]), .y(y3_y0[0]),
		.bin(bin),
		.d(d3_d0[0]),
		.bout(borrow[0])
	);
	
	b2_subtractor sub_1 (
		.x(x3_x0[1]), .y(y3_y0[1]),
		.bin(borrow[0]),
		.d(d3_d0[1]),
		.bout(borrow[1])
	);

	b2_subtractor sub_2 (
		.x(x3_x0[2]), .y(y3_y0[2]),
		.bin(borrow[1]),
		.d(d3_d0[2]),
		.bout(borrow[2])
	);
	
	b2_subtractor sub_3 (
		.x(x3_x0[3]), .y(y3_y0[3]),
		.bin(borrow[2]),
		.d(d3_d0[3]),
		.bout(borrow[3])
	);
endmodule

// implementazione con adder a 4 bit
module n4_b2_subtractor_i_a(x3_x0, y3_y0, bin, d3_d0, bout, ow);
	input[3:0] x3_x0, y3_y0;
	input bin;	
	output[3:0] d3_d0;
	output bout, ow;

	wire[3:0] y3_y0_neg;
	assign y3_y0_neg = ~y3_y0;
	
	wire cin;
	assign cin = ~bin;

	wire cout;
	assign bout = ~cout;

	n4_b2_adder addr (
		.x3_x0(x3_x0), .y3_y0(y3_y0_neg),
		.cin(cin),
		.s3_s0(d3_d0),
		.cout(cout),
		.ow(ow)
	);
endmodule
