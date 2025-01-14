// un ricevitore seriale
module serial_receiver(clock, reset_, dav_, /*rfd,*/ byte, rxd);
	input clock, reset_;
	output dav_;
	// input rfd;
	output[7:0] byte; 
	input rxd;

	reg[7:0] BUFFER;
	assign byte = BUFFER;

	reg DAV;
	assign dav_ = DAV;

	reg[4:0] WAIT;
	reg[3:0] COUNT;

	reg[1:0] STAR;
	localparam
		s0 = 2'B00,
		s1 = 2'B01,
		s2 = 2'B10,
		s3 = 2'B11;

	parameter start_bit = 1'B0;

	always @(reset_ == 0) #1 begin
		DAV <= 1;
		STAR <= s0;
	end

	always @(posedge clock) if(reset_ == 1) #0 begin
		casex(STAR)
			s0 : begin
				DAV <= 1;
				COUNT <= 8;
				WAIT <= 23;
				STAR <= (rxd == start_bit) ? s2 : s0;
			end
			s1 : begin
				BUFFER <= {rxd, BUFFER[7:1]};
				COUNT <= COUNT - 1;
				WAIT <= 15;
				STAR <= (COUNT == 1) ? s3 : s2;
			end
			s2 : begin
				WAIT <= WAIT - 1;
				STAR <= (WAIT == 1) ? s1 : s2;
			end
			s3 : begin
				DAV <= 0;
				WAIT <= WAIT - 1;
				STAR <= (WAIT == 1) ? s0 : s3;
			end
		endcase
	end
endmodule
