module testbench();
	reg on_switch;
	reg reset_switch;

	computer cmp (
		on_switch, reset_switch
	);

	initial begin
		$dumpfile("computer_waveform.vcd");
		$dumpvars;	

		$display("Loaded EPROM from memory/dumps/eprom_data.dat at simulation start.");
		$readmemh("../memory/dumps/eprom_data.dat", cmp.mem.prm.LOCATION);

		on_switch = 0;
		reset_switch = 0;

		#3;

		on_switch = 1;

		wait (cmp.proc.STAR == 42); // 42 e' lo stato di halt

		#20;

		$display("Dumped RAM to memory/dumps/ram_data.dat at simulation finish.");
		$writememh("../memory/dumps/ram_data.dat", cmp.mem.rm.LOCATION);
		
		$finish;
	end
endmodule
