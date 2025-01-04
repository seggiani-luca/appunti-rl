// un riconoscitore della sequenza 11, 01, 10 implementato come 
// macchina di Mealy
module mealy_sequence_detector(reset_, clock, x1_x0, z);
	input reset_, clock;
	input[1:0] x1_x0;
	output z;

	reg[1:0] STAR;
	localparam
		s0='B00,
		s1='B01,
		s2='B10;

	assign z = (STAR == s2) & (x1_x0 == 'B10);

	always @(reset_ == 0) #1 STAR <= s0;
	always @(posedge clock) if(reset_ == 1) #3
		case(STAR)
			s0: STAR <= (x1_x0 == 'B11) s1 : s0;
			s1: STAR <= (x1_x0 == 'B01) s2 : (x1_x0 == 'B11) ? : s1 : s0;
			s1: STAR <= (x1_x0 == 'B11) ? : s1 : s0;
		endcase
endmodule
