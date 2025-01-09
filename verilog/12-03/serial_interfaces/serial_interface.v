// un'interfaccia seriale di ingresso e uscita
module serial_interface(clock, reset_,
											  s_, ior_, iow_, a0, d7_d0,
											  rxd, txd);
	input clock, reset_;
	input s_, a0, ior_, iow_;
	
	wire dav_in_;
	wire rfd_in;
	
	wire dav_out_;
	wire rfd_out;

	inout[7:0] d7_d0;
	wire[7:0] byte_in;
	wire[7:0] byte_out;

	input rxd;
	output txd;

	reg rec_clock;
	reg tra_clock;

	initial begin
		rec_clock = 0;
		tra_clock = 0;
	end

	always #1 rec_clock = ~rec_clock;
	always #16 tra_clock = ~tra_clock;

	hs_parallel_inout parallel (
		.clock(clock), .reset_(reset_),
		.s_(s_), .ior_(ior_), .iow_(iow_), .a0(a0), .d7_d0(d7_d0),
	 	.dav_in_(dav_in_), .rfd_in(rfd_in),
	 	.dav_out_(dav_out_), .rfd_out(rfd_out),
	 	.byte_in(byte_in), .byte_out(byte_out)
	);

	serial_receiver receiver (
		.clock(rec_clock), .reset_(reset_),
		.dav_(dav_in_), .byte(byte_in),
		.rxd(rxd)
	);
	
	serial_transmitter transmitter (
		.clock(tra_clock), .reset_(reset_),
		.dav_(dav_out_), .rfd(rfd_out), .byte(byte_out),
		.txd(txd)
	);
endmodule
