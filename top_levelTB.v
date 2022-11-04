//Hayden Prater
//November 2, 2022
//Testbench
`timescale 1ns/10ps

//------For Visual Studio-------
`include "top_level.v"
//------------------------------

module top_levelTB;

reg clk, rst;
reg ALUin1, ALUin2, ALU_outlach, ALU_outEN;
reg [2:0] opCode;
reg [15:0] bus_in;
wire [15:0] bus_out;

top_level test(clk, rst, bus_in, bus_out, opCode, ALUin1, ALUin2, ALU_outlach, ALU_outEN);

initial 
begin

//------For Visual Studio-------
$dumpfile("ALU.vcd");
$dumpvars(0, top_levelTB);
//------------------------------

    clk = 0;
    ALUin1 = 0; 
    ALUin2 = 0;
    ALU_outlach = 0;
    ALU_outEN = 0;
    opCode = 3'b000;
    bus_in = 16'bzzzzzzzzzzzzzzzz;
    rst = 0;
    #2
    rst = 1;
    #2
    rst = 0;
    #2
    opCode = 3'b101;
    bus_in = 16'b0000000000000010;
    #3
    ALUin1 = 1;
    #2
    ALUin1 = 0;
    #5
    bus_in = 16'b0000000000000001;
    #13
    ALUin2 = 1;
    #2 
    ALUin2 = 0;
    #18
    ALU_outlach = 1;
    #2
    ALU_outlach = 0;
    #2
    ALU_outEN = 1;
    #4
    ALU_outEN = 0;

end
always #10 clk = ~ clk;
endmodule