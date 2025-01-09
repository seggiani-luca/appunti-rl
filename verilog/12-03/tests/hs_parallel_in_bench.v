module testbench();
	reg t_clock, t_reset_;
	reg t_s_, t_ior_, t_a0, t_dav_;
	reg[7:0] t_byte_in;
	wire t_rfd;
	wire[7:0] t_d7_d0;

	hs_parallel_in hs_in (
		.clock(t_clock), .reset_(t_reset_), 
		.s_(t_s_), .ior_(t_ior_), .a0(t_a0), 
		.dav_(t_dav_), .rfd(t_rfd),
		.d7_d0(t_d7_d0), .byte_in(t_byte_in)
	);

	initial forever #3 t_clock = ~t_clock;

	initial begin 
		$dumpfile("hs_parallel_in_waveform.vcd");
		$dumpvars;	

		t_s_ = 1;
		t_ior_ = 1;

		t_reset_ = 1;
		t_clock = 0;

		t_dav_ = 1;

		t_byte_in = 'H4F;

		#20;

		t_dav_ = 0;

		#20;

		t_dav_ = 1;

		#20;

		t_s_ = 0;

		t_a0 = 0;
		t_ior_ = 0;

		#20;

		t_a0 = 1;
		t_ior_ = 1;
		
		#20;

		t_ior_ = 0;

		#20;

		t_ior_ = 1;

		#20;

		$finish;
	end
endmodule
