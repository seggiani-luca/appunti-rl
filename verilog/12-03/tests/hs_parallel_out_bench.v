module testbench();
	reg t_clock, t_reset_;
	reg t_s_, t_ior_, t_iow_, t_a0, t_rfd;
	wire[7:0] t_byte_out;
	wire t_dav_;
	
	wire[7:0] t_d7_d0;
	reg[7:0] t_d7_d0_driver;
	assign t_d7_d0 = t_d7_d0_driver;

	hs_parallel_out hs_out (
		.clock(t_clock), .reset_(t_reset_), 
		.s_(t_s_), .ior_(t_ior_), .iow_(t_iow_), .a0(t_a0), 
		.dav_(t_dav_), .rfd(t_rfd),
		.d7_d0(t_d7_d0), .byte_out(t_byte_out)
	);

	initial forever #3 t_clock = ~t_clock;

	initial begin 
		$dumpfile("hs_parallel_out_waveform.vcd");
		$dumpvars;	

		t_s_ = 1;
		t_ior_ = 1;
		t_iow_ = 1;

		t_reset_ = 1;
		t_clock = 0;

		t_rfd = 1;
		t_d7_d0_driver = 'BZ;

		#20;

		t_s_ = 0;
		
		t_a0 = 0;
		t_ior_ = 0;

		#20;

		t_a0 = 1;
		t_ior_ = 1;
		t_d7_d0_driver = 'H4F;

		#20;

		t_iow_ = 0;
		
		#20;

		t_d7_d0_driver = 'BZ;
		t_iow_ = 1;

		#20;
		
		t_a0 = 0;
		t_ior_ = 0;

		#20;

		t_a0 = 1;
		t_ior_ = 1;

		#20;

		t_rfd = 0;

		#20;

		t_rfd = 1;

		#20;

		$finish;
	end
endmodule
