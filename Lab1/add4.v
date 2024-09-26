module add4(a, b, c, d, res);

	input [3:0] a, b, c, d;	
	output [5:0] res;
	wire [5:0] sum1,sum2;

	// assign連續賦值，當右邊表達式中的任何變量發生改變時，左邊的wire會立即更新
	assign sum1 = a + b;
	assign sum2 = c + d;
	assign res = sum1 + sum2;	// 當sum加到溢位時會放在res內

endmodule

