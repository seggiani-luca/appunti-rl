// un incrementatore in base 2 che calcola @x3_x0 + @cin, mettendo il 
// risultato in @s3_s0 e il riporto in @cout
module n4_b2_incrementer(x3_x0, cin, s3_s0, cout);
	input[3:0] x3_x0; 
	input cin;
	output[3:0] s3_s0;
	output cout;

	wire[2:0] carry;

	b2_halfadder add_0 (
		.x(x3_x0[0]), .cin(cin),
		.s(s3_s0[0]), .cout(carry[0])
	);
	
	b2_halfadder add_1 (
		.x(x3_x0[1]), .cin(carry[0]),
		.s(s3_s0[1]), .cout(carry[1])
	);
	
	b2_halfadder add_2 (
		.x(x3_x0[2]), .cin(carry[1]),
		.s(s3_s0[2]), .cout(carry[2])
	);
	
	b2_halfadder add_3 (
		.x(x3_x0[3]), .cin(carry[2]),
		.s(s3_s0[3]), .cout(cout)
	);
endmodule
