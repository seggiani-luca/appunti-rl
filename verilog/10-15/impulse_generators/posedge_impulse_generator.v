// generatore di impulso sul fronte di salita con variabile di 
// ingresso @x e variabile d'impulso @z
module posedge_impulse_generator(x, z);
	input x;
	output reg z;

	initial z = 0;

	always @(posedge x) begin
		z = 1;
		#5;
		z = 0;
	end
endmodule

// implementazione a porte logiche
module posedge_impulse_generator_p(x, z);
	input x;
	output z;

	reg y;
	initial y = 0;

	always @(posedge x or negedge x) begin
		#5 y = x;
	end

	assign z = ~y & x;
endmodule
