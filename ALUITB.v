`include "ALUIfsm.v"
`timescale 1ns/10ps

module ALUITB;
reg clk, rst;
reg [15:0] fullBitNum;

wire [15:0] param2num;
wire PC_inc, ALUin1, ALUin2, ALU_outlach, ALU_outEN, done, immediate_out,
        G0_in, G0_out, G1_in, G1_out, G2_in, G2_out, G3_in, G3_out; 

ALUIfsm fsm(clk, rst, fullBitNum, PC_inc, ALUin1, ALUin2, ALU_outlach, ALU_outEN, done, immediate_out, param2num,
                G0_in, G0_out, G1_in, G1_out, G2_in, G2_out, G3_in, G3_out);

initial begin
    $dumpfile("ALUIfsm.vcd");
    $dumpvars(0, ALUITB);

    clk = 0;
    rst = 0;
    fullBitNum = 16'b0001000000000010;

    rst = 1; 
    #2 rst = 0;
end

always #10 clk =~ clk;
    
endmodule