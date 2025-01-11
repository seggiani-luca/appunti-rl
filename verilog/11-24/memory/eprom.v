module eprom #(
	parameter EPROM_SIZE = 12,
	parameter MEM_READ = 1
) 
(
	addr,
	d7_d0,
	s_,
	mr_
);

	input[EPROM_SIZE - 1:0] addr;
	inout[7:0] d7_d0;
	input s_;
	input mr_;

	reg[7:0] LOCATION[0:2 ** EPROM_SIZE - 1];

	// ciclo di lettura
	wire read;
	assign read = ~s_ & ~mr_;
	
	assign #MEM_READ d7_d0 = read ? LOCATION[addr] : 'HZ;
endmodule
