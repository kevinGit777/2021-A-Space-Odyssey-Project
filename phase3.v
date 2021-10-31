//=============================================
// DFF
//=============================================
module DFF(clk,in,out);
    parameter n=1;//width
    input clk;
    input [n-1:0] in;
    output [n-1:0] out;
    reg [n-1:0] out;

    always @(posedge clk)
        out = in;
endmodule

module AND(A, B, output1);
    input [15:0] A;
    input [15:0] B;
    output reg [31:0] output1;

    always @(*) begin
        output1 = A & B;
    end
endmodule

module NAND(A, B, output1);
    input [15:0] A;
    input [15:0] B;
    output reg [31:0] output1;

    always @(*) begin
        output1 = A ~& B;
    end
endmodule

module NOR(A, B, output1);
    input [15:0] A;
    input [15:0] B;
    output reg [31:0] output1;

    always @(*) begin
        output1 = A ~| B;
    end
endmodule

module OR(A, B, output1);
    input [15:0] A;
    input [15:0] B;
    output reg [31:0] output1;

    always @(*) begin
        output1 = A | B;
    end
endmodule

module XNOR(A, B, output1);
    input [15:0] A;
    input [15:0] B;
    output reg [31:0] output1;

    always @(*) begin
        output1 = A ~^ B;
    end
endmodule

module XOR(A, B, output1);
    input [15:0] A;
    input [15:0] B;
    output reg [31:0] output1;

    always @(*) begin
        output1 = A ^ B;
    end
endmodule

module NOT(A, output1);
    input [15:0] A;
    output reg [31:0] output1;

    always @(*) begin
        output1 = ~A;
    end
endmodule

module HalfAdder(A,B,carry,sum);
	input A;
	input B;
	output carry;
	output sum;
	reg carry;
	reg sum;

	always @(*) begin
		sum = A ^ B;
		carry = A & B;
	end
endmodule


module FullAdder(A,B,C,carry,sum);
	input A;
	input B;
	input C;
	output carry;
	output sum;
	reg carry;
	reg sum;

	wire c0;
	wire s0;
	wire c1;
	wire s1;

	HalfAdder ha1(A,B,c0,s0);
	HalfAdder ha2(s0,C,c1,s1);

	always @(*) begin
		sum = s1;
		sum = A ^ B ^ C ;
		carry = c1 | c0 ;
		carry = ((A ^ B) & C) | (A & B);
	end
endmodule


