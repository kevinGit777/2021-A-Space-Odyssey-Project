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
    output[31:0] output1;
    output[1:0] err_code;

    reg [31:0] sum;
    reg [31:0] product;
    reg [31:0] quotient;
    reg [31:0] remainder;
    reg err_1;
    reg err_2;

    add_sub as(input1, input2, sum, err_code);
    multiply mul(input1, input2, product);
    divide dv(input1, input2, quotient, err_code);
    modulo mod(input1, input2, remainder, err_code);

always @(*) begin
    case (op_code)
        0: begin //0000 add
          
        end
        1: begin //0000 sub
          
        end 
        2: begin // mult
          
        end 
        3: begin //div 
            output1 = quotient;
            err_code[1] = err_code;
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

