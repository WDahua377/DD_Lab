// this code is provided by course

module testBench();

reg  [3:0] a, b, c, d;
wire [5:0] res;
reg clk = 0;
reg rst = 0;

initial
begin
    // 印出結果
    // 被調用一次，但它會持續監控指定的變數
    // $display是將該時間點雙引號中的參數清單內容列印出來，而$monitor是在參數清單改變的時候，將參數清單內容列印出來
    // 有 $ 符號不會被合成為電路， 只是方便除錯
    $monitor("%4dns monitor: a=%d b=%d c=%d d=%d res=%d", $stime, a, b, c, d, res);
end

add4 add1(a, b, c, d, res);  //你的 module name 應為 add4
/* 長得像是
module name ( ports... );

    input ports...      ;
    output ports...     ;
    
    ...*ur design*...
    
endmodule
*/

//設定初始值
initial
begin
    a=0;
    b=0;
    c=0;
    d=0;
    clk = 0;
    rst = 0;
end

always@(posedge clk or negedge rst)
begin
    if(a <= 15)
    begin
        a <= a + 1;
    end
    if(a == 15)
    begin
        b <= b + 1;
    end
    if(b == 15 && a == 15)
    begin
        c <= c + 1;
    end
    if(c == 15 && b == 15 && a == 15)
    begin
        d <= d + 1;
    end
    if(d == 15 && c == 15 && b == 15 && a == 14)
    begin
        $finish;
    end
end

// always如果沒有@，就是不需要滿足特定條件才執行，而是執行完一次後立刻執行下一次，一直重複執行
// 一般在仿真中的tb檔中產生時鐘
always #1 clk=~clk;
always #1 rst=~rst;
endmodule
