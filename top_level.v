//Hayden Prater
//November 2, 2022
//TopLevel

`timescale 1ns/10ps

//------For Visual Studio-------
`include "ALU.v"
`include "dff.v"
`include "tri_state.v"
//------------------------------

module top_level(clk, rst, bus_in, bus_out, opCode, ALUin1, ALUin2, ALU_outlach, ALU_outEN);
    input clk, rst, ALUin1, ALUin2, ALU_outlach, ALU_outEN;
    input [2:0] opCode;
    input [15:0] temp0; //Houses output of R0
    input [15:0] temp1; //Houses output of ALU
    input [15:0] temp2; //Houses output of R2-Dff
    input [15:0] temp3; //Houses output of R1-DFF
    //will be a one 16 bit bus for final project, split for testing.
    input [15:0] bus_in; 
    output wire[15:0] bus_out; 
    

    //Mapping the ports
    ALU Alu(opCode, temp0, temp3, temp1);

    dff R0(clk, rst, ALUin1, bus_in, temp0);
    dff R1(clk, rst, ALUin2, bus_in, temp3);
    dff R2_out(clk, rst, ALU_outlach, temp1, temp2);

    tri_state t0(ALU_outEN, temp2, bus_out);


endmodule 