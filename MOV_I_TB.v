`include "MOVIfsm.v"
`timescale 1ns/10ps

module Mov_I_TB;
reg clk, rst;
reg [15:0] fullBitNum;


wire PC_inc, done, immediate_out_Movi, G0_in, G1_in, G2_in, G3_in, P0_in, P1_in; 
wire [15:0] param2num;

MOVIfsm fsm(clk, rst, fullBitNum, PC_inc, done, immediate_out_Movi, param2num, 
                    G0_in, G1_in, G2_in, G3_in, P0_in, P1_in);

initial begin
    $dumpfile("MOVIfsm.vcd");
    $dumpvars(0, Mov_I_TB);

    clk = 0;
    rst = 0;
    fullBitNum = 16'b0111000000000010;

    rst = 1; 
    #2 rst = 0;
end

always #10 clk =~ clk;
    
endmodule