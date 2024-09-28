module add4(a, b, c, d, res);

	// input, output默認為wire
	input [3:0] a, b, c, d;	
	output [5:0] res;
	wire [5:0] sum1,sum2;

	// assign連續賦值，當右邊表達式中的任何變量發生改變時，左邊的wire會立即更新
	assign sum1 = a + b;	// 最大可能：15+15=30
	assign sum2 = c + d;	// 最大可能：30+30=60
	assign res = sum1 + sum2;	// 最大可能結果(60)在六位元表示範圍(63)以內，無需考慮overflow的問題

endmodule

