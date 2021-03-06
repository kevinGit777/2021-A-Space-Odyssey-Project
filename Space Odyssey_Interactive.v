
module Testbench (

);
   parameter command = -1;

    wire [9:0][23:0] strip;
    reg [3:0] op_code;
    reg clk;
    reg [4:0] i;
    wire [2:0] brightness;
    reg [3:0] in;
    

    integer inFile;
    integer outFile;

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
    outFile = $fopen("command_history.txt", "a");
    $fdisplay(outFile,"%b",command); //write as binary
    $fclose(outFile);

    inFile =  $fopen("command_history.txt", "r");
    op_code = 4'b0001; //Turn On System
    #100; 
    op_code = 4'b0000; // back to no_op
    #10;
    while (!$feof(inFile) && $fscanf(inFile, "%b\n",in)) 
    begin
        op_code = in;
        #100;
        op_code = 4'b0000;
        #10;
    end
    $fclose(inFile);
    $finish;
    end
endmodule



module BreadBoard (
    clk, op_code, strip, brightness
);

    output [9:0][23:0] strip;
    output [2:0] brightness;
    input  [3:0] op_code;
    input clk;

    wire [1:0] mode;
    wire [2:0] color_code;
    reg [4:0] i;
    

    wire [2:0] brightness_mux_out;
    wire [1:0] mode_mux_out;
    wire [2:0] color_mux_out;
    wire [9:0][23:0] strip_out;

    integer outColors;
    
    Brightness_mux Mux1(op_code, brightness_mux_out );
    Mode_mux Mux2(op_code, mode_mux_out );
    Color_mux Mux3(op_code, color_mux_out);
    Strip_mux Mux4(op_code, mode, color_code, clk, strip_out);

    assign brightness = brightness_mux_out;
    assign mode = mode_mux_out;
    assign color_code = color_mux_out;
    assign strip = strip_out;

    always @(op_code) begin
        $display("OP_CODE:%d, Mode:%d, Color Set:%d, Brightness:%d.", op_code, mode, color_code, brightness);
        outColors = $fopen("./LED_COLORS.txt", "w");
        $fdisplay(outColors, "%d %d %d %d", op_code, mode, color_code, brightness);
        
    for (i = 0; i < 10 ; i++) 
        begin
        #10;
        /*
        $display("Iteration %2d", i+1);
        $display ("[%h, %h, %h]", strip[0][23:16], strip[0][15:8], strip[0][7:0]);
        $display ("[%h, %h, %h]", strip[1][23:16], strip[1][15:8], strip[1][7:0]);       
        $display ("[%h, %h, %h]", strip[2][23:16], strip[2][15:8], strip[2][7:0]);
        $display ("[%h, %h, %h]", strip[3][23:16], strip[3][15:8], strip[3][7:0]);
        $display ("[%h, %h, %h]", strip[4][23:16], strip[4][15:8], strip[4][7:0]);       
        $display ("[%h, %h, %h]", strip[5][23:16], strip[5][15:8], strip[5][7:0]);
        $display ("[%h, %h, %h]", strip[6][23:16], strip[6][15:8], strip[6][7:0]);
        $display ("[%h, %h, %h]", strip[7][23:16], strip[7][15:8], strip[7][7:0]);
        $display ("[%h, %h, %h]", strip[8][23:16], strip[8][15:8], strip[8][7:0]);
        $display ("[%h, %h, %h]", strip[9][23:16], strip[9][15:8], strip[9][7:0]);
        */
        $fdisplay(outColors,"Iteration %2d", i+1);
        $fdisplay (outColors, "%h", strip[0]);
        $fdisplay (outColors, "%h", strip[1]);
        $fdisplay (outColors, "%h", strip[2]);
        $fdisplay (outColors, "%h", strip[3]);
        $fdisplay (outColors, "%h", strip[4]);
        $fdisplay (outColors, "%h", strip[5]);
        $fdisplay (outColors, "%h", strip[6]);
        $fdisplay (outColors, "%h", strip[7]);
        $fdisplay (outColors, "%h", strip[8]);
        $fdisplay (outColors, "%h", strip[9]);
        /*
        $display ("Iteration %2d", i+1);
        $display ( "%h", strip[0]);
        $display ( "%h", strip[1]);
        $display ( "%h", strip[2]);
        $display ( "%h", strip[3]);
        $display ( "%h", strip[4]);
        $display ( "%h", strip[5]);
        $display ( "%h", strip[6]);
        $display ( "%h", strip[7]);
        $display ( "%h", strip[8]);
        $display ( "%h", strip[9]);
        */
        end
        $fclose(outColors);
        $display("\n");
    end

