// un'interfaccia di conversione analogico-digitale
module analog_digital_converter(clock, reset_,
																s_, ior_, iow_, a0, d7_d0,
																v);
	input clock, reset_;
	input reset_;
	input s_, ior_, iow_;
	input a0;
	inout d7_d0;
	input real v;

	reg SOC;

	wire e_x, e_s, e_e;
	hs_parallel_in_comb comb (
		.s_(s_), .ior_(ior_), .iow_(iow_), .a0(a0),
		.e_x(e_x), .e_s(e_s), .e_e(e_e)
	);

	wire[7:0] rbr;
	wire eoc;

	analog_digital_converter adc (
		.reset_(reset_), 
		.v(v), .x7_x0(rbr),
		.soc(SOC), .eoc(eoc)
	)

	always @(posedge e_s) #1 
		SOC <= d7_d0[1];
	assign d7_d0[0] = e_e ? eoc : 'HZ;
	assign d7_d0 = e_x ? rbr : 'HZ;
	
endmodule

module analog_digital_comb(s_, ior_, iow_, a0, e_x, e_s, e_e);
	input s_, ior_, iow_, a0;
	output e_x, e_s, e_e;

	assign {e_x, e_s, e_e} = ({s_, ior_, iow_, a0} == 3'B0010) ? 'B001:
													 {{s_, ior_, iow_, a0} == 3'B0100) ? 'B010:
													 {{s_, ior_, iow_, a0} == 3'B0011) ? 'B100:
													 /*						don't care					*/ 'B000;
endmodule
