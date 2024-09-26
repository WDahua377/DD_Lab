module top(clk, sw, CA, CB, CC, CD, CE, CF,CG, AN0, AN1, AN2,
AN3, AN4, AN5, AN6, AN7);
    
input clk;
input [11:0]sw;
output CA, CB, CC, CD, CE, CF, CG;	// 7段顯示器的各段
output AN0, AN1, AN2, AN3, AN4, AN5, AN6, AN7;		// 8位數8個數位的啟動信號

wire [5:0]num1;
wire [5:0]num2;
reg [2:0] state;
reg [6:0] seg_number, seg_data, seg_number_mirror;
reg [20:0] counter;
reg [7:0] scan;		// 8位的暫存器，每位對應一個顯示器數位

assign num1 = sw[11:6];
assign num2 = sw[5:0];

wire [6:0]sum;
add6 add(num1, num2, sum);


assign {AN7 ,AN6, AN5, AN4, AN3, AN2, AN1, AN0} = scan;	// 將scan直接連接到顯示器的激活引腳（AN0到AN7）

always@(posedge clk) begin
	seg_number <= 10;
	seg_number_mirror <= 10;
	counter <=(counter<=100000) ? (counter +1) : 0;		// counter到100000後會重置
	state <= (counter==100000) ? (state + 1) : state;	// state在每次counter到100000後會+1
	case(state)
		// state 0~3是sum的鏡像顯示
		0:begin
			seg_number_mirror <= sum % 10;
			scan <= 8'b0111_1111;	// 激活第一個數位（顯示器的第一個數字）AN7（active low）
		end
		1:begin
			seg_number_mirror <= (sum / 10 ) % 10;
			scan <= 8'b1011_1111;
		end
		2:begin
			seg_number_mirror <= (sum / 100 ) % 10;
			scan <= 8'b1101_1111;
		end
		3:begin
			seg_number_mirror <= sum / 1000;
			scan <= 8'b1110_1111;
		end

		// state 4~6是sum的顯示
		4:begin
			seg_number <= sum/1000;
			scan <= 8'b1111_0111;
		end
		5:begin
			seg_number <= (sum/100) % 10;
			scan <= 8'b1111_1011;
		end
		6:begin
			seg_number <= (sum/10) % 10;
			scan <= 8'b1111_1101;
		end
		7:begin
			seg_number <= sum % 10;
			scan <= 8'b1111_1110;
		end
		default: state <= state;
	endcase 
end  


assign {CG,CF,CE,CD,CC,CB,CA} = seg_data;

always@(posedge clk) begin  
	case(seg_number)	// 每個case只有一個語句時不用寫begin和end
		// 4'd0: seg_data <= 7'b100_0000;
		// 0: seg_data <= 7'b100_0000;	// 比較簡單的表示方法
		16'd0:seg_data <= 7'b100_0000;	// 除了G段之外所有段都亮起（active low）
		16'd1:seg_data <= 7'b111_1001;
		16'd2:seg_data <= 7'b010_0100;
		16'd3:seg_data <= 7'b011_0000;
		16'd4:seg_data <= 7'b001_1001;
		16'd5:seg_data <= 7'b001_0010;
		16'd6:seg_data <= 7'b000_0010;
		16'd7:seg_data <= 7'b101_1000;
		16'd8:seg_data <= 7'b000_0000;
		16'd9:seg_data <= 7'b001_0000;
		default: seg_number <= seg_number;
	endcase

	case(seg_number_mirror)
		16'd0:seg_data <= 7'b100_0000;
		16'd1:seg_data <= 7'b100_1111;
		16'd2:seg_data <= 7'b001_0010;
		16'd3:seg_data <= 7'b000_0110;
		16'd4:seg_data <= 7'b000_1101;
		16'd5:seg_data <= 7'b010_0100;
		16'd6:seg_data <= 7'b010_0000;
		16'd7:seg_data <= 7'b100_1100;
		16'd8:seg_data <= 7'b000_0000;
		16'd9:seg_data <= 7'b000_0100;
	default: seg_number_mirror <= seg_number_mirror;
	endcase
  
end 

endmodule