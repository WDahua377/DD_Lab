// this code is from course

`timescale 1ns / 1ps
module testbench_add4;

reg [3:0] a, b, c, d;
wire [4:0] sum;
wire ov;
reg clk;
reg	rst;
reg [4:0] correct_sum;
reg [16:0] test_num;
reg correct_ov;


always #5 clk = ~clk;

always #5 rst = ~rst;

add4 DUT(a, b, c, d, sum, ov);

initial
begin
	clk <= 0;
	rst <= 0;
	a <= 0; 
	b <= 0;
	c <= 0;
	d <= 0;
	test_num <= 0;
	$dumpfile("add4.vcd");	// 指定檔案的名稱，波形數據將被寫入名為 add2.vcd 的文件中
	$dumpvars;	// 告訴模擬器記錄所有的變數（默認為所有變數），將值在模擬期間寫入到指定的 VCD 文件
end

always@(posedge clk or negedge rst)
begin
	if(rst)begin
		if(a <= 15) begin 
			a <= a + 1;
			test_num <= test_num + 1;
		end 
		if(a == 15) begin
			b <= b + 1;
		end
		if(a == 15 && b == 15) begin
			c <= c + 1;
		end
		if(a == 15 && b == 15 && c == 15) begin
			d <= d + 1;
		end
		if(a == 15 && b == 15 && c == 15 && d == 15) begin
			$finish;
		end
	end

	else begin
		{correct_ov, correct_sum} = a + b + c + d;
		if({ov, sum} == {correct_ov, correct_sum}) begin
			$display ("Test %d ", test_num);
			$display ("CORRECT!");
			$display ("%d + %d + %d + %d = ?", a, b, c, d);
			$display ("your answer: ov = %d, sum = %d", ov, sum);
			$display ("correct answer: ov = %d, sum = %d", ov, sum);
			$display ("\n");
		end
		else begin
			$display ("Test %d ", test_num);
			$display ("///////////////////////");
			$display ("//////// Fail! ////////");
			$display ("// Uncorrect Answer! //");
			$display ("///////////////////////");
			$display ("%d + %d + %d + %d = ?", a, b, c, d);
			$display ("your answer: ov = %d, sum = %d", ov, sum);
			$display ("correct answer: ov = %d, sum = %d", correct_ov, correct_sum);
			$display ("\n");
		end
	end
end

// 模擬運行到655355 ns後結束
// initial #655355 $finish;
endmodule



