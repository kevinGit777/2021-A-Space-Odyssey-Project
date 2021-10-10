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
        t1 = dividend;
        t2 = remainder;
        if(divisor == 0) begin
            err = 1;
        end
        else if(divisor < 0) begin
            err = 1;
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
	
endmodule;

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
    output reg[31:0] output1;
    output reg[1:0] err_code;

    reg [31:0] sum;
    wire [31:0] product;
    wire [31:0] quotient;
    reg [31:0] remainder;
    wire err_0;
    wire err_1;



   // add_sub as(input1, input2, sum, err_0);
    multiplication mul(input1, input2, product);
    divide dv(input1, input2, quotient, err_1);
    //modulo mod(input1, input2, remainder, err_1);

always @(*) begin
    case (op_code)
        0: begin //0000 add
          
        end
        1: begin //0000 sub
          
        end 
        2: begin // mult
            output1 = product; 
	    err_code[0] =  0;
            err_code[1] =  0;
        end 
        3: begin //div 
            output1 = quotient;
            err_code[1] =  err_1;
        end 
        4: begin //mod 
          
        end

        default:begin
          
        end 
            
    endcase



end
    

    
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
    $display ("[Input A:%6d, Input B: %6d] [Add:%b] [output:%11d, Error%b] ", input1, input2, op_code, output1, err_code);

    $display ("Begin test #2");
    input1 = 11;
    input2 = 15;
    op_code = 4'b0001;
    #50;
    $display ("[Input A:%6d, Input B: %6d] [Sub:%b] [output:%11d, Error%b] ", input1, input2, op_code, output1, err_code);
    

    $display ("Begin test #3");
    input1 = 11;
    input2 = 15;
    op_code = 4'b0010;
    #50;
    $display ("[Input A:%6d, Input B: %6d] [Mul:%b] [output:%11d, Error%b] ", input1, input2, op_code, output1, err_code);
    

    $display ("Begin test #4");
    input1 = 11;
    input2 = 0;
    op_code = 4'b0011;
    #50;
    $display ("[Input A:%6d, Input B: %6d] [Div:%b] [output:%11d, Error%b] ", input1, input2, op_code, output1, err_code);
    

    $display ("Begin test #5");
    input1 = 11;
    input2 = 0;
    op_code = 4'b0100;
    #50;
    $display ("[Input A:%6d, Input B: %6d] [Mod:%b] [output:%11d, Error%b] ", input1, input2, op_code, output1, err_code);


    $display ("Begin test #1");
    input1 = 32000;
    input2 = 16000;
    op_code = 4'b0000;
    #50;
    $display ("[Input A:%6d, Input B: %6d] [Add:%b] [output:%11d, Error%b] ", input1, input2, op_code, output1, err_code);

    $display ("Begin test #2");
    input1 = 32000;
    input2 = 16000;
    op_code = 4'b0001;
    #50;
    $display ("[Input A:%6d, Input B: %6d] [Sub:%b] [output:%11d, Error%b] ", input1, input2, op_code, output1, err_code);
    

    $display ("Begin test #3");
    input1 = 32000;
    input2 = 16000;
    op_code = 4'b0010;
    #50;
    $display ("[Input A:%6d, Input B: %6d] [Mul:%b] [output:%11d, Error%b] ", input1, input2, op_code, output1, err_code);
    

    $display ("Begin test #4");
    input1 = 32000;
    input2 = 16000;;
    op_code = 4'b0011;
    #50;
    $display ("[Input A:%6d, Input B: %6d] [Div:%b] [output:%11d, Error%b] ", input1, input2, op_code, output1, err_code);
    

    $display ("Begin test #5");
    input1 = 32000;
    input2 = 16000;
    op_code = 4'b0100;
    #50;
    $display ("[Input A:%6d, Input B: %6d] [Mod:%b] [output:%11d, Error%b] ", input1, input2, op_code, output1, err_code);
    

    $finish;
    end
endmodule

