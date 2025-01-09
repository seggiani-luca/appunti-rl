module testbench();
	reg clock, reset_;
	reg s_, a0, ior_, iow_;

	reg dav_in_;
	wire rfd_in;
	reg[7:0] byte_in;

	wire dav_out_;
	reg rfd_out;
	wire[7:0] byte_out;

	wire[7:0] d7_d0;
	reg[7:0] d7_d0_driver;
	assign d7_d0 = d7_d0_driver;

	hs_parallel_inout hs_inout (
		clock, reset_,
		s_, ior_, iow_, a0, d7_d0,
		dav_in_, rfd_in,
		dav_out, rfd_out,
		byte_in, byte_out
	);

	initial forever #3 clock = ~clock;

	initial begin 
		$dumpfile("hs_parallel_inout_waveform.vcd");
		$dumpvars;	

		// setup
		clock = 0;
		reset_ = 0;

		d7_d0_driver = 'BZ;

		s_ = 1;
		ior_ = 1;
		iow_ = 1;

		dav_in_ = 1;
		rfd_out = 1;

		#5;

		reset_ = 1;

		#10;

		// read status
		s_ = 0;
		a0 = 0;
		ior_ = 0;

		#20;

		ior_ = 1;
	
		#20

		// input a byte
		byte_in = 'HF4;

		dav_in_ = 0;

		#20;

		dav_in_ = 1;

		#20;

		// read status
		s_ = 0;
		a0 = 0;
		ior_ = 0;

		#20;

		ior_ = 1;
	
		#20
		
		// read byte
		s_ = 0;
		a0 = 1;
		ior_ = 0;

		#20;

		ior_ = 1;
	
		#20;

		// read status
		s_ = 0;
		a0 = 0;
		ior_ = 0;

		#20;

		ior_ = 1;
	
		#20;

		// output a byte
		a0 = 1;
		d7_d0_driver = 'HF5;
		iow_ = 0;

		#20;

		iow_ = 1;
		d7_d0_driver = 'BZ;

		#20;

		// read status
		s_ = 0;
		a0 = 0;
		ior_ = 0;

		#20;

		ior_ = 1;	

		#20;

		rfd_out = 0;

		#20;

		rfd_out = 1;

		#20;

		// read status
		s_ = 0;
		a0 = 0;
		ior_ = 0;

		#20;

		ior_ = 1;	

		#20;

		$finish;
	end
endmodule
