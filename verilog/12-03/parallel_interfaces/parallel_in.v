// un'interfaccia parallela di ingresso senza handshake su 8 bit
module parallel_in(s_, ior_, d7_d0, byte_in);
	input s_, ior_;
	output[7:0] d7_d0;
	input[7:0] byte_in;

	reg[7:0] RBR;
	
	wire e;
	assign e = {s_, ior_} == 2'B00;

	assign d7_d0 = e ? RBR : 8'BX;
	
	always @(posedge e) RBR <= byte_in;;
endmodule
