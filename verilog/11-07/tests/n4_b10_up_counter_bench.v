module testbench();
	reg t_clock, t_reset_;
	reg t_ei;
	wire t_eu;
	wire[3:0] t_q03_q00;
	wire[3:0] t_q13_q10;
	wire[3:0] t_q23_q20;
	wire[3:0] t_q33_q30;

	n4_b10_up_counter count (
		.m_clock(t_clock), .m_reset_(t_reset_),
		.m_ei(t_ei),
		.eu(t_eu), 
		.q03_q00(t_q03_q00),
		.q13_q10(t_q13_q10),
		.q23_q20(t_q23_q20),
		.q33_q30(t_q33_q30)
	);
	
	initial begin
    forever #5 t_clock = ~t_clock; 
	end

	initial begin
		$dumpfile("n4_b10_up_counter_bench_waveform.vcd");
		$dumpvars;	

		t_clock = 0;
		t_reset_ = 0;
		t_ei = 0;

		#10 

		t_reset_ = 1;
		t_ei = 1;

		#150000;

		$finish;
	end
endmodule
