`include "MOVfsm.v"
`timescale 1ns/10ps

module MovTB;
reg clk, rst;
reg [15:0] fullBitNum;

wire PC_inc, done, G0_in, G0_out, G1_in, G1_out, G2_in, G2_out, G3_in, G3_out, P0_in, P0_out, P1_in, P1_out; 

MOVfsm fsm(clk, rst, fullBitNum, PC_inc, done, G0_in, G0_out, G1_in, G1_out, G2_in, G2_out, G3_in, G3_out, P0_in, P0_out, P1_in, P1_out);

initial begin
    $dumpfile("MOVfsm.vcd");
    $dumpvars(0, MovTB);

    clk = 0;
    rst = 0;
    fullBitNum = 16'b0110000000000010;

    rst = 1; 
    #2 rst = 0;
end

always #10 clk =~ clk;
    
endmodule