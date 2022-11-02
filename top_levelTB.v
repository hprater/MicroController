//Hayden Prater
//November 2, 2022
//Testbench
`timescale 1ns/10ps

module top_levelTB;

reg clk, rst;
reg R0in, R0out, R1in, R1out;
wire[3:0] bus;

top_level test(clk, rst, bus, R0out, R1out, R0in, R1in);

initial 
begin

    clk = 0;
    R0in = 0; 
    R0out = 0;
    R1in = 0;
    R1out = 0;
    rst = 0;
    #2
    rst = 1;
    #2
    rst = 0;
    #2
    R0out = 1;
    R1in = 1;
    #9
    R0out = 0;
    R1in = 0;
    #11
    R1out = 1;
    R0in = 1;
    #9
    R1out = 0;
    R0in = 0;
end
always #10 clk = ~ clk;
endmodule