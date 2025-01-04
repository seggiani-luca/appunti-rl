// un flip-flop JK pilotato sul fronte di salita con reset
module jk_flip_flop(clock, preset_, preclear_, j, k, q, q_N);
	input preset_, preclear_, clock, j, k;

	reg Q;
	
	output q, q_N;
	assign q = Q;
	assign q_N = ~q;

	initial Q <= 0; // oppure reset
	
	wire y;
	assign y = ~Q & j | Q & ~k;

	always @(negedge preset_ or negedge preclear_ or posedge clock) 
																																begin
  	if (~preset_) begin
      Q <= 1'B1;
    end else if (~preclear_) begin
      Q <= 1'B0; 
    end else begin
      Q <= y; 
    end
  end
endmodule
