// esempio di montaggio di banchi di RAM in serie
module parallel_sram(s_, mr_, mw_, addr, data_in, data);
	input s_, mr_, mw_;
	input[4:0] addr;

	output[3:0] data;
	input[3:0] data_in;

	wire l_s_;
	wire r_s_;
	assign l_s_ = ~addr[4] | s_;
	assign r_s_ = addr[4] | s_;

	wire[3:0] data_0;
	wire[3:0] data_1;
	assign data = addr[4] ? data_0 : data_1; 
	// per emulazione delle tristate, nella pratica bastano da sole

	nNbyM_sram #(.N(4), .M(4)) bank_0 (
		.s_(l_s_), .mr_(mr_), .mw_(mw_),
		.addr(addr[3:0]), .data(data_0), .data_in(data_in)
	);
	
	nNbyM_sram #(.N(4), .M(4)) bank_1 (
		.s_(r_s_), .mr_(mr_), .mw_(mw_),
		.addr(addr[3:0]), .data(data_1), .data_in(data_in)
	);
endmodule
