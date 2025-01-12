// un convertitore analogico-digitale ad approssimazioni successive
// a 8 bit e fondo scala a 10 volts
module analog_digital_converter(reset_,
																v, x7_x0, digit 
																soc, eoc);
	input reset_;
	input real v;
	output[7:0] x7_x0;
	input soc;
	output eoc;

	parameter real FSR = 10;
	parameter real K = FSR / (2 ** 8);

	wire i7_i0;
	assign x7_x0 = i7_i0;

	wire a_out;
	
	digital_analog_converter #(.FSR(FSR)) dac (
		.x7_x0(i7_i0), .a_out(a_out)
	);

	wire digit;
	assign digit = v > (a_out - K / 2) ? 1'B1 : 0'B0;
	
	wire sar_clock;
	initial sar_clock = 0;
	always @(*) #1 sar_clock = ~sar_clock;

	successive_approximation_register sar (
		.clock(sar_clock), .reset_(reset_),
		.x7_x0(i7_i0), .digit(digit),
		.soc(soc), .eoc(eoc)
	);
endmodule

// prima implementazione registro SAR
module successive_approximation_register(clock, reset_,
																				 x7_x0, digit,
																				 soc, eoc);	
	input clock, reset_;
	input real v;
	output[7:0] x7_x0;
	input digit;
	input soc;
	output eoc;

	reg[7:0] RBR;
	assign x7_x0 = RBR;

	reg EOC;
	assign eoc = EOC;

	reg[3:0] STAR;
	localparam
		s0 = 0,
		s1 = 1,
		s2 = 2,
		s3 = 3,
		s4 = 4,
		s5 = 5,
		s6 = 6,
		s7 = 7,
		s8 = 8,
		s9 = 9,
		s10 = 10;

	always @(reset_ == 0) #1 begin
		STAR <= s0;
		EOC <= 1;
	end
	
	always @(posedge clock) if(reset_ == 1) #3 begin
		casex(STAR)
			s0 : begin
				EOC <= 1;
				STAR <= (soc == 1) ? s1 : s0;
			end
			s1 : begin
				RBR <= 8'B1000_0000;
				EOC <= 0;
				STAR <= s2;
			end
			s2 : begin
				RBR <= {alpha, 'B100_0000};
				STAR <= s3;
			end
			s3 : begin
				RBR <= {RBR[7], alpha, 'B10_0000};
				STAR <= s4;
			end
			s4 : begin
				RBR <= {RBR[7:6], alpha, 'B1_0000};
				STAR <= s5;
			end
			s5 : begin
				RBR <= {RBR[7:5], alpha, 'B1000};
				STAR <= s6;
			end
			s6 : begin
				RBR <= {RBR[7:4], alpha, 'B100};
				STAR <= s7;
			end
			s7 : begin
				RBR <= {RBR[7:3], alpha, 'B10};
				STAR <= s8;
			end
			s8 : begin
				RBR <= {RBR[7:2], alpha, 'B1};
				STAR <= s9;
			end
			s9 : begin
				RBR <= {RBR[7,1], alpha};
				STAR <= s10;
			end
			s10 : begin
				STAR <= (soc == 0) ? s0: s10;
			end
		endcase
	end
endmodule

// seconda implementazione registro SAR, piu' compatta
module successive_approximation_register(clock, reset_,
																				 x7_x0, digit,
																				 soc, eoc);	
	input clock, reset_;
	input real v;
	output[7:0] x7_x0;
	input digit;
	input soc;
	output eoc;

	reg[7:0] RBR;
	assign x7_x0 = RBR;

	reg EOC;
	assign eoc = EOC;

	reg[2:0] COUNT;

	reg[1:0] STAR;
	localparam
		s0 = 0,
		s1 = 1,
		s2 = 2,
		s3 = 3;

	always @(reset_ == 0) #1 begin
		STAR <= s0;
		COUNT <= 7;
		EOC <= 1;
	end

  function[7:0] newbyte; 
  	input[7:0] rbr; 
    input digit; 
    input[2:0] count; 
    casex(count) 
    	7: newbyte = {          digit, 'B100_0000}; 
      6: newbyte = {rbr[7],   digit, 'B10_0000};  
      5: newbyte = {rbr[7:6], digit, 'B1_0000}; 
      4: newbyte = {rbr[7:5], digit, 'B1000};  
      3: newbyte = {rbr[7:4], digit, 'B100}; 
      2: newbyte = {rbr[7:3], digit, 'B10}; 
      1: newbyte = {rbr[7:2], digit, 'B1};  
      0: newbyte = {rbr[7:1], digit};  
    endcase 
	endfunction 
	
	always @(posedge clock) if(reset_ == 1) #3 begin
		casex(STAR)
			s0 : begin
				EOC <= 1;
				COUNT <= 7;
				STAR <= (soc == 1) ? s1 : s0;
			end
			s1 : begin
				RBR <= 8'B1000_0000;
				EOC <= 0;
				STAR <= s2;
			end
			s2 : begin
				RBR <= newbyte(RBR, digit, COUNT);
				COUNT <= COUNT - 1;
				STAR <= (COUNT == 0) ? s3 : s2;
			end
			s3 : begin
				STAR <= (soc == 0) ? s0 : s3;
			end
		endcase
	end
endmodule
