// un'interfaccia di conversione digitale-analogico
module digital_analog_interface(s_, iow_, d7_d0, a_out);
	input s_, iow_;
	input[7:0] d7_d0;
	output real a_out;

	wire[7:0] byte_out;
	
	parallel_out p_out(
		.s_(s_), .iow_(iow_),
		.d7_d0(d7_d0), 
		.byte_out(byte_out)
	);

	digital_analog_converter dac (
		.x7_x0(byte_out), 
		.a_out(a_out)
	);
endmodule

