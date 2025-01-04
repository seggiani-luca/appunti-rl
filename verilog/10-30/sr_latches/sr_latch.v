// un latch SR senza preset e preclear
module sr_latch(s, r, q, q_N);
	input s, r;

	reg Q;
	output q, q_N;
	assign q = Q;
	assign q_N = ~Q;

	always @(s or r) #2 
		Q <= ({s, r} == 'B00) ? Q: 
				 ({s, r} == 'B01) ? 'B0:    
				 ({s, r} == 'B10) ? 'B1:
				 /*	 don't care  */ 'BX;
endmodule

// implementazione a porte logiche (solo rappresentativa, Verilog 
// (teoricamente) non supporta i cicli di retroazione cosi' definiti)
module sr_latch_p(s, r, q, q_N);
	input s, r;

	output q, q_N;

	assign q = ~(q_N | r);
	assign q_N = ~(q | s);
endmodule
