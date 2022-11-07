//Hayden Prater
//November 2, 2022
//TopLevel

`timescale 1ns/10ps

//------For Visual Studio-------
`include "ALU.v"
`include "dff.v"
`include "tri_state.v"
`include "program_c.v"
//------------------------------

module top_level(clk, rst, bus_in, bus_out, opCode, ALUin1, ALUin2, ALU_outlach, ALU_outEN, 
                G0_in, G0_out, G1_in, G1_out, G2_in, G2_out, PC_EN, P0_in, P0_out, P1_in, P1_out, P0temp, P1tempTB);
    input clk, rst;
    //ALU Control Signals
    input ALUin1, ALUin2, ALU_outlach, ALU_outEN;
    input [2:0] opCode;
    //ALU temps
    input [15:0] temp0, temp1, temp2, temp3;
    //General Registers Control Signals
    input G0_in, G0_out, G1_in, G1_out, G2_in, G2_out, G3_in, G3_out;
    //General Registers temps*
    input [15:0] temp4, temp5, temp6, temp7;
    //Program Counter Control Signal
    input PC_EN;
    //Program Counter Control temps**
    input [15:0] temp8;
    //I/O Port Control Signals
    input P0_in, P0_out, P1_in, P1_out;
    //I/P Port temps***
    input [15:0] P0temp, P1temp, P1tempTB;
    //Buss
    input [15:0] bus_in; 
    output wire[15:0] bus_out; 
    
    //---- Mapping the ports -----
    
    //ALU
    ALU Alu(opCode, temp0, temp3, temp1);
    dff R0(clk, rst, ALUin1, bus_in, temp0);
    dff R1(clk, rst, ALUin2, bus_in, temp3);
    dff R2_out(clk, rst, ALU_outlach, temp1, temp2);
    tri_state t0(ALU_outEN, temp2, bus_out);

    //General Registers*
    //#1
    dff G0(clk, rst, G0_in, bus_in, temp4);
    tri_state t1(G0_out, temp4, bus_out);
    //#2
    dff G1(clk, rst, G1_in, bus_in, temp5);
    tri_state t2(G1_out, temp5, bus_out);
    //#3
    dff G2(clk, rst, G2_in, bus_in, temp6);
    tri_state t3(G2_out, temp6, bus_out);
    //#4
    dff G3(clk, rst, G3_in, bus_in, temp7);
    tri_state t4(G3_out, temp7, bus_out);

    //Program Counter**
    program_c counter(temp8, rst, clk);
    tri_state t5(PC_EN, temp8, bus_out);

    //I/O Ports*** 
    //P0
    dff P0(clk, rst, P0_in, bus_in, P0temp);
    tri_state t6(P0_out, P0temp, bus_out);
    //P1
    dff P1(clk, rst, P1_in, P1tempTB, P1temp);
    tri_state t7(P1_out, P1temp, bus_out);



endmodule 