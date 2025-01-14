// un trasmettitore seriale
module serial_transmitter(clock, reset_, dav_, rfd, byte, txd);
	input clock, reset_;
	input dav_;
	output rfd;
	output[7:0] byte; 
	output txd;

	reg[9:0] BUFFER;

	reg RFD;
	assign rfd = RFD;

	reg TXD;
	assign txd = TXD;

	reg[3:0] COUNT;

	reg[1:0] STAR;
	localparam
		s0 = 2'B00,
		s1 = 2'B01,
		s2 = 2'B10;

	parameter mark = 1'B1, start_bit = 1'B0, stop_bit = 1'B1;

	always @(reset_ == 0) #1 begin
		RFD <= 1;
		TXD = mark;
		STAR <= s0;
	end

	always @(posedge clock) if(reset_ == 1) #3 begin
		casex(STAR)
			s0 : begin
				RFD <= 1;
				COUNT <= 10;
				TXD <= mark;
				BUFFER <= {stop_bit, byte, start_bit};
				STAR <= (dav_ == 0) ? s1 : s0;
			end
			s1 : begin
				RFD <= 0;
				BUFFER <= {mark, BUFFER[9:1]};
				TXD <= BUFFER[0];
				COUNT <= COUNT - 1;
				STAR <= (COUNT == 1) ? s2 : s1;
			end
			s2 : begin
				STAR <= (dav_ == 1) ? s0 : s2;
			end
		endcase
	end
endmodule
