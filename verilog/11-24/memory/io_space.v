module io_space #(
	parameter IO_SIZE = 16
) 
(
	addr,
	d7_d0,
	ior_, iow_
);
	
	input[IO_SIZE - 1:0] addr;
	inout[7:0] d7_d0;
	input ior_, iow_;

	// interfacce
endmodule
