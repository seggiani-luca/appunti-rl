// un contatore down a una cifra in base 2 che prende @ei come 
// enabler e mette la sua uscita in @q, con eventuale riporto in @eu 
module b2_down_counter(eu, q, ei, clock, reset_);
  input clock, reset_;
  input ei;
  output eu, q;
  
	reg OUTR;
  assign q = OUTR;	
  
	wire a; // l'uscita del decrementatore
	b2_halfsubtractor inc (
		.x(q), .bin(ei),
		.d(a), .bout(eu)
	);

  always @(reset_ == 0) #1 OUTR <= 0;
  always @(posedge clock) if (reset_==1) #2 OUTR <= a;
endmodule
