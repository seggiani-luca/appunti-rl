module processor #(
	parameter RAM_SIZE = 16,
	parameter EPROM_SIZE = 12,
	parameter IO_SIZE = 16,
	parameter STATE_SIZE = 8,
	parameter APP_REGISTERS = 2
)
(
	addr, 
	d7_d0, 
	mr_, mw_, ior_, iow_, 
	clock, reset_
);

	output[RAM_SIZE - 1:0] addr;
	inout[7:0] d7_d0;
	output mr_, mw_, ior_, iow_;
	input clock, reset_;

	// registri programmatore
	reg[7:0] AH, AL;	

	// 7  6  5  4  3  2  1  0
	// xx xx xx xx OF SF ZF CF
	reg[7:0] FLAG;

	reg[RAM_SIZE - 1:0] IP, DP, SP;

	// registri interni
	reg[RAM_SIZE - 1:0] ADDR;
	assign addr = ADDR;

	reg[7:0] D7_D0;
	reg DIR;
	assign d7_d0 = DIR ? D7_D0 : 'HZ;

	reg MR, MW, IOR, IOW;
	assign mr_ = MR;
	assign mw_ = MW;
	assign ior_ = IOR;
	assign iow_ = IOW;

	reg[STATE_SIZE - 1:0] STAR;
	localparam
		// gli stati disattivati erano previsti con linee di indirizzo 
		// piu' grandi di 16 bit

		// routine di lettura in memoria
		readB = 0, 
		readW = 1, 
 // readM = 2, 
 // readL = 3,

		read0 = 4,
		read1 = 5,
 // read2 = 6,
 // read3 = 7,
		read4 = 8,

		// routine di scrittura in memoria
		writeB = 9, 
		writeW = 10, 
 // writeM = 11, 
 // writeL = 12,

		write0 = 13,
		write1 = 14,
		write2 = 15,
		write3 = 16,
		write4 = 17,
 // write5 = 18,
 // write6 = 19,
 // write7 = 20,
 // write8 = 21,
 // write9 = 22,
 // write10 = 23,
		write11 = 24,

		// fasi di fetch
		fetch0 = 25,
		fetch1 = 26,
		fetch2 = 27,
		fetch3 = 28,
		fetch4 = 29,
		fetch5 = 30,
		
		// formati di fetch
		F2fetch0 = 31,
		F2fetch1 = 32,

		F3fetch0 = 33,

		F4fetch0 = 34,
		F4fetch1 = 35,
		
		F5fetch0 = 36,
		F5fetch1 = 37,
		F5fetch2 = 38,
		
		F6_7fetch0 = 39,
		F6_7fetch1 = 40,
		
		// stati di esecuzione
		// istruzioni senza operandi 
		nvi = 41,
		hlt = 42,
		nop = 43,

		// istruzioni di movimento
		ALtoAH = 44,
		AHtoAL = 45,

		lodImmDP0 = 46,
		lodImmDP1 = 47,
		lodImmSP0 = 48,
		lodImmSP1 = 49,
		lodDP0 = 50,
		lodDP1 = 51,
		lodDP2 = 52,
		stoDP0 = 53,
		stoDP1 = 54,

		lodAL = 55,
		lodAH = 56,
		stoAL = 57,
		stoAH = 58,

		incDP = 59,

		// istruzioni logico/aritmetiche
		aluAL = 60,
		aluAH = 61,
		aluAH_AL = 62,
		aluAL_AH = 63,

		// istruzioni di pila
		pushAL = 64,
		popAL0 = 65,
		popAL1 = 66,
		
		pushAH = 67,
		popAH0 = 68,
		popAH1 = 69,
		
		pushDP = 70,
		popDP0 = 71,
		popDP1 = 72,

		ret0 = 73,
		ret1 = 74,

		// istruzioni di input/output
		in0 = 75,
		in1 = 76,
		in2 = 77,
		in3 = 78,
		
		out0 = 79,
		out1 = 80,
		out2 = 81,
		out3 = 82,
		out4 = 83,

		// istruzioni di salto
		jmp = 84,
		call0 = 85,
		call1 = 86
		;

	// codifiche formati di fetch
	localparam
		F0 = 3'B000,
		F1 = 3'B001,
		F2 = 3'B010,
		F3 = 3'B011,
		F4 = 3'B100,
		F5 = 3'B101,
		F6 = 3'B110,
		F7 = 3'B111;

	reg[STATE_SIZE - 1:0] MJR;

	reg[7:0] OPCODE;
	reg[7:0] SOURCE;
	reg[RAM_SIZE - 1:0] DEST_ADDR;

	reg[7:0] APP[0:APP_REGISTERS];
	reg[APP_REGISTERS - 1:0] NUMLOC;

	function[STATE_SIZE - 1:0] first_exec_state;
		input[7:0] opcode;
		first_exec_state = // istruzioni senza operandi 
											 (opcode == 8'B0000_0000) ? hlt:
											 (opcode == 8'B0000_1001) ? nop:

											 // istruzioni di movimento
											 (opcode == 8'B0000_1010) ? ALtoAH:
											 (opcode == 8'B0000_1011) ? AHtoAL:

											 (opcode == 8'B0010_0010) ? lodImmDP0:
											 (opcode == 8'B0010_0011) ? lodImmSP0:

											 (opcode == 8'B0010_0100) ? lodDP0:
											 (opcode == 8'B0010_0101) ? stoDP0:
											 
											 (opcode == 8'B0100_0000) ? lodAL:
											 (opcode == 8'B1000_0000) ? lodAL:
											 (opcode == 8'B1010_0000) ? lodAL:
											 
											 (opcode == 8'B0100_0110) ? lodAH:
											 (opcode == 8'B1000_0110) ? lodAH:
											 (opcode == 8'B1010_0110) ? lodAH:
											 
											 (opcode == 8'B0110_0000) ? stoAL:
											 (opcode == 8'B1100_0000) ? stoAL:
											 
											 (opcode == 8'B0110_0001) ? stoAH:
											 (opcode == 8'B1100_0001) ? stoAH:

											 // istruzioni logico/aritmetiche
											 (opcode == 8'B0001_1001) ? incDP:
											 
											 (opcode == 8'B0000_0110) ? aluAL:
											 (opcode == 8'B0000_0111) ? aluAL:
											 (opcode == 8'B0000_1000) ? aluAL:
											 
											 (opcode == 8'B0010_0110) ? aluAH:
											 (opcode == 8'B0010_0111) ? aluAH:
											 (opcode == 8'B0010_1000) ? aluAH:
											 	
											 (opcode == 8'B0000_0001) ? aluAH_AL:
											 (opcode == 8'B0100_0001) ? aluAL:
											 (opcode == 8'B1000_0001) ? aluAL:
											 (opcode == 8'B1010_0001) ? aluAL:

											 (opcode == 8'B0000_0010) ? aluAH_AL:
											 (opcode == 8'B0100_0010) ? aluAL:
											 (opcode == 8'B1000_0010) ? aluAL:
											 (opcode == 8'B1010_0010) ? aluAL:

											 (opcode == 8'B0000_0011) ? aluAH_AL:
											 (opcode == 8'B0100_0011) ? aluAL:
											 (opcode == 8'B1000_0011) ? aluAL:
											 (opcode == 8'B1010_0011) ? aluAL:

											 (opcode == 8'B0000_0100) ? aluAH_AL:
											 (opcode == 8'B0100_0100) ? aluAL:
											 (opcode == 8'B1000_0100) ? aluAL:
											 (opcode == 8'B1010_0100) ? aluAL:

											 (opcode == 8'B0000_0101) ? aluAH_AL:
											 (opcode == 8'B0100_0101) ? aluAL:
											 (opcode == 8'B1000_0101) ? aluAL:
											 (opcode == 8'B1010_0101) ? aluAL:

											 (opcode == 8'B0001_0001) ? aluAL_AH:
											 (opcode == 8'B0101_0001) ? aluAH:
											 (opcode == 8'B1001_0001) ? aluAH:
											 (opcode == 8'B1011_0001) ? aluAH:

											 (opcode == 8'B0001_0010) ? aluAL_AH:
											 (opcode == 8'B0101_0010) ? aluAH:
											 (opcode == 8'B1001_0010) ? aluAH:
											 (opcode == 8'B1011_0010) ? aluAH:

											 (opcode == 8'B0001_0011) ? aluAL_AH:
											 (opcode == 8'B0101_0011) ? aluAH:
											 (opcode == 8'B1001_0011) ? aluAH:
											 (opcode == 8'B1011_0011) ? aluAH:

											 (opcode == 8'B0001_0100) ? aluAL_AH:
											 (opcode == 8'B0101_0100) ? aluAH:
											 (opcode == 8'B1001_0100) ? aluAH:
											 (opcode == 8'B1011_0100) ? aluAH:

											 (opcode == 8'B0001_0101) ? aluAL_AH:
											 (opcode == 8'B0101_0101) ? aluAH:
											 (opcode == 8'B1001_0101) ? aluAH:
											 (opcode == 8'B1011_0101) ? aluAH:

											 // istruzioni di pila
											 (opcode == 8'B0001_1010) ? pushAL:
											 (opcode == 8'B0001_1011) ? popAL0:

											 (opcode == 8'B0001_1100) ? pushAH:
											 (opcode == 8'B0001_1101) ? popAH0:

											 (opcode == 8'B0001_1110) ? pushDP:
											 (opcode == 8'B0001_1111) ? popDP0:

											 (opcode == 8'B0001_0000) ? ret0:
											 
											 // istruzioni di input/output
											 (opcode == 8'B0010_0000) ? in0:
											 (opcode == 8'B0010_0001) ? out0:

											 // istruzioni di salto
											 (opcode == 8'B1110_0000) ? jmp:
											 (opcode == 8'B1110_0001) ? jmp:
											 (opcode == 8'B1110_0010) ? jmp:
											 (opcode == 8'B1110_0011) ? jmp:
											 (opcode == 8'B1110_0100) ? jmp:
											 (opcode == 8'B1110_0101) ? jmp:
											 (opcode == 8'B1110_0110) ? jmp:
											 (opcode == 8'B1110_0111) ? jmp:
											 (opcode == 8'B1110_1000) ? jmp:
											 (opcode == 8'B1110_1001) ? jmp:
											 (opcode == 8'B1110_1010) ? jmp:
											 (opcode == 8'B1110_1011) ? jmp:
											 (opcode == 8'B1110_1100) ? jmp:
											 (opcode == 8'B1110_1101) ? jmp:
											 (opcode == 8'B1110_1110) ? jmp:
											 (opcode == 8'B1110_1111) ? jmp:
											 (opcode == 8'B1111_0000) ? jmp:
											 (opcode == 8'B1111_0001) ? jmp:
											 (opcode == 8'B1111_0010) ? jmp:
											 (opcode == 8'B1111_0011) ? call0:

											 /*			don't care		*/   nvi;
	endfunction

	function jmp_condition;
		input[4:0] opcode;
		input[7:0] flag;

		reg of, sf, zf, cf;
		
		begin
			{of ,sf, zf, cf} = flag[3:0];

			casex(opcode)
				// condizioni generali
				5'B0_0000 : jmp_condition = 1'B1;															// jmp
				5'B0_1011 : jmp_condition = (zf) ? 1'B1 : 1'B0;								// jz
				5'B0_1100 : jmp_condition = (~zf) ? 1'B1 : 1'B0;							// jnz
				5'B0_1101 : jmp_condition = (cf) ? 1'B1 : 1'B0;								// jc
				5'B0_1110 : jmp_condition = (~cf) ? 1'B1 : 1'B0;							// jnc
				5'B0_1111 : jmp_condition = (of) ? 1'B1 : 1'B0;								// jo
				5'B1_0000 : jmp_condition = (~of) ? 1'B1 : 1'B0;							// jno
				5'B1_0001 : jmp_condition = (sf) ? 1'B1 : 1'B0;								// js
				5'B1_0010 : jmp_condition = (~sf) ? 1'B1 : 1'B0;							// jns

				// condizioni su naturali
				5'B0_0001 : jmp_condition = (zf) ? 1'B1 : 1'B0; 							// je 
				5'B0_0010 : jmp_condition = (~zf) ? 1'B1 : 1'B0; 							// jne 
				5'B0_0011 : jmp_condition = (~zf & ~cf) ? 1'B1 : 1'B0; 				// ja 
				5'B0_0100 : jmp_condition = (~cf) ? 1'B1 : 1'B0; 							// jae 
				5'B0_0101 : jmp_condition = (cf) ? 1'B1 : 1'B0; 							// jb 
				5'B0_0110 : jmp_condition = (zf | cf) ? 1'B1 : 1'B0; 					// jbe 
				
				// condizioni su interi
				5'B0_0111 : jmp_condition = (~zf & (of == sf)) ? 1'B1 : 1'B0;	// jg
				5'B0_1000 : jmp_condition = (of == sf) ? 1'B1 : 1'B0; 				// jge 
				5'B0_1001 : jmp_condition = (of != sf) ? 1'B1 : 1'B0; 				// jl
				5'B0_1010 : jmp_condition = (zf | (of == sf)) ? 1'B1 : 1'B0; 	// jle 
			endcase
		end
	endfunction

	wire[7:0] al_result;
	wire[7:0] al_flag;
	alu al_alu (
		.opcode(OPCODE[3:0]), .source(SOURCE), .dest(AL),
		.result(al_result), .flag(al_flag)
	);

	wire[7:0] ah_result;
	wire[7:0] ah_flag;
	alu ah_alu (
		.opcode(OPCODE[3:0]), .source(SOURCE), .dest(AH),
		.result(ah_result), .flag(ah_flag)
	);
	
	wire[7:0] ah_al_result;
	wire[7:0] ah_al_flag;
	alu ah_al_alu (
		.opcode(OPCODE[3:0]), .source(AH), .dest(AL),
		.result(ah_al_result), .flag(ah_al_flag)
	);
	
	wire[7:0] al_ah_result;
	wire[7:0] al_ah_flag;
	alu al_ah_alu (
		.opcode(OPCODE[3:0]), .source(AL), .dest(AH),
		.result(al_ah_result), .flag(al_ah_flag)
	);

	always @(reset_ == 0) begin
		IP <= {{RAM_SIZE - EPROM_SIZE{1'B1}}, {EPROM_SIZE{1'B0}}};
		FLAG <= 8'H00;
		DIR <= 0;
		MR <= 1; MW <= 1;
		IOR <= 1; IOW <= 1;
		STAR <= fetch0;
	end

	always @(posedge clock) if(reset_ == 1) begin
		casex(STAR)
			// routine di lettura in memoria
			readB : begin
				DIR <= 0;
				MR <= 0;
				NUMLOC <= 0;
				STAR <= read0;
			end  
			readW : begin
				DIR <= 0;
				MR <= 0;
				NUMLOC <= 1;
				STAR <= read0;
			end
			
			read0 : begin
				APP[0] <= d7_d0;
				ADDR <= ADDR + 1;
				NUMLOC <= NUMLOC - 1;
				STAR <= (NUMLOC == 0) ? read4 : read1;
			end
			read1 : begin
				APP[1] <= d7_d0;
				ADDR <= ADDR + 1;
				NUMLOC <= NUMLOC - 1;
				STAR <= read4;
			end
			read4 : begin
				MR <= 1;
				STAR <= MJR;
			end

			// routine di scrittura in memoria
			writeB : begin
				D7_D0 <= APP[0];
				DIR <= 1;
				NUMLOC <= 0;
				STAR <= write0;
			end 
			writeW : begin
				D7_D0 <= APP[0];
				DIR <= 1;
				NUMLOC <= 1;
				STAR <= write0;
			end 

			write0 : begin
				MW <= 0;
				STAR <= write1;
			end 
			write1 : begin
				MW <= 1;
				STAR <= (NUMLOC == 0) ? write11 : write2;
			end 
			write2 : begin 
				D7_D0 <= APP[1];
				ADDR <= ADDR + 1;
				NUMLOC <= NUMLOC - 1;
				STAR <= write3;
			end 
			write3 : begin 
				MW <= 0;
				STAR <= write4;
			end 
			write4 : begin 
				MW <= 1;
				STAR <= write11;
			end 
			write11 : begin 
				DIR <= 0;
				STAR <= MJR;
			end 

			// fasi di fetch
			fetch0 : begin 
				ADDR <= IP;
				IP <= IP + 1;
				MJR <= fetch1;
				STAR <= readB;
			end
			fetch1 : begin
				OPCODE <= APP[0];
				STAR <= fetch2;
			end
			fetch2 : begin
				MJR <= (OPCODE[7:5] == F0) ? fetch4:
							 (OPCODE[7:5] == F1) ? fetch4:
							 (OPCODE[7:5] == F2) ? F2fetch0:
							 (OPCODE[7:5] == F3) ? F3fetch0:
							 (OPCODE[7:5] == F4) ? F4fetch0:
							 (OPCODE[7:5] == F5) ? F5fetch0:
							 (OPCODE[7:5] == F6) ? F6_7fetch0:
						 /*(OPCODE[7:5] == F7)?*/F6_7fetch0;
				STAR <= fetch3;
			end
			fetch3 : begin
				STAR <= MJR;
			end
			fetch4 : begin
				MJR <= first_exec_state(OPCODE);
				STAR <= fetch5;
			end
			fetch5 : begin
				STAR <= MJR;
			end
			
			// formati di fetch
			F2fetch0 : begin
				ADDR <= DP;
				MJR <= F2fetch1;
				STAR <= readB;
			end
			F2fetch1 : begin
				SOURCE <= APP[0];
				STAR <= fetch4;
			end

			F3fetch0 : begin
				DEST_ADDR <= DP;
				STAR <= fetch4;
			end

			F4fetch0 : begin
				ADDR <= IP;
				IP = IP + 1;
				MJR <= F4fetch1;
				STAR <= readB;
			end
			F4fetch1 : begin
				SOURCE <= APP[0];
				STAR <= fetch4;
			end
			
			F5fetch0 : begin
				ADDR <= IP;
				IP = IP + 2;
				MJR <= F5fetch1;
				STAR <= readW;
			end
			F5fetch1 : begin
				ADDR <= {APP[1], APP[0]};
				MJR <= F5fetch2;
				STAR <= readB;
			end
			F5fetch2 : begin
				SOURCE <= APP[0];
				STAR <= fetch4;
			end
			
			F6_7fetch0 : begin
				ADDR <= IP;
				IP = IP + 2;
				MJR <= F6_7fetch1;
				STAR <= readW;	
			end
			F6_7fetch1 : begin
				DEST_ADDR <= {APP[1], APP[0]};
				STAR <= fetch4;
			end

			// stati di esecuzione
			// istruzioni senza operandi
			nvi : begin
				STAR <= nvi;
			end
			hlt : begin
				STAR <= hlt;
			end
			nop : begin
				STAR <= fetch0;
			end

			// istruzioni di movimento
			ALtoAH : begin
				AH <= AL;
				STAR <= fetch0;
			end
			AHtoAL : begin
				AL <= AH;
				STAR <= fetch0;
			end

			lodImmDP0 : begin 
				ADDR <= IP;
				IP = IP + 2;
				MJR <= lodImmDP1;
				STAR <= readW;
			end
			lodImmDP1 : begin 
				DP <= {APP[1], APP[0]};
				STAR <= fetch0;
			end
			
			lodImmSP0 : begin 
				ADDR <= IP;
				IP = IP + 2;
				MJR <= lodImmSP1;
				STAR <= readW;
			end
			lodImmSP1 : begin 
				SP <= {APP[1], APP[0]};
				STAR <= fetch0;
			end

			lodDP0 : begin 
				ADDR <= IP;
				IP = IP + 2;
				MJR <= lodDP1;
				STAR <= readW;
			end
			lodDP1 : begin 
				ADDR <= {APP[1], APP[0]};
				MJR <= lodDP2;
				STAR <= readW;
			end
			lodDP2 : begin 
				DP <= {APP[1], APP[0]};
				STAR <= fetch0;
			end
			
			stoDP0 : begin 
				ADDR <= IP;
				IP <= IP + 2;
				MJR <= stoDP1;
				STAR <= readW;
			end
			stoDP1 : begin 
				ADDR <= {APP[1], APP[0]};
				{APP[1], APP[0]} <= DP;
				MJR <= fetch0;
				STAR <= writeW;
			end
		
			lodAL : begin 
				AL <= SOURCE;
				STAR <= fetch0;
			end
			lodAH : begin 
				AH <= SOURCE;
				STAR <= fetch0;
			end
			stoAL : begin 
				ADDR <= DEST_ADDR;
				APP[0] <= AL;
				MJR <= fetch0;
				STAR <= writeB;
			end
			stoAH : begin 
				ADDR <= DEST_ADDR;
				APP[0] <= AH;
				MJR <= fetch0;
				STAR <= writeB;
			end
			
			// istruzioni logico/aritmetiche
			incDP : begin
				DP <= DP + 1;
				STAR <= fetch0;
			end

			aluAL : begin
				AL <= al_result;
				FLAG <= al_flag;
				STAR <= fetch0;
			end
			aluAH : begin
				AH <= ah_result;
				FLAG <= ah_flag;
				STAR <= fetch0;
			end
			aluAH_AL : begin
				AL <= ah_al_result;
				FLAG <= ah_al_flag;
				STAR <= fetch0;
			end
			aluAL_AH : begin
				AH <= ah_al_result;
				FLAG <= ah_al_flag;
				STAR <= fetch0;
			end
		
			// istruzioni di pila
			pushAL : begin
				ADDR <= SP - 1;
				SP <= SP - 1;
				APP[0] <= AL;
				MJR <= fetch0;
				STAR <= writeB;
			end
			popAL0 : begin 
				ADDR <= SP;
				SP <= SP + 1;
				MJR <= popAL1;
				STAR <= readB;
			end
			popAL1 : begin
				AL <= APP[0];
				STAR <= fetch0;
			end
			
			pushAH : begin
				ADDR <= SP - 1;
				SP <= SP - 1;
				APP[0] <= AH;
				MJR <= fetch0;
				STAR <= writeB;
			end
			popAH0 : begin
				ADDR <= SP;
				SP <= SP + 1;
				MJR <= popAH1;
				STAR <= readB;
			end
			popAH1 : begin
				AH <= APP[0];
				STAR <= fetch0;
			end
			
			pushDP : begin
				ADDR <= SP - 2;
				SP <= SP - 2;
				{APP[1], APP[0]} <= DP;
				MJR <= fetch0;
				STAR <= writeW;
			end
			popDP0 : begin
				ADDR <= SP;
				SP <= SP + 2;
				MJR <= popDP1;
				STAR <= readW;
			end
			popDP1 : begin
				DP <= {APP[1], APP[0]};
				STAR <= fetch0;
			end

			ret0 : begin
				ADDR <= SP;
				SP <= SP + 2;
				MJR <= ret1;
				STAR <= readW;
			end
			ret1 : begin
				IP <= {APP[1], APP[0]};
				STAR <= fetch0;
			end

			// istruzioni di input/output
			in0 : begin 
				ADDR <= IP;
				IP <= IP + 2;
				MJR <= in1;
				STAR <= readW;
			end
			in1 : begin 
				ADDR <= {APP[1], APP[0]};
				STAR <= in2;
			end
			in2 : begin 
				IOR <= 0;
				STAR <= in3;
			end
			in3 : begin 
				AL <= d7_d0;
				IOR <= 1;
				STAR <= fetch0;
			end
			
			out0 : begin 
				ADDR <= IP;
				IP <= IP + 2;
				MJR <= out1;
				STAR <= readW;
			end
			out1 : begin 
				ADDR <= {APP[1], APP[0]};
				D7_D0 <= AL;
				DIR <= 1;
				STAR <= out2;
			end
			out2 : begin 
				IOW <= 0;
				STAR <= out3;
			end
			out3 : begin 
				IOW <= 1;
				STAR <= out4;
			end
			out4 : begin 
				DIR <= 0;
				STAR <= fetch0;
			end

			// istruzioni di salto
			jmp : begin
				IP <= (jmp_condition(OPCODE[4:0], FLAG) == 1) ? DEST_ADDR : IP;
				STAR <= fetch0;
			end

			call0: begin
				ADDR <= SP - 2;
				SP <= SP - 2;
				{APP[1], APP[0]} <= IP;
				MJR <= call1;
				STAR <= writeW;
			end
			call1: begin
				IP <= DEST_ADDR;
				STAR <= fetch0;
			end

		endcase
	end
endmodule

module alu(opcode, source, dest, result, flag);
	input[3:0] opcode;
	input [7:0] source, dest;	
	output[7:0] result, flag;

	wire t_cf;
	wire[7:0] t_result;

	assign {t_cf, t_result} = (opcode == 4'B0010) ? dest + source:	// add
														/* 		don't care	 */ dest - source;	// cmp, sub
	
	assign result = (opcode == 4'B0110) ? {dest[6:0], 1'B0}:	// shl
									(opcode == 4'B0111) ? {1'B0, dest[7:1]}:	// shr
									(opcode == 4'B1000) ? ~dest:							// not
									(opcode == 4'B0001) ? dest:					 			// cmp
									(opcode == 4'B0010) ? t_result:					  // add
									(opcode == 4'B0011) ? t_result:					  // sub
									(opcode == 4'B0100) ? source & dest:			// and
								/*(opcode == 4'B0101)?*/source | dest;			// or
				
	wire is_neg, is_zero, is_ow;
	assign is_neg = t_result[7];
	assign is_zero = (t_result == 0) ? 1'B1 : 1'B0;

	assign is_ow = (opcode == 4'B0010) ? ((source[7] == dest[7]) && (t_result[7] != source[7])) 
																		 ? 1'B1 : 1'B0:	// add
								 /* 	 don't care	  */ ((source[7] != dest[7]) && (t_result[7] != source[7])) 
								 										 ? 1'B1 : 1'B0;	// cmp, sub

	assign flag[7:4] = 4'B0000;
	assign flag[3:0] = (opcode == 4'B0110) ? {1'B0, is_neg, is_zero, dest[7]}:	// shl
										 (opcode == 4'B0111) ? {2'B0, is_zero, dest[0]}:					// shr
										 (opcode == 4'B1000) ? {1'B0, is_neg, is_zero, 1'B0}:			// not
										 (opcode == 4'B0001) ? {is_ow, is_neg, is_zero, t_cf}: 		// cmp
										 (opcode == 4'B0010) ? {is_ow, is_neg, is_zero, t_cf}:  	// add
										 (opcode == 4'B0011) ? {is_ow, is_neg, is_zero, t_cf}: 		// sub
										 (opcode == 4'B0100) ? {1'B0, is_neg, is_zero, 1'B0}:			// and
									 /*(opcode == 4'B0101)?*/{1'B0, is_neg, is_zero, 1'B0};			// or
endmodule
