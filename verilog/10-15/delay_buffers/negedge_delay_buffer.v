// un generatore di ritardo sul fronte di discesa con variabile di
// ingresso @x e variabile di uscita ritardata @z
module negedge_delay_buffer(x, z);
	input x;
	output reg z;

	always @(posedge x) begin
		z <= x;
	end
	always @(negedge x) begin
		#5 z <= x;
	end
endmodule

// implementazione a porte logiche
module negedge_delay_buffer_p(x, z);
	input x;
	output z;

	reg y;
	initial y = 0;

	always @(posedge x or negedge x) begin
		#5 y = x;
	end

	assign z = y | x;
endmodule
