module ram 
#(
	parameter RAM_SIZE = 16,
	parameter MEM_READ = 1, 
	parameter MEM_WRITE = 1
) 
(
	addr,
	d7_d0,
	s_,
	mr_, mw_
);

	input[RAM_SIZE - 1:0] addr;
	inout[7:0] d7_d0;
	input s_;
	input mr_, mw_;

	reg[7:0] LOCATION[0:2 ** RAM_SIZE - 1];

	// ciclo di lettura
	wire read;
	assign read = ~s_ & ~mr_ & mw_;
	
	assign #MEM_READ d7_d0 = read ? LOCATION[addr] : 'HZ;

	// ciclo di scrittura
	wire write;
	assign write = ~s_ & mr_ & ~mw_;
	
	always @(write or d7_d0) #MEM_WRITE
		LOCATION[addr] <= write ? d7_d0 : LOCATION[addr];
endmodule
