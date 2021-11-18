`define NUM_LEDS 10

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

module ColorTable (color_code, r, g, b);
    input [3:0] color_code;
    output reg [7:0] r, g, b;

    always @(*) begin
        case(color_code)    //Adapted from Apple 16 color palette: https://en.wikipedia.org/wiki/List_of_software_palettes#Apple_Macintosh_default_16-color_palette
            0: begin    //white
                r = 255;
                g = 255;
                b = 255;
            end
            1: begin    //yellow
                r = 255;
                g = 255;
                b = 0;
            end
            2: begin    //orange
                r = 255;
                g = 100;
                b = 0;
            end
            3: begin    //red
                r = 255;
                g = 0;
                b = 0;
            end
            4: begin    //pink
                r = 255;
                g = 0;
                b = 255;
            end
            5: begin    //purple
                r = 100;
                g = 0;
                b = 255;
            end
            6: begin    //blue
                r = 0;
                g = 0;
                b = 255;
            end
            7: begin
                r = 0;
                g = 255;
                b = 255;
            end
            8: begin
                r = 0;
                g = 255;
                b = 0;
            end
            9: begin
                r = 0;
                g = 100;
                b = 0;
            end
            default: begin
                r = 0;
                g = 0;
                b = 0;
            end
        endcase
    end

endmodule

module SolidColor (brightness, color_code, solid_color);
    input [3:0] brightness;
    input [3:0] color_code;
    output reg [23:0] solid_color;
    wire [7:0] r, g, b;
    reg [7:0] diff;
    ColorTable ct(color_code, r, g, b);

    always @(*) begin
        diff = 15 - brightness;
        solid_color[7:0] = (17*diff > b) ? 8'b0 : b - (17*diff);
        solid_color[15:8] = (17*diff > g) ? 8'b0 : g - (17*diff);
        solid_color[23:16] = (17*diff > r) ? 8'b0 : r - (17*diff);
    end
endmodule

module FlashingColor (brightness, color_code, previous, flashed_color);
    input [3:0] brightness;
    input [3:0] color_code;
    input [23:0] previous;
    output reg [23:0] flashed_color;
    wire [7:0] r, g, b;
    reg [7:0] diff;
    ColorTable ct(color_code, r, g, b);

    always @(*) begin
        diff = 15 - brightness;
        flashed_color[7:0] = (17*diff > b) ? 8'b0 : b - (17*diff);
        flashed_color[15:8] = (17*diff > g) ? 8'b0 : g - (17*diff);
        flashed_color[23:16] = (17*diff > r) ? 8'b0 : r - (17*diff);

        flashed_color = (previous == 0) ? flashed_color : 0;
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
input [15:0][23:0] channels;
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

module RGBController (
    clk,
    mode,
    brightness,
    color_code,
    color_out,
);
    input clk;
    input [1:0] mode;
    input [3:0] brightness;
    input [3:0] color_code;
    reg [15:0] input2;

    wire [15:0] [23:0] channels;
    wire [15:0] onehotMux;
    wire [31:0] muxout;
    wire [31:0] outval;
    wire [23:0] feedback;
    wire [23:0] solid_color;
    wire [23:0] flashing_color;
    wire [23:0] rainbow_color;

    DFF #(32) Accumulator(clk,muxout,outval);

    output [23:0] color_out;
    reg [23:0] color_out;

    Dec4x16 decode(mode, onehotMux);
    Mux16to1 mux(channels, onehotMux, muxout);
    SolidColor solid(brightness, color_code, solid_color);
    FlashingColor flash(brightness, color_code, feedback, flashing_color);
    //RainbowColor rainbow(brightness, feedback);

    assign channels[ 0] = 24'b0; //Off
    assign channels[ 1] = solid_color[23:0];   //solid
    assign channels[ 2] = flashing_color;
    // assign channels[ 3] = quotient;
    // assign channels[ 4] = remainder; 
    // assign channels[ 5] = andout;
    // assign channels[ 6] = orout;
    // assign channels[ 7] = nandout;
    // assign channels[ 8] = norout;
    // assign channels[ 9] = xorout;
    // assign channels[ 10] = xnorout;
    // assign channels[ 11] = notout;
    //assign channels[ 12] = 32'b11111111111111111111111111111111;
    //assign channels[ 13] = 32'b00000000000000000000000000000000;
    assign channels[ 14] = feedback;
    assign feedback = outval[23:0];

    always@(*)
    begin
        color_out = muxout;
    end
endmodule

module BreadBoard(
    clk,
    mode,
    brightness,
    color_code,
    strip,
);
    input clk;
    input [1:0] mode;
    input [3:0] brightness;
    input [3:0] color_code;
    wire [23:0] light;
    output [`NUM_LEDS:0][23:0] strip;
    reg [3:0] i;
    

    RGBController leds [`NUM_LEDS:0](
        .clk(clk),
        .mode(mode),
        .brightness(brightness),
        .color_code(color_code),
        .color_out(strip));

endmodule

module Testbench (
);
    reg [1:0] mode;
    reg [3:0] brightness;
    reg [3:0] color_code;
    wire [`NUM_LEDS:0][23:0] strip;
    reg [3:0] i, x;

    reg clk;

    BreadBoard BB(
    .clk(clk),
    .mode(mode), 
    .brightness(brightness),
    .color_code(color_code),
    .strip(strip));
	
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

    $display ("On");
    //Init
    mode = 0;
    brightness = 4'b1111;
    color_code = 4'b0000;
    #5;
    for (i = 0; i < `NUM_LEDS; i++) 
    begin
    $display ("Led %d: %h", i, strip[i]);
    end

    $display ("set mode solid");

    mode = 1;
    color_code = 4'b0000;
    #5;
    for (i = 0; i < `NUM_LEDS ; i++) 
    begin
    $display ("Led %d: %h", i, strip[i]);
    end

    $display ("Set color 0101");

    brightness = 4'b1111;
    color_code = 4'b0101;
    #5;
    for (i = 0; i < `NUM_LEDS ; i++) 
    begin
    $display ("Led %d: %h", i, strip[i]);
    end

    $display ("Adjust brightness");

    brightness = 4'b1001;
    #5;
    for (i = 0; i < `NUM_LEDS ; i++) 
    begin
    $display ("Led %d: %h", i, strip[i]);
    end

    $display ("Set flashing");

    mode = 2;
    brightness = 4'b1111;
    color_code = 4'b0000;
    for (x = 0; x < 4; x++)
    begin
        #10;
        for (i = 0; i < `NUM_LEDS; i++) 
        begin
        $display ("Led %d: %h", i, strip[i]);
        end
    end
    
    // //No Op
    // input1 = 0;
    // op_code = 4'b1110;
    // #10;
    // $display ("[Input:%6d, Feedback: %6d] [NoOp:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    // //Add
    // input1 = 7;
    // op_code = 4'b0000;
    // #5; //FOR SOME REASON THIS HAS TO BE 5 OR ELSE THE PROGRAM DOESNT WORK PROPERLY
    // $display ("[Input A:%6d, Feedback: %6d] [Add:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);
    
    // //Sub
    // input1 = 3;
    // op_code = 4'b0001;
    // #10;
    // $display ("[Input A:%6d, Feedback: %6d] [Sub:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);
    
    // //Mul
    // input1 = 250;
    // op_code = 4'b0010;
    // #10;
    // $display ("[Input A:%6d, Feedback: %6d] [Mul:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);
    
    // //Div
    // input1 = 32;
    // op_code = 4'b0011;
    // #10;
    // $display ("[Input A:%6d, Feedback: %6d] [Div:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    // //Mod
    // input1 = 4;
    // op_code = 4'b0100;
    // #10;
    // $display ("[Input A:%6d, Feedback: %6d] [Mod:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    // //AND
    // input1 = 32;
    // op_code = 4'b0101;
    // #10;
    // $display ("[Input A:%6d, Feedback: %6d] [AND:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    // //OR
    // input1 = 42;
    // op_code = 4'b0110;
    // #10;
    // $display ("[Input A:%6d, Feedback: %6d] [OR:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    // //NOT
    // input1 = 0;
    // op_code = 4'b1011;
    // #10;
    // $display ("[Input A:%6d, Feedback: %6d] [NOT:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    // //XOR
    // input1 = 65535;
    // op_code = 4'b1001;
    // #10;
    // $display ("[Input A:%6d, Feedback: %6d] [XOR:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    // //XNOR
    // input1 = 65525;
    // op_code = 4'b1010;
    // #10;
    // $display ("[Input A:%6d, Feedback: %6d] [XNOR:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    // //NAND 
    // input1 = 65535;
    // op_code = 4'b0111;
    // #10;
    // $display ("[Input A:%6d, Feedback: %6d] [NAND:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    // //NOR 
    // input1 = 65535;
    // op_code = 4'b1000;
    // #10;
    // $display ("[Input A:%6d, Feedback: %6d] [NOR:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);

    // //Preset 
    // input1 = 0;
    // op_code = 4'b1100;
    // #10;
    // $display ("[Input A:%6d, Feedback: %6d] [Preset:%b] [output:%11d, Error:%b] ", input1, BB.feedback, op_code, output1, err_code);


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

