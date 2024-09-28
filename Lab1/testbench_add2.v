// this code is privided by course

//include ur design
module testbench_add2;

//Data type declaration
reg [3:0] a, b;
reg clk = 0;
reg rst = 0;
wire [3:0] sum;
wire ov;
wire [4:0] res;
//module instantiation
add2 DUT(a, b, sum, overflow); //呼叫 module name 為 add2 的檔案 (add_2.v)

//初始化
initial begin
	clk <= 0;
	rst <= 0;
	a <= 4'b0000; 
	b <= 4'b0000;

	//印出結果
    $monitor("%4dns a=%d b=%d res=%d ", $stime, a, b, res);
end

// 用來監聽時脈的正緣或重置信號的負緣。當時脈上升或重置信號為低時，這段邏輯會執行
always@(posedge clk or negedge rst)
begin
    if(a <= 15) begin 
		a <= a + 1;
	end 
	if(a == 15) begin
		b <= b + 1;
	end
	if(b == 15 && a == 15) begin
		$finish;
	end
end

// 組合邏輯
// 將溢位信號 overflow 和加法結果 sum 組合成 5 位元的 res，res 的最高位是溢位信號，其餘 4 位是相加的結果
assign res = {overflow, sum};

always #1 clk = ~clk;	// 每隔 1 時間單位，時脈翻轉（從 0 變 1 或從 1 變 0），模擬一個週期性的時脈信號
always #1 rst = ~rst;	// 每隔 1 時間單位，重置信號翻轉，這樣設置可能是為了測試電路在不同重置狀態下的行為

endmodule




