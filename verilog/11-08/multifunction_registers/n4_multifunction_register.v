// un registro multifunzione a 4 bit su K funzioni
module n4_multifunction_register 
	#(parameter K = 4) 
	(clock, reset_, x3_x0, b, z3_z0);
	
	input clock, reset_;
	input[3:0] x3_x0;
	output[3:0] z3_z0;

	input[$clog2(K):0] b;
	
	reg[3:0] OUTR;
	assign z3_z0 = OUTR;
	
	always @(reset_) if(reset_ == 0) #1 OUTR <= 'B0;
	always @(posedge clock) if(reset_ == 1) #3
		casex3_x0(b)
			0: OUTR <= f0(x3_x0, OUTR);
			1: OUTR <= f1(x3_x0, OUTR);
			2: OUTR <= f2(x3_x0, OUTR);
			3: OUTR <= f3(x3_x0, OUTR);
			// ... a piacere
		endcase
	
	function [3:0] f0(input [7:0] vals);
		// implementazione	
	endfunction

	function [3:0] f1(input [7:0] vals);
		// implementazione	
	endfunction
	
	function [3:0] f2(input [7:0] vals);
		// implementazione	
	
	endfunction
	function [3:0] f3(input [7:0] vals);
		// implementazione	
	endfunction

	// ... come sopra
endmodule
