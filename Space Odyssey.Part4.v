//=============================================
// DFF
//=============================================

module Testbench (
);
    wire [9:0][23:0] strip;
    reg [3:0] op_code;
    reg clk;
    reg [4:0] i;
    reg [4:0] j;
    wire [2:0] brightness;

    BreadBoard BB(
    .clk(clk),
    .op_code(op_code),
    .strip(strip),
    .brightness(brightness)
    );

    initial begin
        forever begin
            clk = 0;
            #5;
            clk = 1;
            #5;
        end
    end


    initial begin

    op_code = 4'b0000;
    #10;
    j = 0;
    for (i = 0; i < 10 ; i++) 
    begin
        $display ("[%d, %d, %d]", strip[0][23:16], strip[0][15:8], strip[0][7:0]);
        $display ("[%d, %d, %d]", strip[1][23:16], strip[1][15:8], strip[1][7:0]);
        $display ("[%d, %d, %d]", strip[2][23:16], strip[2][15:8], strip[2][7:0]);
        $display ("[%d, %d, %d]", strip[3][23:16], strip[3][15:8], strip[3][7:0]);
        $display ("[%d, %d, %d]", strip[4][23:16], strip[4][15:8], strip[4][7:0]);
        $display ("[%d, %d, %d]", strip[5][23:16], strip[5][15:8], strip[5][7:0]);
        $display ("[%d, %d, %d]", strip[6][23:16], strip[6][15:8], strip[6][7:0]);
        $display ("[%d, %d, %d]", strip[7][23:16], strip[7][15:8], strip[7][7:0]);
        $display ("[%d, %d, %d]", strip[8][23:16], strip[8][15:8], strip[8][7:0]);
        $display ("[%d, %d, %d]", strip[9][23:16], strip[9][15:8], strip[9][7:0]);

    end
    
    //TODO: add other testing
    
    $finish;
    end
endmodule



module BreadBoard (
    clk, op_code, strip, brightness
);

    output [9:0][23:0] strip;
    output [2:0] brightness;
    input [3:0] op_code;
    input clk;

    wire [1:0] mode;
    wire [2:0] color_code;

    wire [2:0] brightness_mux_out;
    wire [1:0] mode_mux_out;
    wire [2:0] color_mux_out;
    wire [9:0][23:0] strip_out;
    
    Brightness_mux Mux1(op_code, brightness_mux_out);
    Mode_mux Mux2(op_code, mode_mux_out);
    Color_mux Mux3(op_code, color_mux_out);
    Strip_mux Mux4(op_code, mode, color_code, clk, strip_out);


    assign brightness = brightness_mux_out;
    assign mode = mode_mux_out;
    assign color_code = color_mux_out;
    assign strip =strip_out;

endmodule

module DFF(clk,in,out);
    parameter n=1;//width
    input clk;
    input [n-1:0] in;
    output [n-1:0] out;
    reg [n-1:0] out;

    always @(posedge clk)
        out = in;
endmodule

module Brightness_mux (
    op_code, brightness_mux_out
);
input  [3:0] op_code;
output [2:0] brightness_mux_out;

    
endmodule

module Mode_mux (
    op_code, mode_mux_out
);
input  [3:0] op_code;
output [1:0] mode_mux_out;

endmodule

module Color_mux (
    op_code, color_mux_out
);

input  [3:0] op_code;
output [2:0] color_mux_out;
    
endmodule

module Strip_mux (
    op_code, mode, color_code, clock, strip_out
);
    input [3:0] op_code;
    input [2:0] color_code;
    input [1:0] mode;
    input clock;
    output reg [9:0][23:0] strip_out;

    
    wire [2:0][9:0][23:0] channels;
    reg current_iteration;

    wire[23:0] solid_color;
    wire [9:0][23:0] rainbow_color;
    get_solid_color GSC (color_code, solid_color);
    get_rainbow_color GRC (color_code, rainbow_color, clock);
    
    assign channels[0] = {10{solid_color}}; 
    assign channels[1] = {10 {solid_color & {24 {current_iteration}} } };
    //assign channels[2] = 

    always @(*) begin
        /*
        if (mode == 0) begin
            strip_out = channels[0];
        end 
        if(mode == 1) begin
            strip_out = channels[1];
        end
        if(mode == 2) begin
          strip_out = channels[2];
        end
        */
        strip_out = channels[mode];
    end


endmodule

module get_solid_color (
    color_code, solid_color
);
    wire [7:0][23:0] channels; //8 solid color
    input [2:0] color_code;
    output reg [23:0] solid_color;

    assign channels[0] = 24'b1111_1111_0000_0000_0000_0000; //red
    assign channels[1] = 24'b00000000_11111111_00000000;    //green
    assign channels[2] = 24'b00000000_00000000_11111111;    //blue
    assign channels[3] = 24'b11111111_11111111_11111111;    //yellow
    assign channels[4] = 24'b11111111_01100100_00000000;    //orange
    assign channels[5] = 24'b11111111_00000000_11111111;    //pink
    assign channels[6] = 24'b01100100_00000000_11111111;    //purple
    assign channels[7] = 24'b11111111_11111111_11111111;    //white

    always @(*) begin
        solid_color = channels[color_code];
    end
    
endmodule

module get_rainbow_color (
    color_code, strip_out, clk
);
    input [2:0] color_code;
    input clk;
    output [9:0][23:0] strip_out;

    //wire [2:0][7:0][23:0] channels;
    reg [2:0][7:0][23:0] colors; 

    initial begin
        //TODO: fill in colors
        //colors[0] = 
    end

    always @(posedge clk) begin
        colors[0] = colors[0] <<< 1;
        colors[0][0] = colors[0][7];

        colors[1] = colors[1] <<< 1;
        colors[1][0] = colors[1][7];

        colors[2] = colors[2] <<< 1;
        colors[2][0] = colors[2][7];
    end
    
endmodule