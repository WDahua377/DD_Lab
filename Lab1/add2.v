// this code is proviede by course

module add2(a, b, sum, overflow);

	input [3:0] a, b;	
	output [3:0] sum;	
	output overflow;	//溢位
	assign {overflow,sum} = a + b;	//當sum加到溢位時會放在overflow內

endmodule

