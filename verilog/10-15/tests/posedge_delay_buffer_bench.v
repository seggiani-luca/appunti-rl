module testbench();
	reg t_x;
	wire t_z;

	posedge_delay_buffer d_buf (
		.x(t_x), .z(t_z)
	);

	initial begin
		$dumpfile("posedge_delay_buffer_waveform.vcd");
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
