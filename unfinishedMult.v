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
        remainder = 0;
	    err = 0;
        t1 = dividend;
        t2 = remainder;
        if(divisor == 0) begin
            err = 1;
        end
        else if(divisor < 0) begin
            remainder = dividend;
        end else begin
            while (divisor <= t2) begin
                t2 = t1 - divisor;
                t1 = t2;
            end
            remainder = t2;
        end
    end
endmodule

// Module for multiplication

module multiplication (multiplier, multiplicand, product);
    input [15:0] multiplier;
    input [15:0] multiplicand;
    output [31:0] product;

    wire [15: 0] b0;
    wire [15: 0] b1;
    wire [15: 0] b2;
    wire [15: 0] b3;
    wire [15: 0] b4;
    wire [15: 0] b5;
    wire [15: 0] b6;
    wire [15: 0] b7;
    wire [15: 0] b8;
    wire [15: 0] b9;
    wire [15: 0] b10;
    wire [15: 0] b11;
    wire [15: 0] b12;
    wire [15: 0] b13;
    wire [15: 0] b14;
    wire [15: 0] b15;
    wire [15: 0] b16;
    wire o0,o1,o2,o3,o4,o5,o6,o7,o8,o9,o10,o11,o12,o13,o14,o15,o16,o17,o18,o19,o20,o21,o22,o23,o24,o25,o26,o27,o28,o29,o30;
    wire [31:0][31:0] sums; 
    
    assign b0 = multiplier & {16{multiplicand[0]}};
    assign b1 = multiplier & {16{multiplicand[1]}};
    assign b2 = multiplier & {16{multiplicand[2]}};
    assign b3 = multiplier & {16{multiplicand[3]}};
    assign b4 = multiplier & {16{multiplicand[4]}};
    assign b5 = multiplier & {16{multiplicand[5]}};
    assign b6 = (multiplier & {16{multiplicand[6]}});
    assign b7 = (multiplier & {16{multiplicand[7]}});
    assign b8 = (multiplier & {16{multiplicand[8]}});
    assign b9 = (multiplier & {16{multiplicand[9]}});
    assign b10 = (multiplier & {16{multiplicand[10]}});
    assign b11 = (multiplier & {16{multiplicand[11]}});
    assign b12 = (multiplier & {16{multiplicand[12]}});
    assign b13 = (multiplier & {16{multiplicand[13]}});
    assign b14 = (multiplier & {16{multiplicand[14]}});
    assign b15 = (multiplier & {16{multiplicand[15]}});

    
    assign product[0] = b0[0];
    assign product = {sums[30][0],sums[29][0],sums[28][0],sums[27][0], 
        sums[26][0], sums[25][0], sums[24][0], sums[23][0], sums[22][0], sums[21][0],sums[20][0],sums[19][0],sums[18][0], 
        sums[17][0], sums[16][0], sums[15][0], sums[14][0], sums[13][0], sums[12][0],sums[11][0],sums[10][0],sums[9][0], 
        sums[8][0], sums[7][0], sums[6][0],sums[5][0], 
        sums[4][0], sums[3][0], sums[2][0], sums[1][0], sums[0][0], b0[0]} ;
    addsub as0({1'b0,b0[15:1]}, b1, 4'b0, carry, sums[0], o0);
    addsub as1(sums[0][16:1], b2, 4'b0, carry, sums[1], o1);
    addsub as2(sums[1][16:1], b3, 4'b0, carry, sums[2], o2);
    addsub as3(sums[2][16:1], b4, 4'b0, carry, sums[3], o3);
    addsub as4(sums[3][16:1], b5, 4'b0, carry, sums[4], o4);
    addsub as5(sums[4][16:1], b6, 4'b0, carry, sums[5], o5);
    addsub as6(sums[5][16:1], b7, 4'b0, carry, sums[6], o6);
    addsub as7(sums[6][16:1], b8, 4'b0, carry, sums[7], o7);
    addsub as8(sums[7][16:1], b9, 4'b0, carry, sums[8], o8);
    addsub as9(sums[8][16:1], b10, 4'b0, carry, sums[9], o9);
    addsub as10(sums[9][16:1], b11, 4'b0, carry, sums[10], o10);
    addsub as11(sums[10][16:1], b12, 4'b0, carry, sums[11], o11);
    addsub as12(sums[11][16:1], b13, 4'b0, carry, sums[12], o12);
    addsub as13(sums[12][16:1], b14, 4'b0, carry, sums[13], o13);
    addsub as14(sums[13][16:1], b15, 4'b0, carry, sums[14], o14);
    addsub as15(sums[14][16:1], b16, 4'b0, carry, sums[15], o15);
    addsub as16(sums[15][16:1], 16'b0, 4'b0, carry, sums[16], o16);
    addsub as17(sums[16][16:1], 16'b0, 4'b0, carry, sums[17], o17);
    addsub as18(sums[17][16:1], 16'b0, 4'b0, carry, sums[18], o18);
    addsub as19(sums[18][16:1], 16'b0, 4'b0, carry, sums[19], o19);
    addsub as20(sums[19][16:1], 16'b0, 4'b0, carry, sums[20], o20);
    addsub as21(sums[20][16:1], 16'b0, 4'b0, carry, sums[21], o21);
    addsub as22(sums[21][16:1], 16'b0, 4'b0, carry, sums[22], o22);
    addsub as23(sums[22][16:1], 16'b0, 4'b0, carry, sums[23], o23);
    addsub as24(sums[23][16:1], 16'b0, 4'b0, carry, sums[24], o24);
    addsub as25(sums[24][16:1], 16'b0, 4'b0, carry, sums[25], o25);
    addsub as26(sums[25][16:1], 16'b0, 4'b0, carry, sums[26], o26);
    addsub as27(sums[26][16:1], 16'b0, 4'b0, carry, sums[27], o27);
    addsub as28(sums[27][16:1], 16'b0, 4'b0, carry, sums[28], o28);
    addsub as29(sums[28][16:1], 16'b0, 4'b0, carry, sums[29], o29);
    addsub as30(sums[29][16:1], 16'b0, 4'b0, carry, sums[30], o30);


    



/*
always @(*) begin
    
    $display(product);    
    end
*/
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
    input1,
    input2, 
    op_code,
    output1,
    err_code,
);
    input [15:0] input1;
    input [15:0] input2;
    input [3:0] op_code;


    wire [31:0] sum;
    wire [31:0] product;
    wire [31:0] quotient;
    wire [31:0] remainder;
    wire carry;
    wire err_0;
    wire err_1_1;
    wire err_1_2;
    wire [15:0][31:0] channels;
    wire [15:0] onehotMux;



    output [31:0] output1;
    output [1:0] err_code;

    addsub as(.inputA(input1), .inputB(input2), .mode(op_code), .carry(carry), .sum(sum), .overflow(err_0));
    multiplication mul(input1, input2, product);
    divide dv(input1, input2, quotient, err_1_1);
    modulo mod(input1, input2, remainder, err_1_2);
    Dec4x16 decode(op_code ,onehotMux);
    Mux16to1 mux(channels, onehotMux, output1);

    assign channels[ 0] = sum;
    assign channels[ 1] = sum;
    assign channels[ 2] = product;
    assign channels[ 3] = quotient;
    assign channels[ 4] = remainder; 
    assign err_code[0] = err_0 & ((op_code ^ 0000 ) | (op_code ^ 0001));
    assign err_code[1] = err_1_1 | err_1_2;


/*
    output reg [31:0] output1;
    output reg [1:0] err_code;
always @(*) begin
    case (op_code)
        0: begin //0000 add
            output1 = sum;
        err_code[0] = 0;
            err_code[1] = 0;
        end
        1: begin //0000 sub
            output1 = sum;
        err_code[0] = 0;
            err_code[1] = 0;
        end 
        2: begin // mult
            output1 = product; 
	    err_code[0] =  0;
            err_code[1] =  0;
        end 
        3: begin //div 
            output1 = quotient;
            err_code[1] =  err_1_1;
        end 
        4: begin //mod 
	    output1 = remainder;
		err_code[1] = err_1_2;
          
        end
        default:begin
          
        end 
            
    endcase
end
*/

    
endmodule

module Testbench (
);
    reg [15:0] input1;
    reg [15:0] input2;
    wire signed  [31:0] output1;
    wire [1:0] err_code;
    reg [3:0] op_code;

    BreadBoard BB( .input1(input1), 
    .input2(input2), 
    .op_code(op_code),
    .output1(output1), 
    .err_code(err_code));


    initial begin   	
    //$display acts like a classic C printf command.
    $display ("Begin test #1"); //add
    input1 = 11;
    input2 = 15;
    op_code = 4'b0000;
    #50;
    $display ("[Input A:%6d, Input B: %6d] [Add:%b] [output:%11d, Error:%b] ", input1, input2, op_code, output1, err_code);

    $display ("Begin test #2");
    input1 = 11;
    input2 = 15;
    op_code = 4'b0001;
    #50;
    $display ("[Input A:%6d, Input B: %6d] [Sub:%b] [output:%11d, Error:%b] ", input1, input2, op_code, output1, err_code);
    

    $display ("Begin test #3");
    input1 = 11;
    input2 = 15;
    op_code = 4'b0010;
    #50;
    $display ("[Input A:%6d, Input B: %6d] [Mul:%b] [output:%11d, Error:%b] ", input1, input2, op_code, output1, err_code);
    

    $display ("Begin test #4");
    input1 = 11;
    input2 = 0;
    op_code = 4'b0011;
    #50;
    $display ("[Input A:%6d, Input B: %6d] [Div:%b] [output:%11d, Error:%b] ", input1, input2, op_code, output1, err_code);
    

    $display ("Begin test #5");
    input1 = 11;
    input2 = 0;
    op_code = 4'b0100;
    #50;
    $display ("[Input A:%6d, Input B: %6d] [Mod:%b] [output:%11d, Error:%b] ", input1, input2, op_code, output1, err_code);


    $display ("Begin test #1");
    input1 = 65000;
    input2 = 65000;
    op_code = 4'b0000;
    #50;
    $display ("[Input A:%6d, Input B: %6d] [Add:%b] [output:%11d, Error:%b] ", input1, input2, op_code, output1, err_code);

    $display ("Begin test #2");
    input1 = 32000;
    input2 = 16000;
    op_code = 4'b0001;
    #50;
    $display ("[Input A:%6d, Input B: %6d] [Sub:%b] [output:%11d, Error:%b] ", input1, input2, op_code, output1, err_code);
    

    $display ("Begin test #3");
    input1 = 32000;
    input2 = 16000;
    op_code = 4'b0010;
    #50;
    $display ("[Input A:%6d, Input B: %6d] [Mul:%b] [output:%11d, Error:%b] ", input1, input2, op_code, output1, err_code);
    

    $display ("Begin test #4");
    input1 = 32000;
    input2 = 16000;;
    op_code = 4'b0011;
    #50;
    $display ("[Input A:%6d, Input B: %6d] [Div:%b] [output:%11d, Error:%b] ", input1, input2, op_code, output1, err_code);
    

    $display ("Begin test #5");
    input1 = 32000;
    input2 = 16000;
    op_code = 4'b0100;
    #50;
    $display ("[Input A:%6d, Input B: %6d] [Mod:%b] [output:%11d, Error:%b] ", input1, input2, op_code, output1, err_code);
    

    $finish;
    end
endmodule