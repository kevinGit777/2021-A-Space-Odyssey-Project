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

    op_code = 4'b0001;
    #10;
    j = 0;
    for (i = 0; i < 10 ; i++) 
    begin
        $display("OP_CODE:%d, Iteration %2d", op_code, i+1);
        $display ("[%d, %d, %d]", strip[0][23:16], strip[0][15:8], strip[0][7:0]);
        $display ("[%d, %d, %d]", strip[1][23:16], strip[1][15:8], strip[1][7:0]);       
        $display ("[%d, %d, %d]", strip[2][23:16], strip[2][15:8], strip[2][7:0]);
        $display ("[%d, %d, %d]", strip[3][23:16], strip[3][15:8], strip[3][7:0]);
        $display ("[%d, %d, %d]", strip[4][23:16], strip[4][15:8], strip[4][7:0]);
        #10;
/*        $display ("[%d, %d, %d]", strip[5][23:16], strip[5][15:8], strip[5][7:0]);
        $display ("[%d, %d, %d]", strip[6][23:16], strip[6][15:8], strip[6][7:0]);
        $display ("[%d, %d, %d]", strip[7][23:16], strip[7][15:8], strip[7][7:0]);
        $display ("[%d, %d, %d]", strip[8][23:16], strip[8][15:8], strip[8][7:0]);
        $display ("[%d, %d, %d]", strip[9][23:16], strip[9][15:8], strip[9][7:0]);
*/
    end
    
    
    op_code = 4'b0000;
    op_code = 4'b0010;
    #5;
    #5;
    for (i = 0; i < 10 ; i++) 
    begin
/*        $display("OP_CODE:%d, Iteration %2d", op_code, i+1);
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
 */   end
    
    op_code = 4'b0000;
    op_code = 4'b0010;
    
    for (i = 0; i < 10 ; i++) 
    begin
        $display("OP_CODE:%d, Iteration %2d", op_code, i+1);
        $display ("[%d, %d, %d]", strip[0][23:16], strip[0][15:8], strip[0][7:0]);
        $display ("[%d, %d, %d]", strip[1][23:16], strip[1][15:8], strip[1][7:0]);
        $display ("[%d, %d, %d]", strip[2][23:16], strip[2][15:8], strip[2][7:0]);
        #10;
/*        $display ("[%d, %d, %d]", strip[3][23:16], strip[3][15:8], strip[3][7:0]);
        $display ("[%d, %d, %d]", strip[4][23:16], strip[4][15:8], strip[4][7:0]);
        $display ("[%d, %d, %d]", strip[5][23:16], strip[5][15:8], strip[5][7:0]);
        $display ("[%d, %d, %d]", strip[6][23:16], strip[6][15:8], strip[6][7:0]);
        $display ("[%d, %d, %d]", strip[7][23:16], strip[7][15:8], strip[7][7:0]);
        $display ("[%d, %d, %d]", strip[8][23:16], strip[8][15:8], strip[8][7:0]);
        $display ("[%d, %d, %d]", strip[9][23:16], strip[9][15:8], strip[9][7:0]);
        
 */   end

    op_code = 4'b0000;
    //op_code = 4'b0010;
    #5;
    #5;
    for (i = 0; i < 10 ; i++) 
    begin
        $display("OP_CODE:%d, Iteration %2d", op_code, i+1);
        $display ("[%d, %d, %d]", strip[0][23:16], strip[0][15:8], strip[0][7:0]);
/*        $display ("[%d, %d, %d]", strip[1][23:16], strip[1][15:8], strip[1][7:0]);
        $display ("[%d, %d, %d]", strip[2][23:16], strip[2][15:8], strip[2][7:0]);
        $display ("[%d, %d, %d]", strip[3][23:16], strip[3][15:8], strip[3][7:0]);
        $display ("[%d, %d, %d]", strip[4][23:16], strip[4][15:8], strip[4][7:0]);
        $display ("[%d, %d, %d]", strip[5][23:16], strip[5][15:8], strip[5][7:0]);
        $display ("[%d, %d, %d]", strip[6][23:16], strip[6][15:8], strip[6][7:0]);
        $display ("[%d, %d, %d]", strip[7][23:16], strip[7][15:8], strip[7][7:0]);
        $display ("[%d, %d, %d]", strip[8][23:16], strip[8][15:8], strip[8][7:0]);
        $display ("[%d, %d, %d]", strip[9][23:16], strip[9][15:8], strip[9][7:0]);
   */ end
    
    
    
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
    
    Brightness_mux Mux1(op_code, brightness_mux_out, clk);
   // Mode_mux Mux2(op_code, mode_mux_out, clk);
    Color_mux Mux3(op_code, color_mux_out, clk);
    Strip_mux Mux4(op_code, mode, color_code, clk, strip_out);
   // DFF f (clk);

    assign brightness = brightness_mux_out;
    //assign mode = mode_mux_out;
    assign mode = 2;
    assign color_code = color_mux_out;
    assign strip = strip_out;

endmodule

module DFF(clk);
    input clk;
    always @(posedge clk)
        $display("clk tking.");
endmodule

module Brightness_mux (
    op_code, brightness_mux_out, clk
);
input  [3:0] op_code;
input clk;
output reg [2:0] brightness_mux_out;

wire [3:0] channels;  
assign channels[3] = 15;

always @(*) begin
    if (op_code == 1) begin
        brightness_mux_out = channels[3]; // default/initial value
    end
end

    
endmodule

module Mode_mux (
    op_code, mode_mux_out, clk
);
input  [3:0] op_code;
input clk;
output reg [1:0] mode_mux_out;

