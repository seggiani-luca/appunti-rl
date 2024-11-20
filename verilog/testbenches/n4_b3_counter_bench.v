module testbench();
	reg t_clock, t_reset_;
	reg t_ei;
	wire t_eu;
	wire[1:0] t_q01_q00;
	wire[1:0] t_q11_q10;
	wire[1:0] t_q21_q20;
	wire[1:0] t_q31_q30;

	n4_b3_counter count (
		.m_clock(t_clock), .m_reset_(t_reset_),
		.m_ei(t_ei),
		.eu(t_eu), 
		.q01_q00(t_q01_q00),
		.q11_q10(t_q11_q10),
		.q21_q20(t_q21_q20),
		.q31_q30(t_q31_q30)
	);
	
	initial begin
    forever #5 t_clock = ~t_clock; 
	end

	initial begin
		$dumpfile("n4_b3_counter_bench_waveform.vcd");
		$dumpvars;	

		t_clock = 0;
		t_reset_ = 0;
		t_ei = 0;

		#10 

		t_reset_ = 1;
		t_ei = 1;

		#1000;

		$finish;
	end
endmodule