module addsub (inputA, inputB, mode, carry, sum, overflow);
    input [15:0] inputA;
    input [15:0] inputB;
    input [3:0] mode;
    output [31:0] sum;
    output carry;
    output overflow;
    wire b0,b1,b2,b3,b4,b5,b6,b7,b8,b9,b10,b11,b12,b13,b14,b15;
    wire c0,c1,c2,c3,c4,c5,c6,c7,c8,c9,c10,c11,c12,c13,c14,c15,c16,
    c17,c18,c19,c20,c21,c23,c24,c25,c26,c27,c28,c29,c30,c31,c32 ;
    assign m = mode[0];

    assign b0 = inputB[0] ^ m;
    assign b1 = inputB[1] ^ m;
    assign b2 = inputB[2] ^ m;
    assign b3 = inputB[3] ^ m;
    assign b4 = inputB[4] ^ m;
    assign b5 = inputB[5] ^ m;
    assign b6 = inputB[6] ^ m;
    assign b7 = inputB[7] ^ m;
    assign b8 = inputB[8] ^ m;
    assign b9 = inputB[9] ^ m;
    assign b10 = inputB[10] ^ m;
    assign b11 = inputB[11] ^ m;
    assign b12 = inputB[12] ^ m;
    assign b13 = inputB[13] ^ m;
    assign b14 = inputB[14] ^ m;
    assign b15 = inputB[15] ^ m;

    FullAdder FA0(inputA[0],b0,m,c1,sum[0]);
    FullAdder FA1(inputA[1],b1,  c1,c2,sum[1]);
    FullAdder FA2(inputA[2],b2,  c2,c3,sum[2]);
    FullAdder FA3(inputA[3],b3,  c3,c4,sum[3]);
    FullAdder FA4(inputA[4],b4, c4,c5,sum[4]);
    FullAdder FA5(inputA[5],b5,  c5,c6,sum[5]);
    FullAdder FA6(inputA[6],b6,  c6,c7,sum[6]);
    FullAdder FA7(inputA[7],b7,  c7,c8,sum[7]);
    FullAdder FA8(inputA[8],b8, c8,c9,sum[8]);
    FullAdder FA9(inputA[9],b9,  c9,c10,sum[9]);
    FullAdder FA10(inputA[10],b10,  c10,c11,sum[10]);
    FullAdder FA11(inputA[11],b11,  c11,c12,sum[11]);
    FullAdder FA12(inputA[12],b12, c12,c13,sum[12]);
    FullAdder FA13(inputA[13],b13,  c13,c14,sum[13]);
    FullAdder FA14(inputA[14],b14,  c14,c15,sum[14]);
    FullAdder FA15(inputA[15],b15,  c15,c16,sum[15]);
    FullAdder FA16(1'b0 , m,  c16, c17, sum[16]);
    FullAdder FA17(1'b0 , m,  c17, c18, sum[17]);
    FullAdder FA18(1'b0 , m,  c18, c19, sum[18]);
    FullAdder FA19(1'b0 , m,  c19, c20, sum[19]);
    FullAdder FA20(1'b0 , m,  c20, c21, sum[20]);
    FullAdder FA21(1'b0 , m,  c21, c22, sum[21]);
    FullAdder FA22(1'b0 , m,  c22, c23, sum[22]);
    FullAdder FA23(1'b0 , m,  c23, c24, sum[23]);
    FullAdder FA24(1'b0 , m,  c24, c25, sum[24]);
    FullAdder FA25(1'b0 , m,  c25, c26, sum[25]);
    FullAdder FA26(1'b0 , m,  c26, c27, sum[26]);
    FullAdder FA27(1'b0 , m,  c27, c28, sum[27]);
    FullAdder FA28(1'b0 , m,  c28, c29, sum[28]);
    FullAdder FA29(1'b0 , m,  c29, c30, sum[29]);
    FullAdder FA30(1'b0 , m,  c30, c31, sum[30]);
    FullAdder FA31( 1'b0 , m,  c31, c32, sum[31]);

    /*
    assign sum[16] = c16 ^ m;
    assign sum[17] = c16 ^ m;
    assign sum[18] = c16 ^ m;
    assign sum[19] = c16 ^ m;
    assign sum[20] = c16 ^ m;
    assign sum[21] = c16 ^ m;
    assign sum[22] = c16 ^ m;
    assign sum[23] = c16 ^ m;
    assign sum[24] = c16 ^ m;
    assign sum[25] = c16 ^ m;
    assign sum[26] = c16 ^ m;
    assign sum[27] = c16 ^ m;
    assign sum[28] = c16 ^ m;
    assign sum[29] = c16 ^ m;
    assign sum[30] = c16 ^ m;
    assign sum[31] = c16 ^ m;
    assign carry=c15;

   */ 
    assign overflow= c32 ^m;
endmodule

//Modulus module
module modulo(dividend, divisor, remainder, err);
    input [15:0] dividend;
    input [15:0] divisor;
    output reg [31:0] remainder;
    output reg err;

    reg [15:0] t1; 
    reg [15:0] t2; 

    always @(*) begin
        remainder = dividend % divisor; //This is acceptable since the code was supposed to be like this anyway
        // remainder = 0;
	    // err = 0;
        // t1 = dividend;
        // t2 = remainder;
        // if(divisor == 0) begin
        //     err = 1;
        // end
        // else if(divisor < 0) begin
        //     remainder = dividend;
        // end else begin
        //     while (divisor <= t2) begin
        //         t2 = t1 - divisor;
        //         t1 = t2;
        //     end
        //     remainder = t2;
        // end
    end
endmodule

// Module for multiplication
module multiplication (multiplier, multiplicand, product);
    input [15:0] multiplier;
    input [15:0] multiplicand;
    output reg [31:0] product;
    reg [4:0] i;
    reg [31:0] sofar;
    reg [31:0] half;

    always @(*) begin
        product = 0;
        sofar = 0;

        for (i = 15; i > 0; i--) begin
            sofar = sofar << 1;
            if (multiplicand[i] == 1)
            begin
                sofar = sofar + multiplier;
            end
        end
        sofar = sofar << 1;
        product = sofar;
        if (multiplicand[0] == 1)
        begin
            product += multiplier;
        end
    end
endmodule

module divide #(
    parameter
    WIDTH=16
) (
    dividend, divisor, quotient, error
);

    input [WIDTH-1:0] divisor;
    input [WIDTH-1:0] dividend;
    output reg [31:0] quotient;
    output reg error;
    reg [WIDTH-1:0] reverse;
    wire [31:0] rv_quotient;
    wire [31:0] unrv_quotient;
    wire OF_flag_1;
    wire OF_flag_2;

    unsign_divide udv(dividend, divisor, unrv_quotient, OF_flag_1);
    unsign_divide redv(reverse, divisor, rv_quotient, OF_flag_2);

    always @(*) begin
        error = OF_flag_1 | OF_flag_2;
        reverse = -divisor;
        if (dividend[WIDTH-1] !== divisor[WIDTH-1])
        begin
            quotient = -rv_quotient;
        end else begin
            quotient = unrv_quotient;
        end


    end

endmodule

module unsign_divide #(parameter WIDTH=16) ( dividend, divisor, quotient, error);
    input [WIDTH-1:0] divisor;
    input [WIDTH-1:0] dividend;
    output reg[31:0] quotient;
    output reg error;
    reg sign;
    reg [WIDTH-1:0] copy;
    reg [WIDTH-1:0] temp;

    always @(*) begin


    sign = dividend[WIDTH-1];
    quotient = 0;
    copy = dividend;
    error = 0;
            if (divisor == 0) begin
                error = 1; 
            end else
            begin
                while ( !sign ^ copy[WIDTH-1]) begin
                    temp = copy - divisor;
                    copy = temp;
                    temp = quotient + 1;
                    quotient = temp;
                end
                temp = quotient - 1;
                quotient = temp;
            end
        end

endmodule

module Dec4x16(binary,onehot);
	input [3:0] binary;
	output [15:0] onehot;
	
	assign onehot[ 0]=~binary[3]&~binary[2]&~binary[1]&~binary[0];
	assign onehot[ 1]=~binary[3]&~binary[2]&~binary[1]& binary[0];
	assign onehot[ 2]=~binary[3]&~binary[2]& binary[1]&~binary[0];
	assign onehot[ 3]=~binary[3]&~binary[2]& binary[1]& binary[0];
	assign onehot[ 4]=~binary[3]& binary[2]&~binary[1]&~binary[0];
	assign onehot[ 5]=~binary[3]& binary[2]&~binary[1]& binary[0];
	assign onehot[ 6]=~binary[3]& binary[2]& binary[1]&~binary[0];
	assign onehot[ 7]=~binary[3]& binary[2]& binary[1]& binary[0];
	assign onehot[ 8]= binary[3]&~binary[2]&~binary[1]&~binary[0];
	assign onehot[ 9]= binary[3]&~binary[2]&~binary[1]& binary[0];
	assign onehot[10]= binary[3]&~binary[2]& binary[1]&~binary[0];
	assign onehot[11]= binary[3]&~binary[2]& binary[1]& binary[0];
	assign onehot[12]= binary[3]& binary[2]&~binary[1]&~binary[0];
	assign onehot[13]= binary[3]& binary[2]&~binary[1]& binary[0];
	assign onehot[14]= binary[3]& binary[2]& binary[1]&~binary[0];
	assign onehot[15]= binary[3]& binary[2]& binary[1]& binary[0];
	
endmodule

module Mux16to1(channels, select, b);
input [15:0][31:0] channels;
input      [15:0] select;
output      [31:0] b;


	assign b = ({32{select[15]}} & channels[15]) | 
               ({32{select[14]}} & channels[14]) |
			   ({32{select[13]}} & channels[13]) |
			   ({32{select[12]}} & channels[12]) |
			   ({32{select[11]}} & channels[11]) |
			   ({32{select[10]}} & channels[10]) |
			   ({32{select[ 9]}} & channels[ 9]) |
			   ({32{select[ 8]}} & channels[ 8]) |
			   ({32{select[ 7]}} & channels[ 7]) |
			   ({32{select[ 6]}} & channels[ 6]) |
			   ({32{select[ 5]}} & channels[ 5]) |
			   ({32{select[ 4]}} & channels[ 4]) |
			   ({32{select[ 3]}} & channels[ 3]) |
			   ({32{select[ 2]}} & channels[ 2]) | 
               ({32{select[ 1]}} & channels[ 1]) |
               ({32{select[ 0]}} & channels[ 0]) ;

endmodule

module BreadBoard (
    clk,
    input1,
    op_code,
    output1,
    err_code,
);
    input clk;
    input [15:0] input1;
    input [3:0] op_code;
    reg [15:0] input2;

    wire [31:0] sum;
    wire [31:0] product;
    wire [31:0] quotient;
    wire [31:0] remainder;
    wire [31:0] andout;
    wire [31:0] orout;
    wire [31:0] nandout;
    wire [31:0] norout;
    wire [31:0] xorout;
    wire [31:0] xnorout;
    wire [31:0] notout;
    wire carry;
    wire err_0;
    wire err_1_1;
    wire err_1_2;
    wire [15:0][31:0] channels;
    wire [15:0] onehotMux;
    wire [31:0] muxout;
    wire [31:0] outval;
    wire [15:0] feedback;

    DFF #(32) Accumulator(clk,muxout,outval);

    output [31:0] output1;
    output [1:0] err_code;
    reg [31:0] output1;

    addsub as(.inputA(feedback), .inputB(input1), .mode(op_code), .carry(carry), .sum(sum), .overflow(err_0));
    multiplication mul(input1, feedback, product);
    divide dv(feedback, input1, quotient, err_1_1);
    modulo mod(feedback, input1, remainder, err_1_2);
    AND andop(input1, feedback, andout);
    OR orop(input1, feedback, orout);
    NAND nandop(feedback, input1, nandout);
    NOR norop(input1, feedback, norout);
    XOR xorop(input1, feedback, xorout);
    XNOR xnorop(input1, feedback, xnorout);
    NOT notop(feedback, notout);
    Dec4x16 decode(op_code ,onehotMux);
    Mux16to1 mux(channels, onehotMux, muxout);

    assign err_code[0] = err_0 & ((op_code ^ 0000 ) | (op_code ^ 0001));
    assign err_code[1] = err_1_1 | err_1_2;
    assign channels[ 0] = sum;
    assign channels[ 1] = sum;
    assign channels[ 2] = product;
    assign channels[ 3] = quotient;
    assign channels[ 4] = remainder; 
    assign channels[ 5] = andout;
    assign channels[ 6] = orout;
    assign channels[ 7] = nandout;
    assign channels[ 8] = norout;
    assign channels[ 9] = xorout;
    assign channels[ 10] = xnorout;
    assign channels[ 11] = notout;
    assign channels[ 12] = 32'b11111111111111111111111111111111;
    assign channels[ 13] = 32'b00000000000000000000000000000000;
    assign channels[ 14] = feedback;


    assign feedback = outval[15:0];

    always@(*)
    begin
        output1 = muxout;
    end
endmodule

module Testbench (
);
    reg [15:0] input1;
    reg [15:0] input2;
    wire signed [31:0] output1;
    wire [1:0] err_code;
    reg [3:0] op_code;
    reg clk;

    BreadBoard BB(
    .clk(clk),
    .input1(input1), 
    .op_code(op_code),
    .output1(output1), 
    .err_code(err_code));
	
    initial begin
        forever begin
            clk = 0;
            #5;
            clk = 1;
            #5;
        end
    end


    initial begin   	
    //$display acts like a classic C printf command.
    //$display ("Begin test #1");
    //Initial
    //$display ("[Input:%6d, Feedback: %6d] [OpCode:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    //Reset
    input1 = 0;
    op_code = 4'b1101;
    #10;
    $display ("[Input:%6d, Feedback: %6d] [Reset:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    //No Op
    input1 = 0;
    op_code = 4'b1110;
    #10;
    $display ("[Input:%6d, Feedback: %6d] [NoOp:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    //Add
    input1 = 7;
    op_code = 4'b0000;
    #5; //FOR SOME REASON THIS HAS TO BE 5 OR ELSE THE PROGRAM DOESNT WORK PROPERLY
    $display ("[Input A:%6d, Feedback: %6d] [Add:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);
    
    //Sub
    input1 = 3;
    op_code = 4'b0001;
    #10;
    $display ("[Input A:%6d, Feedback: %6d] [Sub:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);
    
    //Mul
    input1 = 250;
    op_code = 4'b0010;
    #10;
    $display ("[Input A:%6d, Feedback: %6d] [Mul:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);
    
    //Div
    input1 = 32;
    op_code = 4'b0011;
    #10;
    $display ("[Input A:%6d, Feedback: %6d] [Div:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    //Mod
    input1 = 4;
    op_code = 4'b0100;
    #10;
    $display ("[Input A:%6d, Feedback: %6d] [Mod:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    //AND
    input1 = 32;
    op_code = 4'b0101;
    #10;
    $display ("[Input A:%6d, Feedback: %6d] [AND:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    //OR
    input1 = 42;
    op_code = 4'b0110;
    #10;
    $display ("[Input A:%6d, Feedback: %6d] [OR:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    //NOT
    input1 = 0;
    op_code = 4'b1011;
    #10;
    $display ("[Input A:%6d, Feedback: %6d] [NOT:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    //XOR
    input1 = 65535;
    op_code = 4'b1001;
    #10;
    $display ("[Input A:%6d, Feedback: %6d] [XOR:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    //XNOR
    input1 = 65525;
    op_code = 4'b1010;
    #10;
    $display ("[Input A:%6d, Feedback: %6d] [XNOR:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    //NAND 
    input1 = 65535;
    op_code = 4'b0111;
    #10;
    $display ("[Input A:%6d, Feedback: %6d] [NAND:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    //NOR 
    input1 = 65535;
    op_code = 4'b1000;
    #10;
    $display ("[Input A:%6d, Feedback: %6d] [NAND:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    //Preset 
    input1 = 0;
    op_code = 4'b1100;
    #10;
    $display ("[Input A:%6d, Feedback: %6d] [Preset:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);


    // $display ("Begin test #1");
    // input1 = 65000;
    // //input2 = 65000;
    // op_code = 4'b0000;
    // #50;
    // $display ("[Input A:%6d, Input B: %6d] [Add:%b] [output:%11d, Error:%b] ", input1, op_code, output1, err_code);

    // $display ("Begin test #2");
    // input1 = 32000;
    // //input2 = 16000;
    // op_code = 4'b0001;
    // #50;
    // $display ("[Input A:%6d, Input B: %6d] [Sub:%b] [output:%11d, Error:%b] ", input1, op_code, output1, err_code);
    

    // $display ("Begin test #3");
    // input1 = 32000;
    // //input2 = 16000;
    // op_code = 4'b0010;
    // #50;
    // $display ("[Input A:%6d, Input B: %6d] [Mul:%b] [output:%11d, Error:%b] ", input1, op_code, output1, err_code);
    

    // $display ("Begin test #4");
    // input1 = 32000;
    // //input2 = 16000;;
    // op_code = 4'b0011;
    // #50;
    // $display ("[Input A:%6d, Input B: %6d] [Div:%b] [output:%11d, Error:%b] ", input1, op_code, output1, err_code);
    

    // $display ("Begin test #5");
    // input1 = 32000;
    // //input2 = 16000;
    // op_code = 4'b0100;
    // #50;
    // $display ("[Input A:%6d, Input B: %6d] [Mod:%b] [output:%11d, Error:%b] ", input1, op_code, output1, err_code);
    

    $finish;
    end
endmodule