reg [3:0][1:0] channels;  

initial begin
    channels[3] = 0;
end


always @(*) begin
    if (op_code == 1) begin
        mode_mux_out = channels[3]; // default/initial value
    end
    else if (op_code == 2) begin
        mode_mux_out = channels[1];
    end 
    else if(op_code == 3) begin
        mode_mux_out = channels[2];
    end
    else begin
       mode_mux_out = channels[0];
    end

    channels[0] = mode_mux_out;
    
    channels[1] = mode_mux_out + 1;
    if(mode_mux_out == 2) begin
      channels[1] = 0;
    end

    channels[2] = mode_mux_out - 1;
    if (mode_mux_out == 0) begin
        channels[2] = 2;
    end
   // $display("Mode mux out: %d", mode_mux_out);
    //$display("Mode channel 1: %d", channels[1]);

end

endmodule

module Color_mux (
    op_code, color_mux_out, clk
);

input  [3:0] op_code;
input clk;
output reg [2:0] color_mux_out;

wire [3:0] channels;  
assign channels[3] = 0;

always @(*) begin
    if (op_code == 1) begin
        color_mux_out = channels[3]; // default/initial value
    end
end
    
endmodule

module Strip_mux (
    op_code, mode, color_code, clk, strip_out
);
    input [3:0] op_code;
    input [2:0] color_code;
    input [1:0] mode;
    input clk;
    output reg [9:0][23:0] strip_out;

    
    wire [2:0][9:0][23:0] channels;
    reg current_iteration;

    wire[23:0] solid_color;
    wire [9:0][23:0] rainbow_color;
    get_solid_color GSC (color_code, solid_color);
    get_rainbow_color GRC (color_code, rainbow_color, clk);
    
    assign channels[0] = {10{solid_color}}; 
    assign channels[1] = {10{solid_color & {24 {current_iteration}} } };
    assign channels[2] = rainbow_color;
    //assign channels[2] = 

    initial begin
        current_iteration = 0;
    end

    always @(*) begin
        strip_out = channels[mode];
        $display("Mode: %d",mode);
        $display ("Rainbow: [%d, %d, %d]", rainbow_color[0][23:16], rainbow_color[0][15:8], rainbow_color[0][7:0]);
        
    end

    always @(posedge clk ) begin
        current_iteration = current_iteration+1;
    end

endmodule

module get_solid_color (
    color_code, solid_color
);
    wire [7:0][23:0] channels; //8 solid color
    input [2:0] color_code;
    output reg [23:0] solid_color;

    assign channels[0] = 24'b11111111_00000000_00000000;    //red
    assign channels[1] = 24'b00000000_11111111_00000000;    //green
    assign channels[2] = 24'b00000000_00000000_11111111;    //blue
    assign channels[3] = 24'b11111111_11111111_00000000;    //yellow
    assign channels[4] = 24'b11111111_01100100_00000000;    //orange
    assign channels[5] = 24'b11111111_00000000_11111111;    //pink
    assign channels[6] = 24'b01100100_00000000_11111111;    //purple
    assign channels[7] = 24'b11111111_11111111_11111111;    //white

    always @(*) begin
        solid_color = channels[color_code];
    end
    
    always @(*) begin
        solid_color = channels[color_code];
    end
    
endmodule

module get_rainbow_color (
    color_code, strip_out, clk
);
    input [2:0] color_code;
    input clk;
    output reg [9:0][23:0] strip_out;

    //wire [7:0][23:0] channels;
    reg [7:0][9:0][23:0] colors; 

    //wire [2:0][7:0][23:0] channels;
    reg [7:0][9:0][23:0] colors; 

    initial begin
        //TODO: fill in colors
        //colors[0] = 
        colors[0][0] = 24'b00001001_01000000_01110100;
        colors[0][1] = 24'b00111100_01101001_10010111;
        colors[0][2] = 24'b01011010_11011011_11111111;
        colors[0][3] = 24'b11111111_11011101_01001010;
        colors[0][4] = 24'b11111110_10010000_00000000;
        colors[0][5] = 24'b10000010_00000010_01100011;
        colors[0][6] = 24'b11011001_00000011_01101000;
        colors[0][7] = 24'b11100010_01110001_10100001;
        colors[0][8] = 24'b11100110_10101000_10111110;
        colors[0][9] = 24'b11101010_11011110_11011010;

        colors[1][0] = 24'b00101101_01111101_11010010;
        colors[1][1] = 24'b10010111_11001100_00000100;
        colors[1][2] = 24'b11101110_10111001_00000010;
        colors[1][3] = 24'b11110100_01011101_00000001;
        colors[1][4] = 24'b01000111_01000110_01000111;
        colors[1][5] = 24'b00111000_00011101_00101010;
        colors[1][6] = 24'b00000101_00011001_00100011;
        colors[1][7] = 24'b01010010_00111010_00110100;
        colors[1][8] = 24'b10111001_11111010_11111000;
        colors[1][9] = 24'b01001001_00110000_01101011;
    end

    always @(*) begin
        strip_out = colors[color_code];
    end

    always @(posedge clk)begin
        colors[0][0] <= colors[0][9]; //all assign concurrenly
        colors[0][1] <= colors[0][0];
        colors[0][2] <= colors[0][1];
        colors[0][3] <= colors[0][2];
        colors[0][4] <= colors[0][3];
        colors[0][5] <= colors[0][4];
        colors[0][6] <= colors[0][5];
        colors[0][7] <= colors[0][6];
        colors[0][8] <= colors[0][7];
        colors[0][9] <= colors[0][8];
        $display("cycle.");
    end
        
endmodule