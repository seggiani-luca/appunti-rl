// un banco di memoria RAM statica da 2^N locazioni da M bit
module nNbyM_sram 
	#(parameter N = 4, parameter M = 4) // N: linee di indirizzo 
																			// M: linee di dati
	(s_, mr_, mw_, addr, data_in, data);
	
	input s_, mr_, mw_;
	input[N-1:0] addr;
	
	// sarebbe una tristate
	output[M-1:0] data; // emulata con due porte, data_in e data_out

	input[M-1:0] data_in;
	reg[M-1:0] data_out;
	
	wire b; // enabler della tristate 
	wire c; // controllo dei latch

	assign b = ~s_ & ~mr_ & mw_; // select e memory read 
	assign c = ~s_ & mr_ & ~mw_; // select e memory write

	// logica delle tristate
	// assign data_in = data;
	assign data = b ? data_out : {M{1'BZ}}; 

	// sarebbe un demultiplexer da 1 a 2^N
	reg[2**N-1:0] c_plex;
	always @(*) begin
			c_plex = {2**N{1'B0}};
			c_plex[addr] = c;
  end

	// sarebbe un multiplexer da 2^N a 1
	wire[2**N-1:0] data_out_plexes [0:M-1];
	integer i;
	always @(*) begin
		for(i = 0; i < M; i = i + 1) begin
  		data_out[i] = data_out_plexes[i][addr];
		end
	end

	genvar j;
	genvar k;
	generate
		// banco di locazioni
		for(k = 0; k < 2**N; k = k + 1) begin: locations
			// singola locazione 
			for(j = 0; j < M; j = j + 1) begin : latches
				d_latch latch (
					.d(data_in[j]), .c(c_plex[k]),
					.q(data_out_plexes[j][k])
				);
			end
		end
	endgenerate
endmodule
