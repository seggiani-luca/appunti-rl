// esempio di montaggio di banchi di RAM in parallelo
module parallel_sram(s_, mr_, mw_, addr, data_in, data);
	input s_, mr_, mw_;
	input[3:0] addr;

	output[7:0] data;
	input[7:0] data_in;

	nNbyM_sram #(.N(4), .M(4)) bank_0 (
		.s_(s_), .mr_(mr_), .mw_(mw_),
		.addr(addr), .data(data[7:4]), .data_in(data_in[7:4])
	);
	
	nNbyM_sram #(.N(4), .M(4)) bank_1 (
		.s_(s_), .mr_(mr_), .mw_(mw_),
		.addr(addr), .data(data[3:0]), .data_in(data_in[3:0])
	);
endmodule
