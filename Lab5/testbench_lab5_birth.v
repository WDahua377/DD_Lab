`timescale 1ns/1ps	// 時間單位1ns，時間精度1ps
`include "lab51.v"

module tb_lab5;
	reg clk;
	reg rst;
	reg clk_2hz;				
	reg [20:0] cnt_2hz;
	reg [2:0] cnt;
	wire [6:0] seg_data;
	wire [3:0] birth_num;

lab5_birth lab5(cnt, birth_num, seg_data);

/*
clk每10ns上沿觸發一次，觸發後cnt_2hz加1，直到cn2_2hz加到12499時，
clk_2hz反轉，也就是每125000ns（12500*10）clk_2hz反轉一次，
cnt根據clk_2hz的上沿加1，也就是每250000ns（125000*2）加1，
*/

always #5 clk = ~clk;	// 每5ns反轉clk，是10ns為一週期的時鐘訊號

always@ (posedge clk or negedge rst) begin
	if (~rst) begin	// 根據rst重置cnt_2hz和clk_2hz
		cnt_2hz <= 21'b0;
		clk_2hz <= 1'b0;
	end
	else begin	// 數到12499時重置cnt_2hz與反轉clk_2hz
		if (cnt_2hz >= 12499) begin
			cnt_2hz <= 21'b0;
			clk_2hz <= ~clk_2hz;
		end
		else begin
			cnt_2hz <= cnt_2hz + 1;
			clk_2hz <= clk_2hz;
		end
	end
end

always@ (posedge clk_2hz or negedge rst) begin	// 每次clk_2hz的上升沿，cnt+1
	if (~rst)
		cnt <= 3'b0;
	else 
		cnt <= cnt + 3'b1;
end

	always @ (posedge clk)
	begin
		// 250000ns後展示資訊
		#250000	$display ($time, "  cnt = %d, ,birth = %d, output = %b", cnt, birth_num, seg_data);
	end	

	initial begin	// 僅執行一次
		$dumpfile("lab5.fsdb");  // 產生波形檔lab5.fsdb
		$dumpvars; // 產生波形檔
		clk = 0;
		rst = 0;
		@(posedge clk) rst = 1;	// clk上沿後，rst保持1

		#5000000 $finish; // 模擬於5000000ns結束
	end
endmodule