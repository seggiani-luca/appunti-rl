module io_space #(
	parameter IO_SIZE = 16
) 
(
	clock,
	reset_,
	addr,
	d7_d0,
	ior_, iow_
);

	input clock, reset_;
	
	wire clock_del;
	assign #5 clock_del = clock;

	input[IO_SIZE - 1:0] addr;
	inout[7:0] d7_d0;
	input ior_, iow_;

	//	address | device   | register
	//	--------+----------+---------
	//	0000    | keyboard | RSR
	//	0001    | keyboard | RBR
	//	--------+----------+---------
	//	0002    | display  | TSR
	//	0003    | display  | TBR

	wire sk_;
	wire ak;
	
	wire sd_;
	wire ad;

	assign sk_ = (addr[15:1] == 15'B0000_0000_0000_000) ? 1'B0 : 1'B1;
	assign ak = addr[0];
	
	assign sd_ = (addr[15:1] == 15'B0000_0000_0000_001) ? 1'B0 : 1'B1;
	assign ad = addr[0];

	keyboard kb (
		.clock(clock_del), .reset_(reset_),
		.s_(sk_), .ior_(ior_),
		.a0(ak),
		.d7_d0(d7_d0)
	);
	
	display dp (
		.clock(clock_del), .reset_(reset_),
		.s_(sd_), .ior_(ior_), .iow_(iow_),
		.a0(ad),
		.d7_d0(d7_d0)
	);
	
endmodule
