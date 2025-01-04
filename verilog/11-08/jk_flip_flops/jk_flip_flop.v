// un flip-flop JK pilotato sul fronte di salita
module jk_flip_flop(clock, j, k, q, q_N);
	input clock, j, k;

	reg Q;
	
	output q, q_N;
	assign q = Q;
	assign q_N = ~q;

	initial Q <= 0; // oppure reset
	
	wire y;
	assign y = ~Q & j | Q & ~k;

	always @(posedge clock) #2 Q <= y;
endmodule
