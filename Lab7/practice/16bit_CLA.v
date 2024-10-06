module CLA_16bit(a,b,cin,sum);

    input  [15:0] a,b;
    input cin;
    output [15:0] sum;
    
    wire [15:0] g,p;
    wire [15:1] c;
    wire [3:0] gG,gP;   // 4-bit LCU 產生的 group generate 與 group propagate
    
    // Write down your design here ---//
	
	  // generate g & p
      // 使用a, b產生每一位的 generate and propagate
      gp_generator gp_geneator1(a[3:0], b[3:0], g[3:0], p[3:0]);
      gp_generator gp_geneator2(a[7:4], b[7:4], g[7:4], p[7:4]);
      gp_generator gp_geneator3(a[11:8], b[11:8], g[11:8], p[11:8]);
      gp_generator gp_geneator4(a[15:12], b[15:12], [15:12], p[15:12]);

		
	  // generate gG & gP, generate carries
      // 4-bit Lookahead Carry Unit 生成 group generate 與 group propagate
      carry_generator carry_geneator_c0(g[3:0], p[3:0], cin, c[3:1], gG[0], gP[0]);
      carry_generator carry_geneator_c1(g[7:4], p[7:4], c[4], c[7:5], gG[1], gP[1]);
      carry_generator carry_geneator_c2(g[11:8], p[11:8], c[8], c[11:9], gG[2], gP[2]);
      carry_generator carry_geneator_c3(g[15:12], p[15:12], c[12], c[15:13], gG[3], gP[3]);


      // 用 gG 與 gP 產生 c4, c8 和 c12
      carry_generator carry_geneator_c4(gG[3:0], gP[3:0], cin, {c[12],c[8],c[4]}, , );


	  // generate sum = a ^ b ^ c
      sum_generator geneate_sum(a[15:0], b[15:0], cin, c[15:1], sum[15:0]);   

    //-------------------------------//

endmodule

module gp_generator(a, b, g, p);

    input  [3:0] a, b;
    output [3:0] g, p;
   
    assign g = a & b;   // g = a x b
    assign p = a ^ b;   // p = a + b

endmodule

module carry_generator(g, p, cin, c, gG, gP);

    input [3:0] g, p;
    input cin;
    output gG, gP;
    output [3:1] c;

    // create gG and gP
    assign gG = g[3] | (p[3] & g[2]) | (p[3] & p[2] & g[1]) | (p[3] & p[2] & p[1] & g[0]);
	assign gP = p[3] & p[2] & p[1] & p[0];

    // create carries
    assign c[1] = g[0] | (p[0] & cin);
    assign c[2] = g[1] | (p[1] & g[0]) | (p[1] & p[0] & cin);
    assign c[3] = g[2] | (p[2] & g[1]) | (p[2] & p[1] & g[0]) | (p[2] & p[1] & p[0] & cin);

endmodule

module sum_generator(a, b, cin, c, sum);

    input  [15:0] a, b;
    input cin;
    input  [15:1] c;
    output [15:0] sum;

    // sum = a ^ b ^ c;
    assign sum = a ^ b ^ {c, cin};  // cin是最右邊的進位

endmodule