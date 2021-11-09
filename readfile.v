module test (
    
);
    reg [3:0] in;
    reg [3:0] out;
    integer inFile;
    integer outFile;

    initial begin
        inFile = $fopen("samplein.txt", "r");
        outFile = $fopen("sampleout.txt", "w");

        while (!$feof(inFile) && $fscanf(inFile, "%b\n",in)) begin
            out = in + 1;
            $display(in);
            $fdisplay(outFile,"%d",out); //write as decimal
            $fdisplay(outFile,"%b",out); //write as binary
        end
        $fclose(inFile);
        $fclose(outFile);
        $finish;
    end

endmodule