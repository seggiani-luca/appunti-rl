// un contatore a una cifra in base 10 che prende @ei come enabler, e 
// mette la sua uscita in @q3_q0, con eventuale riporto in @eu 
module b10_counter(eu, q3_q0, ei, clock, reset_);
  input clock, reset_;
  input ei;
  output eu;
	output[3:0] q3_q0;
  
	reg[3:0] OUTR;
  assign q3_q0 = OUTR;	
  
	wire[3:0] a3_a0; // l'uscita dell'incrementatore
	b10_halfadder inc (
		.x3_x0(q3_q0), .cin(ei),
		.s3_s0(a3_a0), .cout(eu)
	);

  always @(reset_ == 0) #1 OUTR <= 0;
  always @(posedge clock) if (reset_==1) #2 OUTR <= a3_a0;
endmodule
