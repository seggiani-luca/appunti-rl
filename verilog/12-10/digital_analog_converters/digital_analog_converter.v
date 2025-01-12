// un convertitore digitale-analogico a 3 bit di controllo e fondo
// scala a 10 volts
module digital_analog_converter(x2_x0, a_out);
	input[2:0] x2_x0;
	output real a_out;

	parameter real FSR = 10;
	parameter real K = FSR / (2 ** 3);

	always @(*) begin
		a_out = x2_x0 * K;
	end
endmodule
