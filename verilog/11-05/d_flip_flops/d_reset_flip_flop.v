// un D flip-flop pilotato sul fronte di salita con reset
module d_flip_flop(preset_, preclear_, d, p, q, q_N);
	input preset_, preclear_, d, p;
	
	reg Q;

	output q, q_N;
	assign q = Q;
	assign q_N = ~q;

	always @(negedge preset_ or negedge preclear_ or posedge p) begin
  	if (~preset_) begin
      Q <= 1'B1;
    end else if (~preclear_) begin
      Q <= 1'B0; 
    end else begin
      Q <= d; 
    end
  end
endmodule