endmodule

module DFF(clk);
    input clk;
    always @(posedge clk)
        $display("clk tking.");
endmodule

module Brightness_mux (
    op_code, brightness_mux_out
);
input  [3:0] op_code;
output reg [2:0] brightness_mux_out;

reg [3:0][2:0] channels;  

initial begin
    channels[3] = 7;
end


always @(*) begin
    if (op_code == 1) begin
        brightness_mux_out = channels[3]; // default/initial value
    end
    else if (op_code == 6) begin
        brightness_mux_out = channels[1];
    end 
    else if(op_code == 7) begin
        brightness_mux_out = channels[2];
    end
    else begin
       brightness_mux_out = channels[0];
    end

    channels[0] = brightness_mux_out;
    
    channels[1] = brightness_mux_out + 1;
    if(brightness_mux_out == 7) begin
      channels[1] = 7;
    end

    channels[2] = brightness_mux_out - 1;
    if (brightness_mux_out == 0) begin
        channels[2] = 0;
    end
end

    
endmodule

module Mode_mux (
    op_code, mode_mux_out
);
input  [3:0] op_code;
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

end

endmodule

module Color_mux (
    op_code, color_mux_out
);

input  [3:0] op_code;
output reg [2:0] color_mux_out;

reg [3:0][2:0] channels;  

initial begin
    channels[3] = 0;
end

always @(op_code) begin
    if (op_code == 1) begin
        color_mux_out = channels[3]; // default/initial value
        channels[2] = color_mux_out; 
    end
    else if (op_code[3] == 1 && color_mux_out != op_code[2:0]) begin
        color_mux_out = op_code[2:0];
        channels[2] = channels[0]; 
    end
    else if (op_code == 4) begin
        color_mux_out = channels[1];
        channels[2] = channels[0]; 
    end 
    else if(op_code == 5) begin
        color_mux_out = channels[2];
    end
    else begin
       color_mux_out = channels[0];
    end
    
    channels[0] = color_mux_out;
    
    channels[1] = color_mux_out + 1;
    if(color_mux_out == 15) begin
      channels[1] = 0;
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
        //$display("Mode: %d",mode);
        //$display ("Rainbow: [%d, %d, %d]", rainbow_color[0][23:16], rainbow_color[0][15:8], rainbow_color[0][7:0]);
        
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
    
    
endmodule

