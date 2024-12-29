// un contatore up a 4 cifre in base 10 che prende @ei come enabler 
// e mette la sua uscita in @q33_q30, @q23_q20, @q13_q10 e @q03_q00, 
// con eventuale riporto in @eu 
module n4_b10_up_counter(eu, q33_q30, q23_q20, q13_q10, q03_q00, 
																						m_ei, m_clock, m_reset_);
  input m_clock, m_reset_;
  input m_ei;

	wire[3:0] eu3_eu0;
  
	output eu;
	assign eu = eu3_eu0[3];

	output[3:0] q03_q00;
	output[3:0] q13_q10;
	output[3:0] q23_q20;
	output[3:0] q33_q30;
  
	b10_up_counter count0 (
		.clock(m_clock), .reset_(m_reset_),
		.ei(m_ei),
		.eu(eu3_eu0[0]), .q3_q0(q03_q00)
	);
	
	b10_up_counter count1 (
		.clock(m_clock), .reset_(m_reset_),
		.ei(eu3_eu0[0]),
		.eu(eu3_eu0[1]), .q3_q0(q13_q10)
	);

	b10_up_counter count2 (
		.clock(m_clock), .reset_(m_reset_),
		.ei(eu3_eu0[1]),
		.eu(eu3_eu0[2]), .q3_q0(q23_q20)
	);

	b10_up_counter count3 (
		.clock(m_clock), .reset_(m_reset_),
		.ei(eu3_eu0[2]),
		.eu(eu3_eu0[3]), .q3_q0(q33_q30)
	);
endmodule
