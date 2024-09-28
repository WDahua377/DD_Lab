## 程式目的
改變變數、計算變數的相加結果並顯示計算結果的正確性與正確答案，不斷重複動作以測試 add module 的正確性

### add2、add4 實作
1. `add2`計算兩數相加，並賦予錯誤的 overflow 計算使計算結果輸出不一定正確（以便從 testbench 觀察結果）
2. `add4`計算四數相加，輸出正確的 overflow`ov`與相加結果`sum`

### Testbench 實作
1. `clk`與`rst`每 5ns 反轉一次，而 always block 每 5ns 被激活一次（`clk`正緣一次，`rst`負緣一次）
2. 當 always block 由`clk`正緣激活時，`rst`處於高電平（1），程式將根據條件對要相加的變數`a`、`b`、`c`、`d`加 1
3. 當 always block 由`rst`正緣激活時，`rst`處於低電平（0），程式將顯示`add4`（`add2`）的正確性與正確答案
4. 程式將持續模擬直到`a`、`b`、`c`、`d`變數皆加到 15