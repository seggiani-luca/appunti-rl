// un'interfaccia parallela di ingresso e uscita senza handshake su 
// 8 bit

// a due buffer
module parallel_inout_2buf(s_, ior_, iow_, a0, d7_d0, byte_in, 
																													 byte_out);
	input s_, ior_, iow_;
	input a0;
	inout[7:0] d7_d0;
	input[7:0] byte_in;
	output[7:0] byte_out;

	wire sr_;
	assign sr_ = !({s_, a0} == 2'B00);
	
	wire sw_;
	assign sw_ = !({s_, a0} == 2'B01);

	parallel_in in (
		.s_(sr_), .ior_(ior_), .d7_d0(d7_d0), .byte_in(byte_in)
	);
	
	parallel_out out (
		.s_(sw_), .iow_(iow_), .d7_d0(d7_d0), .byte_out(byte_out)
	);
endmodule

// a buffer singolo
module parallel_inout_1buf(s_, ior_, iow_, d7_d0, byte_in, byte_out);
	input s_, ior_, iow_;
	inout[7:0] d7_d0;
	input[7:0] byte_in;
	output[7:0] byte_out;

	parallel_in in (
		.s_(s_), .ior_(ior_), .d7_d0(d7_d0), .byte_in(byte_in)
	);
	
	parallel_out out (
		.s_(s_), .iow_(iow_), .d7_d0(d7_d0), .byte_out(byte_out)
	);
endmodule
