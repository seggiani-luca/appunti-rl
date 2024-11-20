// un contatore down a 4 cifre in base 2 che prende @ei come enabler 
// e mette la sua uscita in @q3_q0, con eventuale riporto in @eu 
module n4_b2_down_counter(eu, q3_q0, m_ei, m_clock, m_reset_);
  input m_clock, m_reset_;
  input m_ei;
	
	wire[3:0] eu3_eu0;

	output eu;
	assign eu = eu3_eu0[3];
	output[3:0] q3_q0;

	b2_down_counter count0 (
		.clock(m_clock), .reset_(m_reset_),
		.ei(m_ei),
		.eu(eu3_eu0[0]), .q(q3_q0[0])
	);
	
	b2_down_counter count1 (
		.clock(m_clock), .reset_(m_reset_),
		.ei(eu3_eu0[0]),
		.eu(eu3_eu0[1]), .q(q3_q0[1])
	);

	b2_down_counter count2 (
		.clock(m_clock), .reset_(m_reset_),
		.ei(eu3_eu0[1]),
		.eu(eu3_eu0[2]), .q(q3_q0[2])
	);

	b2_down_counter count3 (
		.clock(m_clock), .reset_(m_reset_),
		.ei(eu3_eu0[2]),
		.eu(eu3_eu0[3]), .q(q3_q0[3])
	);
endmodule
