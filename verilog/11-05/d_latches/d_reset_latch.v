// un D-latch trasparente con preset e preclear
module d_reset_latch(preset_, preclear_, c, q, q_N);
	input preset_, preclear_, d, c;
	output q, q_N;

	wire s, r;
	assign {s, r} == ({d, c} == 'B00) ? 'B00: 
									 ({d, c} == 'B01) ? 'B01:
									 ({d, c} == 'B10) ? 'B00:
								 /*({d, c} == 'B11)?*/'B10;

	sr_reset_latch latch (
		.preset_(preset_), .preclear_(preclear_),
		.s(s), .r(r),
		.q(q), .q_N(q_N)
	);
endmodule

// implementazione a porte logiche
module d_reset_latch_p(preset_, preclear_, d, c, q, q_N);
	input preset_, preclear_, d, c;
	output q, q_N;

	wire s, r;
	assign s = d & c;
	assign r = ~d & c;

	sr_latch latch (
		.preset_(preset_), .preclear_(preclear_),
		.s(s), .r(r),
		.q(q), .q_N(q_N)
	);
endmodule
