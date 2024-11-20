// un contatore up a 4 cifre in base 3 che prende @ei come enabler e 
// mette la sua uscita in @q31_q30, @q21_q20, @q11_q10 e @q01_q00, 
// con eventuale riporto in @eu 
module n4_b3_up_counter(eu, q31_q30, q21_q20, q11_q10, q01_q00, m_ei, 
																									m_clock, m_reset_);
  input m_clock, m_reset_;
  input m_ei;

	wire[3:0] eu3_eu0;
  
	output eu;
	assign eu = eu3_eu0[3];

	output[1:0] q01_q00;
	output[1:0] q11_q10;
	output[1:0] q21_q20;
	output[1:0] q31_q30;
  
	b3_up_counter count0 (
		.clock(m_clock), .reset_(m_reset_),
		.ei(m_ei),
		.eu(eu3_eu0[0]), .q1_q0(q01_q00)
	);
	
	b3_up_counter count1 (
		.clock(m_clock), .reset_(m_reset_),
		.ei(eu3_eu0[0]),
		.eu(eu3_eu0[1]), .q1_q0(q11_q10)
	);

	b3_up_counter count2 (
		.clock(m_clock), .reset_(m_reset_),
		.ei(eu3_eu0[1]),
		.eu(eu3_eu0[2]), .q1_q0(q21_q20)
	);

	b3_up_counter count3 (
		.clock(m_clock), .reset_(m_reset_),
		.ei(eu3_eu0[2]),
		.eu(eu3_eu0[3]), .q1_q0(q31_q30)
	);
endmodule
