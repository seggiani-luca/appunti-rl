module testbench();
	reg t_x;
	wire t_z;

	posedge_impulse_generator i_gen (
		.x(t_x), .z(t_z)
	);

	initial begin
		$dumpfile("posedge_impulse_generator_waveform.vcd");
		$dumpvars;	
		
		t_x = 0;
		
		#10;

		t_x = 1;

		#20

		t_x = 0;

		#10;

		$finish;
	end
endmodule
