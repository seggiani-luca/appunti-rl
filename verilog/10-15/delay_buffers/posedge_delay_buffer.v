// un generatore di ritardo sul fronte di salita con variabile di
// ingresso @x e variabile di uscita ritardata @z
module posedge_delay_buffer(x, z);
	input x;
	output reg z;

	always @(posedge x) begin
		#5 z = x;
	end
	always @(negedge x) begin
		z = x;
	end
endmodule

// implementazione a porte logiche
module posedge_delay_buffer_p(x, z);
	input x;
	output z;

	reg y;
	initial y = 0;

	always @(posedge x or negedge x) begin
		#5 y = x;
	end

	assign z = y & x;
endmodule
