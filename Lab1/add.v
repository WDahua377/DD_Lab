module add(a, b, c, d, res);

	input [3:0] a, b, c, d;	
	output [5:0] res;
	wire [5:0] sum1,sum2;

	assign sum1 = a + b;	//當sum加到溢位時會放在res內
	assign sum2 = c + d;
	assign res = sum1 + sum2;

endmodule

