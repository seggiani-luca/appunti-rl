// un'interfaccia parallela di ingresso e uscita con handshake su 8 
// bit
module hs_parallel_inout(clock, reset_,
												 s_, ior_, iow_, a0, d7_d0,
												 dav_in_, rfd_in,
												 dav_out_, rfd_out,
												 byte_in, byte_out);
	input clock, reset_;
	input s_, a0, ior_, iow_;
	
	input dav_in_;
	output rfd_in;
	
	output dav_out_;
	input rfd_out;

	inout[7:0] d7_d0;
	input[7:0] byte_in;
	output[7:0] byte_out;

	hs_parallel_in hs_in (
		.clock(clock), .reset_(reset_),
		.s_(s_), .ior_(ior_), .a0(a0), 
		.dav_(dav_in_), .rfd(rfd_in),
		.d7_d0(d7_d0), .byte_in(byte_in)
	);
	
	hs_parallel_out hs_out (
		.clock(clock), .reset_(reset_),
		.s_(s_), .ior_(ior_), .iow_(iow_), .a0(a0), 
		.dav_(dav_out_), .rfd(rfd_out),
		.d7_d0(d7_d0), .byte_out(byte_out)
	);
endmodule
