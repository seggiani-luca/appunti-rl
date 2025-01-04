// un D-latch trasparente con preset e preclear
module d_latch(d, c, q, q_N);
	input d, c;
	output q, q_N;

	wire s, r;
	assign {s, r} == ({d, c} == 'B00) ? 'B00: 
									 ({d, c} == 'B01) ? 'B01:
									 ({d, c} == 'B10) ? 'B00:
								 /*({d, c} == 'B11)?*/'B10;

	sr_latch latch (
		.s(s), .r(r),
		.q(q), .q_N(q_N)
	);
endmodule

// implementazione a porte logiche
module d_latch_p(d, c, q, q_N);
	input d, c;
	output q, q_N;

	wire s, r;
	assign s = d & c;
	assign r = ~d & c;

	sr_latch latch (
		.s(s), .r(r),
		.q(q), .q_N(q_N)
	);
endmodule
