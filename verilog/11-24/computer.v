// un semplice calcolatore basato sull'architettura descritta negli
// appunti e nel testo del Corsini, "Dalle porte AND OR NOT al 
// sistema calcolatore", 2021.

// specifiche:
// - spazio di memoria a 16 bit, implementato come:
//   0000 | 60k di RAM
//   .... |
//   EFFF |
//   -----+------------
//   FF00 | 4k di EPROM 
//   .... |
//   FFFF |
//
// - spazio di I/O a 16 bit, mappato a porte 

// notare che la maggior parte dei moduli sono parametrizzati in
// dimensioni e temporizzazioni. questo pero' non significa che
// il processore funzionera' con dimensioni del bus arbitrarie
// (ad esempio, se si estende il bus a 32 bit, il processore 
// provera' comunque a leggere word da 16 bit nei registri 
// di indirizzo)

module computer (
	on_switch, reset_switch	// alimentazione
);
	
	input on_switch, reset_switch;

	// alimentazione 
	clock_gen clk(clock);

	reset_gen res (
		on_switch, reset_switch,
		reset_
	);

	// bus
	parameter RAM_SIZE = 16;
	parameter EPROM_SIZE = 12;
	parameter IO_SIZE = 16;

	wire[RAM_SIZE - 1:0] addr;
	wire[7:0] d7_d0;
	wire mr_, mw_, ior_, iow_;
	wire clock, reset_;
	
	// processore 
	processor proc (
		addr, 
		d7_d0, 
		mr_, mw_, ior_, iow_, 
		clock, reset_
	);

	// memoria
	mem_space mem (
		addr,
		d7_d0,
		mr_, mw_ 
	);

	io_space io (
		addr[IO_SIZE - 1:0],
		d7_d0,
		ior_, iow_
	);
endmodule

// utility (di alimentazione)
// per la generazione del clock e del reset
module clock_gen #(parameter CLOCK = 5) (clock);
	output reg clock;

	initial clock = 1'B0;
	always #CLOCK clock = ~clock; 
endmodule

module reset_gen #(parameter RESET_DELAY = 0) (
	on_switch, reset_switch,
	reset_
);
	
	input on_switch, reset_switch;
	output reg reset_;

	initial reset_ = 1'B0;

	always @(posedge on_switch) if(reset_switch == 0) begin
		reset_ <= 1'B0;
		#RESET_DELAY;
		reset_ <= 1'B1;
	end

	always @(posedge reset_switch)
		reset_ <= 1'B0;

	always @(negedge reset_switch) if(on_switch == 1) begin
		#RESET_DELAY;
		reset_ <= 1'B1;
	end
endmodule
