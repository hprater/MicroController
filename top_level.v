//Hayden Prater
//November 2, 2022
//TopLevel

`timescale 1ns/10ps

//------For Visual Studio-------
`include "ALU.v"
`include "dff.v"
`include "tri_state.v"
`include "program_c.v"
`include "memory.v"
//------------------------------

module top_level(clk, rst, bus_in, bus_out, opCode, ALUin1, ALUin2, ALU_outlach, ALU_outEN, 
                G0_in, G0_out, G1_in, G1_out, G2_in, G2_out, PC_Out, PC_inc, P0_in, P0_out, P1_in, P1_out, P0temp, P1tempTB, 
                mem_RW, mem_EN, MAR_EN, MDR_EN_write, MDR_EN_read, MDR_out);
                
    input clk, rst;
    //ALU Control Signals
    input ALUin1, ALUin2, ALU_outlach, ALU_outEN;
    input [2:0] opCode;
    //ALU temps
    wire [15:0] temp0, temp1, temp2, temp3;
    //General Registers Control Signals
    input G0_in, G0_out, G1_in, G1_out, G2_in, G2_out, G3_in, G3_out;
    //General Registers temps*
    wire [15:0] temp4, temp5, temp6, temp7;
    //Program Counter Control Signal
    input PC_Out, PC_inc;
    //Program Counter Control temps**
    wire [15:0] temp8;
    //I/O Port Control Signals
    input P0_in, P0_out, P1_in, P1_out;
    //I/O Port temps***
    input [15:0] P0temp, P1tempTB;
    wire [15:0] P1temp;
    //Memory
    input mem_RW, mem_EN;
    output MFC;
    //MAR/MDR Control Signals
    input MAR_EN, MDR_EN_write, MDR_EN_read, MDR_out;
    //MAR/MDR temp
    wire [15:0] temp9, temp10, temp11, temp12;
    //Instruction Reg Control Signal
    input IR_EN;
    wire [15:0]IR_fullBitInstruct;
    //Buss
    input [15:0] bus_in; 
    output wire[15:0] bus_out; 
    
    //----- Mapping the ports -----
    
    //--- ALU ---
    ALU Alu(IR_fullBitInstruct[14:12], temp0, temp3, temp1);
    dff R0(clk, rst, ALUin1, bus_in, temp0);
    dff R1(clk, rst, ALUin2, bus_in, temp3);
    dff R2_out(clk, rst, ALU_outlach, temp1, temp2);
    tri_state t0(ALU_outEN, temp2, bus_out);

    //--- General Registers* ---
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

    //--- Program Counter** ---
    program_c counter(temp8, rst, PC_inc);
    tri_state t5(PC_Out, temp8, bus_out);

    //--- I/O Ports*** ---
    //P0
    dff P0(clk, rst, P0_in, bus_in, P0temp);
    tri_state t6(P0_out, P0temp, bus_out);
    //P1
    dff P1(clk, rst, P1_in, P1tempTB, P1temp);
    tri_state t7(P1_out, P1temp, bus_out);

    //Memory
    memory mem(mem_EN, MFC, temp9, mem_RW, temp10, temp11);
    //--- MAR ---
    dff MAR(clk, rst, MAR_EN, bus_in, temp9);
    //--- MDR ---
    dff MDR_write(clk, rst, MDR_EN_write, bus_in, temp10);
    dff MDR_read(clk, rst, MDR_EN_read, temp11, temp12);
    tri_state t8(MDR_out, temp12, bus_out);

    //Instruction Register
    dff IR (clk, rst, IR_EN, bus_in, IR_fullBitInstruct); 



endmodule 