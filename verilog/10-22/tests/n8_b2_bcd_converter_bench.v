module testbench();
	reg t_clock, t_reset_;
	reg[7:0] t_x7_x0;

	wire[3:0] t_a3_a0;
	wire[3:0] t_b3_b0;
	wire[3:0] t_c3_c0;

	n8_b2_bcd_converter conv (
		.clock(t_clock), .reset_(t_reset_),
		.x7_x0(t_x7_x0),
		.a3_a0(t_a3_a0), .b3_b0(t_b3_b0), .c3_c0(t_c3_c0)
	);

	initial begin
		forever #5 t_clock = ~t_clock;
	end

	initial begin
		$dumpfile("n8_b2_bcd_converter_bench_waveform.vcd");
		$dumpvars;
			t_clock = 0;
			t_reset_ = 0;
		
			#10;

			t_x7_x0 = 'B01101001;
			
			#1;
			
			t_reset_ = 1;
			
			#250;
	
		$finish;
	end	
endmodule
