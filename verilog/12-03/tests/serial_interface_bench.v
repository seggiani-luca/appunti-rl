module testbench();
	reg clock, reset_;

	reg s_1_, a0_1, ior_1_, iow_1_;

	wire[7:0] d7_d0_1;
	reg[7:0] d7_d0_1_driver;
	assign d7_d0_1 = d7_d0_1_driver;

	reg s_2_, a0_2, ior_2_, iow_2_;

	wire[7:0] d7_d0_2;
	reg[7:0] d7_d0_2_driver;
	assign d7_d0_2 = d7_d0_2_driver;

	wire line_1, line_2;

	serial_interface serial_1 (
		clock, reset_,
		s_1_, ior_1_, iow_1_, a0_1, d7_d0_1,
		line_1, line_2
	);
	
	serial_interface serial_2 (
		clock, reset_,
		s_2_, ior_2_, iow_2_, a0_2, d7_d0_2,
		line_2, line_1
	);

	initial forever #50 clock = ~clock;

	initial begin 
		$dumpfile("serial_interface_waveform.vcd");
		$dumpvars;	

		clock = 0;
		reset_ = 0;
		s_1_ = 1;
		a0_1 = 1;
		ior_1_ = 1;
		iow_1_ = 1;
		
		s_2_ = 1;
		a0_2 = 1;
		ior_2_ = 1;
		iow_2_ = 1;

		d7_d0_1_driver = 'BZ;
		d7_d0_2_driver = 'BZ;

		#50;

		reset_ = 1;

		#100;

		d7_d0_1_driver <= 'HF4;
		s_1_ = 0;
		iow_1_ = 0;

		#200;

		iow_1_ = 1;

		#450;

		s_2_ = 0;
		ior_2_ = 0;

		#200;

		ior_2_ = 1;

		$finish;
	end
endmodule

