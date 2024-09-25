`timescale 1ns/1ps

// Ripple Carry Adder(RCA)
module RCA_16bit(a,b,cin,sum,cout);

    input [15:0] a,b;
    input cin;
    output [15:0] sum;
    output cout;
    wire [14:0] c;	// carry out from previous bit

	// --- Write down your design here --- //
	fulladder fa1(a[0],b[0],cin,sum[0],c[0]);
	fulladder fa2(a[1],b[1],c[0],sum[1],c[1]);
	fulladder fa3(a[2],b[2],c[1],sum[2],c[2]);
	fulladder fa4(a[3],b[3],c[2],sum[3],c[3]);
	fulladder fa5(a[4],b[4],c[3],sum[4],c[4]);
	fulladder fa6(a[5],b[5],c[4],sum[5],c[5]);
	fulladder fa7(a[6],b[6],c[5],sum[6],c[6]);
	fulladder fa8(a[7],b[7],c[6],sum[7],c[7]);
	fulladder fa9(a[8],b[8],c[7],sum[8],c[8]);
	fulladder fa10(a[9],b[9],c[8],sum[9],c[9]);
	fulladder fa11(a[10],b[10],c[9],sum[10],c[10]);
	fulladder fa12(a[11],b[11],c[10],sum[11],c[11]);
	fulladder fa13(a[12],b[12],c[11],sum[12],c[12]);
	fulladder fa14(a[13],b[13],c[12],sum[13],c[13]);
	fulladder fa15(a[14],b[14],c[13],sum[14],c[14]);
	fulladder fa16(a[15],b[15],c[14],sum[15],cout);
	// ----------------------------------- //
endmodule

// FA module
module fulladder(a,b,cin,sum,cout);
	
	input a, b, cin;
	output sum,cout;
	wire x,y,z;

	// --- Write down your design here --- //
	xorgate xor1(a,b,x);	// x = a XOR b
	xorgate xor2(x,cin,sum);	// sum = (a XOR b) XOR cin
	andgate and1(a,b,z);	// z = a AND b
	andgate and2(a,b,z);	// z = a AND b
	orgate or1(y,z,cout);	// ((a XOR b) AND cin) OR (a AND b)
	// ----------------------------------- //

endmodule

// xor gate
module xorgate(a,b,out);
	
	input a,b;
	output reg out;

	// --- Write down your design here --- //
	always @ (*)  begin
		#14 out <= a ^ b; // #14ns 為 xor gate's gate delay
	end
	// ----------------------------------- //


endmodule



// and gate
module andgate(a,b,out);
	
	input a, b;
	output reg out;

	always @ (*)  begin
		#10 out <= a & b; // #10ns 為 and gate's gate delay
	end

endmodule

// or gate
module orgate(a,b,out);
	
	input a, b;
	output reg out;

	always @ (*)  begin
		#4 out <= a | b; // #4ns 為 or gate's gate delay
	end

endmodule