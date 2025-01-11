module mem_space #(
	parameter RAM_SIZE = 16,
	parameter EPROM_SIZE = 12
) 
(
	addr,
	d7_d0,
	mr_, mw_
);
	
	input[RAM_SIZE - 1:0] addr;
	inout[7:0] d7_d0;
	input mr_, mw_;

	wire sram_;
	wire seprom_;

	wire[RAM_SIZE - EPROM_SIZE - 1:0] sel_addr;
	assign sel_addr = addr[RAM_SIZE - 1:EPROM_SIZE];
	assign {sram_, seprom_} = (sel_addr == 4'HF) ? 2'B10:
														/* 	don't care 	*/	 2'B01;
	ram rm (
		addr,
		d7_d0,
		sram_,
		mr_, mw_
	);

	eprom prm (
		addr[EPROM_SIZE - 1:0],
		d7_d0,
		seprom_,
		mr_
	);
endmodule
