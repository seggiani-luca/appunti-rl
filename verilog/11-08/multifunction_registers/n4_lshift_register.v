// un registro di shift a sinistra su 4 bit
module n4_lshift_register(clock, reset_, x3_x0, b, z3_z0);
	input clock, reset_;
	input[3:0] x3_x0;
	output[3:0] z3_z0;

	input b; // shift a 1
	
	reg[3:0] OUTR;
	assign z3_z0 = OUTR;
	
	wire[3:0] x_shift;

	n4_l_shifter shl (
		.x3_x0(OUTR), .z3_z0(x_shift)
	);

	always @(reset_) if(reset_ == 0) #1 OUTR <= 'B0;
	always @(posedge clock) if(reset_ == 1) #3
		case(b)
			0: OUTR <= x3_x0;
			1: OUTR <= x_shift;
		endcase
endmodule

// sottorete che implementa lo shift a sinistra
module n4_l_shifter(x3_x0, z3_z0);
	input[3:0] x3_x0;
	output[3:0] z3_z0;

	assign z3_z0 = {x3_x0[2:0], 1'B0};
endmodule
