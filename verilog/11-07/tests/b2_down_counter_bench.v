module testbench();
	reg t_clock, t_reset_;
	reg t_ei;
	wire t_eu;
	wire t_q;

	b2_down_counter count (
		.clock(t_clock), .reset_(t_reset_),
		.ei(t_ei),
		.eu(t_eu), .q(t_q)
	);
	
	initial begin
    forever #5 t_clock = ~t_clock; 
	end

	initial begin
		$dumpfile("b2_down_counter_bench_waveform.vcd");
		$dumpvars;	

		t_clock = 0;
		t_reset_ = 0;
		t_ei = 0;

		#10 

		t_reset_ = 1;
		t_ei = 1;

		#200;

		$finish;
	end
endmodule
