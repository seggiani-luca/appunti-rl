// un'interfaccia parallela di ingresso con handshake su 8 bit
module hs_parallel_out(clock, reset_,
										 s_, ior_, iow_, a0, dav_, rfd, d7_d0, byte_out);
	input clock, reset_;

	input s_, ior_, iow_;
	input a0;
	
	output dav_;
	input rfd;
	
	inout[7:0] d7_d0;
	output[7:0] byte_out;
	
	wire e_b, e_s;
	hs_parallel_out_comb comb (
		.s_(s_), .ior_(ior_), .iow_(iow_), .a0(a0),
		.e_b(e_b), .e_s(e_s)
	);

	wire fo;

	hs_parallel_out_seq seq (
		.clock(clock), .reset_(reset_),
		.dav_(dav_), .rfd(rfd), .e_b(e_b),
		.byte_out(byte_out), .fo(fo), .d7_d0(d7_d0)
	);

	assign d7_d0 = e_s ? {3'BZ, fo, 4'BZ}:
								 /*dc*/8'BZ;	
endmodule

module hs_parallel_out_seq(clock, reset_, 
													 e_b, dav_, rfd, byte_out, fo, d7_d0);
	input clock, reset_;
												
	input e_b;
	
	output dav_;
	input rfd;

	reg DAV;
	assign dav_ = DAV;

	output[7:0] byte_out;
	
	input[7:0] d7_d0;

	output fo;

	reg FO;
	assign fo = FO;

	reg[7:0] TBR;
	assign byte_out = TBR;

	reg[1:0] STAR;
	localparam
		s0 = 2'B00,
		s1 = 2'B01,
		s2 = 2'B10,
		s3 = 2'B11;

	always @(reset_) if(reset_ == 0) #1 begin
		DAV <= 1;
		FO <= 1;
		STAR <= s0;
	end

	always @(posedge clock) if(reset_ == 1) #3 begin
		casex(STAR)
			s0: begin
				TBR <= d7_d0;
				FO <= 1;
				STAR <= (e_b == 1) ? s1 : s0;
			end
			s1: begin
				FO <= 0;
				STAR <= (e_b == 0) ? s2 : s1;
			end
			s2: begin
				DAV <= 0;
				STAR <= (rfd == 0) ? s3 : s2;
			end
			s3: begin
				DAV <= 1;
				STAR <= (rfd == 1) ? s0 : s3;
			end
		endcase
	end
endmodule

module hs_parallel_out_comb(s_, ior_, iow_, a0, e_b, e_s);
	input s_, ior_, iow_, a0;
	output e_b, e_s;

	assign {e_b, e_s} = ({s_, ior_, iow_, a0} == 4'B0010) ? 'B01:
									 		({s_, ior_, iow_, a0} == 4'B0101) ? 'B10:
									 		/* 				    don't care 				 */ 'B00;
endmodule
