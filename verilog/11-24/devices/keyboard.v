// una semplice tastiera implementata con un interfaccia parallela
module keyboard(clock, reset_, 
								s_, ior_, a0, d7_d0);
	
	input clock, reset_;
	input s_, ior_;
	input a0;
	output[7:0] d7_d0;

	reg DAV;
	wire rfd;

	reg[7:0] CHAR;
	
	hs_parallel_in interface (
		.clock(clock), .reset_(reset_), 
		.s_(s_), .ior_(ior_), .a0(a0), .dav_(DAV), .rfd(rfd),
		.d7_d0(d7_d0), .byte_in(CHAR)
	);
	
	reg[1:0] STAR;
	localparam
		s0 = 2'B00,
		s1 = 2'B01,
		s2 = 2'B10,
		s3 = 2'B11;
		
	always @(reset_ == 0) #1 begin
		DAV <= 1;
		STAR <= s0;
	end

	// la descrizione qui sotto non è molto carina: assumendo che il calcolatore
	// leggerà RSR prima di accedere a RBR, si rileva quando questo accade per
	// prelevare un nuovo carattere (una tastiera reale solleverebbe un
	// interrupt alla pressione del tasto, qui è al contrario)

	reg[127:0] line_buffer;
	integer i;
	reg done;

	always @(posedge clock) if(reset_ == 1) #3 begin
		casex(STAR)
			s0 : begin				
				DAV <= 1;
				STAR <= (~ior_ & ~s_ & ~a0) ? s1 : s0; 
			end
			s1 : begin
				// questo è il modo più carino per ottenere caratteri (senza usare
				// Verilator o simili)
				$display("=> keyboard is requesting character");
				CHAR = $fgets(line_buffer, 32'H8000_0000);
				
				done = 0;
				for (i = 0; i < 127 && !done; i = i + 1) begin
            CHAR = line_buffer[7:0];						
						line_buffer = line_buffer >> 8;

						if (CHAR >= 32 && CHAR <= 126) begin 
							done = 1; 
						end
				 end
				// da qui in poi è comune Verilog

				STAR <= s2;
			end
			s2 : begin
				DAV <= 0;
				STAR <= (rfd == 0) ? s3 : s2;
			end
			s3 : begin
				DAV <= 1;
				STAR <= (rfd == 1) ? s0 : s3;
			end
		endcase
	end
endmodule
