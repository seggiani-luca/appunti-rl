// un riduttore di campo per interi in codifica binaria con LSD 
// @x1_x0, che mette in @ow la fattibilità (attiva bassa) della
// riduzione
module b2_field_reducer(x1_x0, ow);
	input[1:0] x1_x0;
	output ow;

	assign ow = ^x1_x0;
endmodule
