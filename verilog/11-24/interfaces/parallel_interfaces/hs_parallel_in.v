// un'interfaccia parallela di ingresso con handshake su 8 bit
module hs_parallel_in(clock, reset_, 
											s_, ior_, a0, dav_, rfd, d7_d0, byte_in);
	input clock, reset_;

	input s_, ior_;
	input a0;
	
	input dav_;
	output rfd;
	
	output[7:0] d7_d0;
	input[7:0] byte_in;
	
	wire e_b, e_s;
	hs_parallel_in_comb comb (
		.s_(s_), .ior_(ior_), .a0(a0),
		.e_b(e_b), .e_s(e_s)
	);

	wire[7:0] rbr;
	wire fi;

	hs_parallel_in_seq seq (
		.clock(clock), .reset_(reset_),
		.dav_(dav_), .rfd(rfd), .e_b(e_b),
		.byte_in(byte_in), .fi(fi), .rbr(rbr)
	);

	assign d7_d0 = e_b ? rbr:
								 e_s ? {7'B0, fi}:
								 /*dc*/8'BZ;	
endmodule

module hs_parallel_in_seq(clock, reset_, 
													e_b, dav_, rfd, byte_in, fi, rbr);
	input clock, reset_;
												
	input e_b;
	
	input dav_;
	output rfd;

	reg RFD;
	assign rfd = RFD;

	input[7:0] byte_in;

	output fi;

	reg FI;
	assign fi = FI;

	output[7:0] rbr;

	reg[7:0] RBR;
	assign rbr = RBR;

	reg[1:0] STAR;
	localparam
		s0 = 2'B00,
		s1 = 2'B01,
		s2 = 2'B10,
		s3 = 2'B11;

	always @(reset_) if(reset_ == 0) #1 begin
		RFD <= 1;
		FI <= 0;
		STAR <= s0;
	end

	always @(posedge clock) if(reset_ == 1) #3 begin
		casex(STAR)
			s0: begin
				RFD <= 1;
				RBR <= byte_in;
				FI <= 0;
				STAR <= (dav_ == 0) ? s1 : s0;
			end
			s1: begin
				RFD <= 0;
				STAR <= (dav_ == 1) ? s2: s1;
			end
			s2: begin
				FI <= 1;
				STAR <= (e_b == 1) ? s3 : s2;
			end
			s3: begin
				STAR <= (e_b == 0) ? s0 : s3;
			end
		endcase
	end
endmodule

module hs_parallel_in_comb(s_, ior_, a0, e_b, e_s);
	input s_, ior_, a0;
	output e_b, e_s;

	assign {e_b, e_s} = ({s_, ior_, a0} == 3'B000) ? 'B01:
									 		({s_, ior_, a0} == 3'B001) ? 'B10:
									 		/* 				don't care 			*/ 'B00;
endmodule
