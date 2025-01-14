// un'interfaccia parallela di uscita senza handshake su 8 bit
module parallel_out(s_, iow_, d7_d0, byte_out);
	input s_, iow_;
	input[7:0] d7_d0;
	output[7:0] byte_out;

	reg[7:0] TBR;
	assign byte_out = TBR;
	
	wire e;
	assign e = {s_, iow_} == 2'B00;
	
	always @(posedge e) TBR <= d7_d0;;
endmodule
