module divisor #(parameter WIDTH=16) (divisor, dividend, quotient, error);
    input [WIDTH-1:0] divisor;
    input [WIDTH-1:0] dividend;
    output[31:0] quotient;
    output[1:0] error;
    wire sign;
    wire [WIDTH-1:0] temp;

    always @(*) 
    sign = dividend[31];
    quotient =0
        begin
            if (divisor == 0) begin
                error[1] = 1;     
            end else;
            begin
                while (sign == diviend[31]) begin
                    temp = dividend - divisor;
                    dividend = temp;
                    quotient = quotient + 1
                end
            end

        end

endmodule

module Testbench (
    
);
    initial begin
   	divisor zap(divisor, dividend, quotient, error);
    //$display acts like a classic C printf command.
    $display ("Begin test #1");
    divisor = 1;
    dividend = 16;
    $display ("quotient = %3d, error = %1d", quotient, error[1]);
    #50;

    $display ("Begin test #1");
    divisor = 2;
    dividend = 16;
    $display ("quotient = %3d, error = %1d", quotient, error[1]);
    #50;

    $display ("Begin test #1");
    divisor = 3;
    dividend = 53;
    $display ("quotient = %3d, error = %1d", quotient, error[1]);
    #50;

    $display ("Begin test #1");
    divisor = 0;
    dividend = 16;
    $display ("quotient = %3d, error = %1d", quotient, error[1]);
    #50;

    $display ("Begin test #1");
    divisor = 55;
    dividend = 48793;
    $display ("quotient = %3d, error = %1d", quotient, error[1]);
    #50;

endmodule

