`include "MemLoadStorefsm.v"
`timescale 1ns/10ps

module MemTB;
reg clk, rst, MFC;
reg [15:0] fullBitNum;

wire [15:0] param2num;
wire PC_inc, MAR_EN, mem_EN, mem_RW, MDR_EN_read, MDR_out, MDR_EN_write, done,
                    G0_in, G0_out, G1_in, G1_out, G2_in, G2_out, G3_in, G3_out, P0_in, P0_out; 

MemLoadStorefsm fsm(clk, rst, fullBitNum, MFC, PC_inc, MAR_EN, mem_EN, mem_RW, MDR_EN_read, MDR_out, MDR_EN_write, done,
                    G0_in, G0_out, G1_in, G1_out, G2_in, G2_out, G3_in, G3_out, P0_in, P0_out);

initial begin
    $dumpfile("MemLoadStorefsm.vcd");
    $dumpvars(0, MemTB);

    clk = 0;
    rst = 0;
    fullBitNum = 16'b0100000010000001; //Load (R1), P0

    rst = 1; 
    #2 rst = 0;
    #35 MFC = 1;
    #15 MFC = 0;
end

always #10 clk =~ clk;
    
endmodule