module get_rainbow_color (
    color_code, strip_out, clk
);
    input [2:0] color_code;
    input clk;
    output reg [9:0][23:0] strip_out;

    //wire [7:0][23:0] channels;
    //reg [7:0][9:0][23:0] colors; 

    //wire [2:0][7:0][23:0] channels;
    reg [7:0][9:0][23:0] colors; 

    initial begin
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

        colors[2][0] = 'h947A4A;
        colors[2][1] = 'hE09816;
        colors[2][2] = 'hE05961;
        colors[2][3] = 'h432C94;
        colors[2][4] = 'h5831E0;
        colors[2][5] = 'h947A4A;
        colors[2][6] = 'hE09816;
        colors[2][7] = 'hE05961;
        colors[2][8] = 'h432C94;
        colors[2][9] = 'h5831E0;

        colors[3][0] = 'h90C6E8;
        colors[3][1] = 'h92DBD0;
        colors[3][2] = 'h96F2CA;
        colors[3][3] = 'hF29DE7;
        colors[3][4] = 'hCA9DF2;
        colors[3][5] = 'hE897B5;
        colors[3][6] = 'hF2A59D;
        colors[3][7] = 'h94E8EB;
        colors[3][8] = 'hEBD988;
        colors[3][9] = 'h94EBB2;

        colors[4][0] = 'hF0EAAF;
        colors[4][1] = 'hF7DA8B;
        colors[4][2] = 'hF56058;
        colors[4][3] = 'hFF996E;
        colors[4][4] = 'hFAF9E2;
        colors[4][5] = 'h77EAF5;
        colors[4][6] = 'hFAE1F7;
        colors[4][7] = 'hAFCBF0;
        colors[4][8] = 'hAFF0D7;
        colors[4][9] = 'hBCE1FA;

        colors[5][0] = 'h4FF7CD;
        colors[5][1] = 'h98F5DE;
        colors[5][2] = 'h78C2AF;
        colors[5][3] = 'hB5A7FA;
        colors[5][4] = 'hEBC9F9;
        colors[5][5] = 'hFACBC8;
        colors[5][6] = 'hE0918B;
        colors[5][7] = 'hAD706C;
        colors[5][8] = 'hF7ECDA;
        colors[5][9] = 'hE1F7CC;

        colors[6][0] = 'h7776E8;
        colors[6][1] = 'h7C9AF2;
        colors[6][2] = 'h7BACDB;
        colors[6][3] = 'h7CD8F2;
        colors[6][4] = 'h76E8E3;
        colors[6][5] = 'hA9F5CF;
        colors[6][6] = 'hE0918B;
        colors[6][7] = 'hBFE876;
        colors[6][8] = 'hE87681;
        colors[6][9] = 'hB47CF2;

        colors[7][0] = 'h7552E0;
        colors[7][1] = 'hE02D34;
        colors[7][2] = 'hE06E41;
        colors[7][3] = 'hE0D65D;
        colors[7][4] = 'hAFC7B7;
        colors[7][5] = 'h54E086;
        colors[7][6] = 'h397AE0;
        colors[7][7] = 'h3CC1E0;
        colors[7][8] = 'h84E038;
        colors[7][9] = 'hE018A9;

        
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

        colors[1][0] <= colors[1][9]; //all assign concurrenly
        colors[1][1] <= colors[1][0];
        colors[1][2] <= colors[1][1];
        colors[1][3] <= colors[1][2];
        colors[1][4] <= colors[1][3];
        colors[1][5] <= colors[1][4];
        colors[1][6] <= colors[1][5];
        colors[1][7] <= colors[1][6];
        colors[1][8] <= colors[1][7];
        colors[1][9] <= colors[1][8];

        colors[2][0] <= colors[2][9]; //all assign concurrenly
        colors[2][1] <= colors[2][0];
        colors[2][2] <= colors[2][1];
        colors[2][3] <= colors[2][2];
        colors[2][4] <= colors[2][3];
        colors[2][5] <= colors[2][4];
        colors[2][6] <= colors[2][5];
        colors[2][7] <= colors[2][6];
        colors[2][8] <= colors[2][7];
        colors[2][9] <= colors[2][8];

        colors[3][0] <= colors[3][9]; //all assign concurrenly
        colors[3][1] <= colors[3][0];
        colors[3][2] <= colors[3][1];
        colors[3][3] <= colors[3][2];
        colors[3][4] <= colors[3][3];
        colors[3][5] <= colors[3][4];
        colors[3][6] <= colors[3][5];
        colors[3][7] <= colors[3][6];
        colors[3][8] <= colors[3][7];
        colors[3][9] <= colors[3][8];

        colors[4][0] <= colors[4][9]; //all assign concurrenly
        colors[4][1] <= colors[4][0];
        colors[4][2] <= colors[4][1];
        colors[4][3] <= colors[4][2];
        colors[4][4] <= colors[4][3];
        colors[4][5] <= colors[4][4];
        colors[4][6] <= colors[4][5];
        colors[4][7] <= colors[4][6];
        colors[4][8] <= colors[4][7];
        colors[4][9] <= colors[4][8];

        colors[5][0] <= colors[5][9]; //all assign concurrenly
        colors[5][1] <= colors[5][0];
        colors[5][2] <= colors[5][1];
        colors[5][3] <= colors[5][2];
        colors[5][4] <= colors[5][3];
        colors[5][5] <= colors[5][4];
        colors[5][6] <= colors[5][5];
        colors[5][7] <= colors[5][6];
        colors[5][8] <= colors[5][7];
        colors[5][9] <= colors[5][8];

        colors[6][0] <= colors[6][9]; //all assign concurrenly
        colors[6][1] <= colors[6][0];
        colors[6][2] <= colors[6][1];
        colors[6][3] <= colors[6][2];
        colors[6][4] <= colors[6][3];
        colors[6][5] <= colors[6][4];
        colors[6][6] <= colors[6][5];
        colors[6][7] <= colors[6][6];
        colors[6][8] <= colors[6][7];
        colors[6][9] <= colors[6][8];

        colors[7][0] <= colors[7][9]; //all assign concurrenly
        colors[7][1] <= colors[7][0];
        colors[7][2] <= colors[7][1];
        colors[7][3] <= colors[7][2];
        colors[7][4] <= colors[7][3];
        colors[7][5] <= colors[7][4];
        colors[7][6] <= colors[7][5];
        colors[7][7] <= colors[7][6];
        colors[7][8] <= colors[7][7];
        colors[7][9] <= colors[7][8];
        //$display("cycle.");
    end
        
endmodule
