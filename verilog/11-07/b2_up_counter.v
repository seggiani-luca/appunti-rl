// un contatore up a una cifra in base 2 che prende @ei come enabler
// e mette la sua uscita in @q, con eventuale riporto in @eu 
module b2_up_counter(eu, q, ei, clock, reset_);
  input clock, reset_;
  input ei;
  output eu, q;
  
	reg OUTR;
  assign q = OUTR;	
  
	wire a; // l'uscita dell'incrementatore
	b2_halfadder inc (
		.x(q), .cin(ei),
		.s(a), .cout(eu)
	);

  always @(reset_ == 0) #1 OUTR <= 0;
  always @(posedge clock) if (reset_==1) #2 OUTR <= a;
endmodule
