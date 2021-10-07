module divide #(
    parameter
    WIDTH=16
) (
    divisor, dividend, quotient, error
);

    input [WIDTH-1:0] divisor;
    input [WIDTH-1:0] dividend;
    output reg [31:0] quotient;
    output reg [1:0] error;
    reg [WIDTH-1:0] reverse;
    wire [31:0] rv_quotient;
    wire [31:0] unrv_quotient;
    wire OF_flag_1;
    wire OF_flag_2;

    unsign_divide udv(divisor, dividend, unrv_quotient, OF_flag_1);
    unsign_divide redv(reverse, dividend, rv_quotient, OF_flag_2);

    always @(*) begin
        error[1] = OF_flag_1 | OF_flag_2;
        reverse = -divisor;
        if (dividend[WIDTH-1] !== divisor[WIDTH-1])
        begin
            quotient = -rv_quotient;
        end else begin
            quotient = unrv_quotient;
        end


    end

endmodule

module unsign_divide #(parameter WIDTH=16) (divisor, dividend, quotient, error);
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
    divisor, 
    dividend, 
    quotient, 
    error
);
    input [15:0] divisor;
    input [15:0] dividend;
    output[31:0] quotient;
    output[1:0] error;
    divide dv(divisor, dividend, quotient, error);

    
endmodule

module Testbench (
);
    reg [15:0] divisor;
    reg [15:0] dividend;
    wire signed  [31:0] quotient;
    wire [1:0] error;

    BreadBoard BB( .divisor(divisor), 
    .dividend(dividend), 
    .quotient(quotient), 
    .error(error));

    initial begin   	
    //$display acts like a classic C printf command.
    $display ("Begin test #1");
    divisor = 1;
    dividend = 16;
    #50;
    $display ("quotient = %3d, error = %1d", quotient, error[1]);

    $display ("Begin test #2");
    divisor = 2;
    dividend = 16;
    #50;
    $display ("quotient = %3d, error = %1d", quotient, error[1]);
    

    $display ("Begin test #3");
    divisor = 3;
    dividend = 53;
    #50;
    $display ("quotient = %3d, error = %1d", quotient, error[1]);
    

    $display ("Begin test #4");
    divisor = 0;
    dividend = 16;
    #50;
    $display ("quotient = %3d, error = %1d", quotient, error[1]);
    

    $display ("Begin test #5");
    divisor = 55;
    dividend = 8793;
    #50;
    $display ("quotient = %3d, error = %1d", quotient, error[1]);

    $display("Different Sign");
    $display ("Begin test #1");
    divisor = -1;
    dividend = 16;
    #50;
    $display ("quotient = %3d, error = %1d", quotient, error[1]);

    $display ("Begin test #2");
    divisor = -2;
    dividend = 16;
    #50;
    $display ("quotient = %3d, error = %1d", quotient, error[1]);
    

    $display ("Begin test #3");
    divisor = -3;
    dividend = 53;
    #50;
    $display ("quotient = %3d, error = %1d", quotient, error[1]);
    

    $display ("Begin test #4");
    divisor = 0;
    dividend = -16;
    #50;
    $display ("quotient = %3d, error = %1d", quotient, error[1]);
    

    $display ("Begin test #5");
    divisor = -55;
    dividend = 8793;
    #50;
    $display ("quotient = %3d, error = %1d", quotient, error[1]);
    

    $finish;
    end
endmodule

