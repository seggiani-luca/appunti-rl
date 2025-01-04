// un D flip-flop pilotato sul fronte di salita
module d_flip_flop(d, p, q, q_N);
	input d, p;
	
	reg Q;

	output q, q_N;
	assign q = Q;
	assign q_N = ~q;

	initial Q = 0; // oppure reset

	always @(posedge p) #2 Q <= d;
endmodule
