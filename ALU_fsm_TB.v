`include "ALUfsm.v"
`timescale 1ns/10ps

module ALU_fsm_TB;
reg clk, rst;
reg [15:0] fullBitNum;

wire [15:0] param2num;
wire PC_inc, ALUin1, ALUin2, ALU_outlach, ALU_outEN, done,
    G0_in, G0_out, G1_in, G1_out, G2_in, G2_out, G3_in, G3_out, P0_in, P0_out; 

ALUfsm fsm(clk, rst, fullBitNum, PC_inc, ALUin1, ALUin2, ALU_outlach, ALU_outEN, done,
                G0_in, G0_out, G1_in, G1_out, G2_in, G2_out, G3_in, G3_out, P0_in, P0_out);

initial begin
    $dumpfile("ALUfsm.vcd");
    $dumpvars(0, ALU_fsm_TB);

    clk = 0;
    rst = 0;
    fullBitNum = 16'b1001000000000010;

    rst = 1; 
    #2 rst = 0;
end

always #10 clk =~ clk;
    
endmodule