## 程式目的
模擬一個 16-bit Ripple Carry Adder(RCA)，RCA 中的 full adder 由`andgate`、`xorgate`和`orgate`組成，logic gate 實作上皆加上了延遲以便模擬 RCA 的 best case 與 worst case 在硬體上的執行時間，以觀察 RCA 的總延遲隨位數增加而變大。

### RCA
`a`,`b`為兩個輸入訊號，將與當前的進位輸入訊號`cin`相加並將結果輸入到進位輸出`cout`與加法的和輸出`sum`，由多個 full adder 組成，每個 full adder 輸入 a, b 當前的 bit `a[i]`, `b[i]`與前一位的進位輸出`c[i-1]`，輸出和輸出`sum[i]`與當前的進位`c[i]`，並由 XOR gate、OR gate 以及 AND gate 計算，程式為每個 logic gate 添加了不同的計算延遲，以便模擬 full adder 在硬體上的執行步驟及延遲。

### Testbench
在`idx`的迴圈中，每次測試開始前，都會將重置信號`rst`設置為 1，此時程式將重置`in_a`、`in_b`與`cin`即將其設為 0，確保測試在相同條件下開始執行，20ns 後`rst`恢復成 0，此時將根據`idx`的為 1 或 2 測試 RCA 的 best case 與 worst case，每次測試將持續 500ns，之後`rst`又會重新設置為 1 並重置訊號。