module testbench();
	reg t_clock, t_reset_;
	reg t_ei;
	wire t_eu;
	wire[1:0] t_q1_q0;

	b3_up_counter count (
		.clock(t_clock), .reset_(t_reset_),
		.ei(t_ei),
		.eu(t_eu), .q1_q0(t_q1_q0)
	);
	
	initial begin
    forever #5 t_clock = ~t_clock; 
	end

	initial begin
		$dumpfile("b3_up_counter_bench_waveform.vcd");
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