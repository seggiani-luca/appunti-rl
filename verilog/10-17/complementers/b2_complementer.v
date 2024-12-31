// un complementatore a una cifra in base 2 con ingresso @x e uscita
// @z
module b2_complementer(x, z);
	input x;
	output z;

	assign z = ~x;
endmodule
