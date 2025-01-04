// un latch SR con preset e preclear
module sr_reset_latch(preset_, preclear_, s, r, q, q_N);
	input preset_, preclear_, s, r;
	output q, q_N;

	wire s1, r1;
	assign {s1, r1} = ({preset_, preclear_, s, r} == 'B0000) ? 'BXX:
										({preset_, preclear_, s, r} == 'B0001) ? 'BXX:
										({preset_, preclear_, s, r} == 'B0010) ? 'BXX:
										({preset_, preclear_, s, r} == 'B0011) ? 'BXX:
										({preset_, preclear_, s, r} == 'B0100) ? 'B10:
										({preset_, preclear_, s, r} == 'B0101) ? 'B10:
										({preset_, preclear_, s, r} == 'B0110) ? 'B10:
										({preset_, preclear_, s, r} == 'B0111) ? 'B10:
										({preset_, preclear_, s, r} == 'B1000) ? 'B01:
										({preset_, preclear_, s, r} == 'B1001) ? 'B01:
										({preset_, preclear_, s, r} == 'B1010) ? 'B01:
										({preset_, preclear_, s, r} == 'B1011) ? 'B01:
										({preset_, preclear_, s, r} == 'B1100) ? 'B00:
										({preset_, preclear_, s, r} == 'B1101) ? 'B01:
										({preset_, preclear_, s, r} == 'B1110) ? 'B10:
									/*({preset_, preclear_, s, r} == 'B1111)?*/'B11; 

	sr_latch latch (
		.s(s1), .r(r1),
		.q(q), .q_N(q_N)
	);
endmodule

// implementazione a porte logiche
module sr_reset_latch_p(preset_, preclear_, s, r, q, q_N);
	input preset_, preclear_, s, r;
	output q, q_N;

	wire s1, r1;
	assign s1 = ~preset_ | (preclear_ & s);
	assign r1 = ~preclear_ | (preset_ & r);

	sr_latch latch (
		.s(s1), .r(r1),
		.q(q), .q_N(q_N)
	);
endmodule
