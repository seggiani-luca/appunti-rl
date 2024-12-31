// un convertitore da codifica binaria a codifica BCD, che prende le 
// 8 cifre @x7_x0 e mette la loro codifica BCD in @a3_a0, @b3_b0 e
// @c3_c0
module n8_b2_bcd_converter(x7_x0, a3_a0, b3_b0, c3_c0,
													 clock, reset_);
	input clock, reset_;
	input[7:0] x7_x0;
	output[3:0] a3_a0, b3_b0, c3_c0;

	reg[19:0] s19_s0;
	wire[19:0] s19_s0_add3;

	add_3 d3_1 (
		.x3_x0(s19_s0[19:16]), .z3_z0(s19_s0_add3[19:16])
	);
	add_3 d3_2 (
		.x3_x0(s19_s0[15:12]), .z3_z0(s19_s0_add3[15:12])
	);
	add_3 d3_3 (
		.x3_x0(s19_s0[11:8]), .z3_z0(s19_s0_add3[11:8])
	);
	
	assign s19_s0_add3[7:0] = s19_s0[7:0];

	assign a3_a0 = s19_s0[19:16];
	assign b3_b0 = s19_s0[15:12];
	assign c3_c0 = s19_s0[11:8];

	reg[2:0] COUNT;

	reg[1:0] STAR;
	localparam
		s0 = 'B00,
		s1 = 'B01,
		s2 = 'B10,
		s3 = 'B11;

	always @(reset_) if (reset_ == 0) #1 STAR = s0;
	
	always @(posedge clock) if (reset_ == 1) #3
		case(STAR)
			s0: begin 
						s19_s0 <= {12'B0, x7_x0};
						COUNT <= 7;
						STAR <= s1;
					end
			s1: begin
						s19_s0 <= s19_s0_add3;
						STAR <= s2;
					end
			s2: begin 
						s19_s0 <= s19_s0 << 1;
						STAR <= (COUNT == 0) ? s3 : s1;
						COUNT <= COUNT - 1;
					end
			s3: begin 
						STAR <= s3;	
					end
		endcase
endmodule

// una sottorete che implementa il controllo > 5 ed effettua 
// l'addizione di 3 per una cifra bcd
module add_3(x3_x0, z3_z0);
	input[3:0] x3_x0;
	output[3:0] z3_z0;

	// sarebbe un comparatore con generatori di costante (a 5) seguito
	// da un sommatore, entrambi a 4 bit, o una rete equivalente
	assign z3_z0 = (x3_x0 >= 5) ? x3_x0 + 3 : x3_x0;
endmodule
