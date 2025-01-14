// un semplice display implementato con un interfaccia parallela
module display(clock, reset_, 
							 s_, ior_, iow_, a0, d7_d0);
	
	input clock, reset_;
	input s_, ior_, iow_;
	input a0;
	output[7:0] d7_d0;

	wire dav_;
	reg RFD;
	
	wire[7:0] char;

	hs_parallel_out interface (
		.clock(clock), .reset_(reset_), 
		.s_(s_), .ior_(ior_), .iow_(iow_), .a0(a0), .dav_(dav_), 
																													 .rfd(RFD),
		.d7_d0(d7_d0), .byte_out(char)
	);
	
	reg[1:0] STAR;
	localparam
		s0 = 2'B00,
		s1 = 2'B01;

	always @(reset_ == 0) #1 begin
		RFD <= 1;
		STAR <= s0;
	end

	always @(negedge RFD) begin
		$display("%c", char);
	end

	always @(posedge clock) if(reset_ == 1) #3 begin
		casex(STAR)
			s0 : begin
				RFD <= 1;
				STAR <= (dav_ == 0) ? s1 : s0;
			end
			s1 : begin
				RFD <= 0;
				STAR <= (dav_ == 1) ? s0 : s1;
			end
		endcase
	end
endmodule
