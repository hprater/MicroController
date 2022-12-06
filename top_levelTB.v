//Hayden Prater
//November 2, 2022
//Testbench
`timescale 1ns/10ps

//------For Visual Studio-------
`include "top_level.v"
//------------------------------

module top_levelTB;

reg clk, rst;
reg[15:0] P1data_from_TB;
wire [15:0] P0_data_out, bus;


top_level test(clk, rst, P1data_from_TB, P0_data_out, bus);

initial 
begin

//------For Visual Studio-------
$dumpfile("top_level.vcd");
$dumpvars(0, top_levelTB);
//------------------------------

clk = 0;
rst= 0;
P1data_from_TB = 16'b1111000011110000;
#1 rst = 1;
#5 rst = 0;   
end

always #10 clk = ~ clk;
endmodule