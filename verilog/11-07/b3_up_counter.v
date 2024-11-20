// un contatore up a una cifra in base 3 che prende @ei come enabler
// e mette la sua uscita in @q1_q0, con eventuale riporto in @eu 
module b3_up_counter(eu, q1_q0, ei, clock, reset_);
  input clock, reset_;
  input ei;
  output eu;
	output[1:0] q1_q0;
  
	reg[1:0] OUTR;
  assign q1_q0 = OUTR;	
  
	wire[1:0] a1_a0; // l'uscita dell'incrementatore
	b3_halfadder inc (
		.x1_x0(q1_q0), .cin(ei),
		.s1_s0(a1_a0), .cout(eu)
	);

  always @(reset_ == 0) #1 OUTR <= 0;
  always @(posedge clock) if (reset_==1) #2 OUTR <= a1_a0;
endmodule
