`include "IFfsm.v"
`include "program_c.v"
`timescale 1ns/10ps

module IF_TB;
reg clk, rst, MFC, done, increment;
wire [15:0] count;

wire PC_Out, MAR_EN, mem_EN, mem_RW, MDR_EN_read, MDR_out, IR_EN; 

IFfsm fsm(clk, rst, done, MFC, PC_Out, MAR_EN, mem_EN, mem_RW, MDR_EN_read, MDR_out, IR_EN);
program_c PC(clk, count, rst, increment);

initial begin
    $dumpfile("IFfsm.vcd");
    $dumpvars(0, IF_TB);

    clk = 0;
    rst = 0;
    MFC = 0;
    increment = 0;
    done = 0;

    rst = 1;
    #1 rst = 0;

    #1done = 1;
    #2 done = 0;

    #60 MFC = 1;
    #10 MFC = 0;

end

always #10 clk =~ clk;
    
endmodule