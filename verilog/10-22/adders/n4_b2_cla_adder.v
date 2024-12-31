// un adder CLA a 4 cifre in base 2 che calcola @x3_x0 + @y3_y0, 
// mettendo il risultato in @s3_s0 e il riporto in @cout
module n4_b2_adder(x3_x0, y3_y0, cin, s3_s0, cout);
	input[3:0] x3_x0, y3_y0;
	input cin;	
	output[3:0] s3_s0;
	output cout;

	wire[2:0] carry;

	n4_b2_cla cla(x3_x0, y3_y0, cin, {cout, carry});

	b2_adder add_0 (
		.x(x3_x0[0]), .y(y3_y0[0]),
		.cin(cin),
		.s(s3_s0[0])
	);
	
	b2_adder add_1 (
		.x(x3_x0[1]), .y(y3_y0[1]),
		.cin(carry[0]),
		.s(s3_s0[1])
	);

	b2_adder add_2 (
		.x(x3_x0[2]), .y(y3_y0[2]),
		.cin(carry[1]),
		.s(s3_s0[2])
	);
	
	b2_adder add_3 (
		.x(x3_x0[3]), .y(y3_y0[3]),
		.cin(carry[2]),
		.s(s3_s0[3])
	);
endmodule

// il modulo che calcola i riporti entranti in @carry
module n4_b2_cla(x3_x0, y3_y0, cin, carry);
	input[3:0] x3_x0, y3_y0;
	input cin;
	output[3:0] carry;

	wire[3:0] gen;
	wire[3:0] pro;

	assign gen = x3_x0 & y3_y0;
	assign pro = x3_x0 ^ y3_y0;

	assign carry[0] = gen[0] | pro[0] & cin;
	assign carry[1] = gen[1] | pro[1] & gen[0] 
													 | pro[1] & pro[0] & cin;
	assign carry[2] = gen[2] | pro[2] & gen[1] |
													 | pro[2] & pro[1] & gen[0] 
													 | pro[2] & pro[0] & cin;
	assign carry[3] = gen[3] | pro[3] & gen[2] 
													 | pro[3] & pro[2] & gen[1]
													 | pro[3] & pro[2] & pro[1] & gen[0] 
													 | pro[3] & pro[2] & pro[0] & cin; 
endmodule

// implementazione alternativa dell'adder (non abbiamo piu' bisogno 
// di cout) 
module b2_adder(x, y, cin, s);
	input x, y, cin;
	output s;

	assign s = x ^ y ^ cin;
endmodule
