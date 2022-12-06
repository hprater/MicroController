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
`include "ALUfsm.v"
`include "ALUIfsm.v"
`include "IFfsm.v"
`include "MemLoadStorefsm.v"
`include "MOVfsm.v"
`include "MOVIfsm.v"
//------------------------------

module top_level(clk, rst, P1data_from_TB, P0_data_out, bus);
    //TB in/outs
    input clk, rst;
    input [15:0] P1data_from_TB;
    output wire[15:0] P0_data_out;
    wire MFC;
    inout wire [15:0] bus; //temp inout

    //Data
    wire [15:0] fullBitNum;
    wire [15:0] ALUIfsm_param2num, moviFSM_param2num;

    //FSM Signals
    wire ALUfsm_done, ALUIfsm_done, MLSfsm_done, movFSM_done, moviFSM_done;
    wire PC_Out;
    wire IF_MAR_EN, MLSfsm_MAR_EN;
    wire IF_mem_EN, MLSfsm_mem_EN;
    wire IF_mem_RW, MLSfsm_mem_RW;
    wire IF_MDR_EN_read, MLSfsm_MDR_EN_read;
    wire IF_MDR_out, MLSfsm_MDR_out;
    wire IF_EN;
    wire ALUfsm_ALUin1, ALUIfsm_ALUin1; 
    wire ALUfsm_ALUin2, ALUIfsm_ALUin2; 
    wire ALUfsm_ALU_outlach, ALUIfsm_ALU_outlach; 
    wire ALUfsm_ALU_outEN, ALUIfsm_ALU_outEN;
    wire ALUfsm_PC_inc, ALUIfsm_PC_inc, MLSfsm_PC_inc, movFSM_PC_inc, moviFSM_PC_inc;
    wire ALUfsm_G0_in, ALUfsm_G0_out, ALUfsm_G1_in, ALUfsm_G1_out, ALUfsm_G2_in, ALUfsm_G2_out, ALUfsm_G3_in, ALUfsm_G3_out, 
         ALUfsm_P0_in, ALUfsm_P0_out, ALUfsm_P1_in, ALUfsm_P1_out, ALUIfsm_G0_in, ALUIfsm_G0_out, ALUIfsm_G1_in, ALUIfsm_G1_out, 
         ALUIfsm_G2_in, ALUIfsm_G2_out,ALUIfsm_G3_in, ALUIfsm_G3_out, ALUIfsm_P0_in, ALUIfsm_P0_out, ALUIfsm_P1_in, ALUIfsm_P1_out,
         MLSfsm_G0_in, MLSfsm_G0_out, MLSfsm_G1_in, MLSfsm_G1_out, MLSfsm_G2_in, MLSfsm_G2_out, MLSfsm_G3_in, MLSfsm_G3_out, MLSfsm_P0_in,
         MLSfsm_P0_out, MLSfsm_P1_in, MLSfsm_P1_out, movFSM_G0_in, movFSM_G0_out, movFSM_G1_in, movFSM_G1_out, movFSM_G2_in, movFSM_G2_out,
         movFSM_G3_in, movFSM_G3_out, movFSM_P0_in, movFSM_P0_out, movFSM_P1_in, movFSM_P1_out, moviFSM_G0_in, moviFSM_G1_in, moviFSM_G2_in,
         moviFSM_G3_in, moviFSM_P0_in, moviFSM_P1_in;
    
     
    //Main Signals
    wire IF_active;
    assign done = (ALUfsm_done || ALUIfsm_done || MLSfsm_done || movFSM_done || moviFSM_done);
    assign MAR_EN = (IF_MAR_EN || MLSfsm_MAR_EN);
    assign mem_EN = (IF_mem_EN || MLSfsm_mem_EN);
    assign mem_RW = (IF_mem_RW || MLSfsm_mem_RW);
    assign MDR_EN_read = (IF_MDR_EN_read || MLSfsm_MDR_EN_read);
    assign MDR_out = (IF_MDR_out || MLSfsm_MDR_out);

    assign PC_inc = (ALUfsm_PC_inc || ALUIfsm_PC_inc || MLSfsm_PC_inc || movFSM_PC_inc || moviFSM_PC_inc);
    assign ALUin0 = (ALUfsm_ALUin1 || ALUIfsm_ALUin1);
    assign ALUin1 = (ALUfsm_ALUin2 || ALUIfsm_ALUin2);
    assign ALU_outlach = (ALUfsm_ALU_outlach || ALUIfsm_ALU_outlach);
    assign ALU_outEN = (ALUfsm_ALU_outEN || ALUIfsm_ALU_outEN);
            //General Registers Control Signals
    assign G0_in = (ALUfsm_G0_in || ALUIfsm_G0_in || MLSfsm_G0_in || movFSM_G0_in || moviFSM_G0_in);
    assign G0_out = (ALUfsm_G0_out || ALUIfsm_G0_out || MLSfsm_G0_out || movFSM_G0_out);
    assign G1_in = (ALUfsm_G1_in || ALUIfsm_G1_in || MLSfsm_G1_in || movFSM_G1_in || moviFSM_G1_in);
    assign G1_out = (ALUfsm_G1_out || ALUIfsm_G1_out || MLSfsm_G1_out || movFSM_G1_out);
    assign G2_in = (ALUfsm_G2_in || ALUIfsm_G2_in || MLSfsm_G2_in || movFSM_G2_in || moviFSM_G2_in);
    assign G2_out = (ALUfsm_G2_out || ALUIfsm_G2_out || MLSfsm_G2_out || movFSM_G2_out);
    assign G3_in = (ALUfsm_G3_in || ALUIfsm_G3_in || MLSfsm_G3_in || movFSM_G3_in || moviFSM_G3_in);
    assign G3_out = (ALUfsm_G3_out || ALUIfsm_G3_out || MLSfsm_G3_out || movFSM_G3_out);
    assign P0_in = (ALUfsm_P0_in || ALUIfsm_P0_in || MLSfsm_P0_in || movFSM_P0_in || moviFSM_P0_in);
    assign P0_out = (ALUfsm_P0_out || ALUIfsm_P0_out || MLSfsm_P0_out || movFSM_P0_out);
    assign P1_in = (ALUfsm_P1_in || ALUIfsm_P1_in || MLSfsm_P1_in || movFSM_P1_in || moviFSM_P1_in);
    assign P1_out = (ALUfsm_P1_out || ALUIfsm_P1_out || MLSfsm_P1_out || movFSM_P1_out);


    //FSM's
    IFfsm IF(clk, rst, done, MFC, PC_Out, IF_MAR_EN, IF_mem_EN, IF_mem_RW, IF_MDR_EN_read, IF_MDR_out, IF_EN, IF_active);

    ALUfsm aluFSM(clk, rst, fullBitNum, ALUfsm_PC_inc, ALUfsm_ALUin1, ALUfsm_ALUin2, ALUfsm_ALU_outlach, ALUfsm_ALU_outEN, ALUfsm_done,
                ALUfsm_G0_in, ALUfsm_G0_out, ALUfsm_G1_in, ALUfsm_G1_out, ALUfsm_G2_in, ALUfsm_G2_out, ALUfsm_G3_in, ALUfsm_G3_out, 
                ALUfsm_P0_in, ALUfsm_P0_out, ALUfsm_P1_in, ALUfsm_P1_out, IF_active);
            
    ALUIfsm aluiFSM(clk, rst, fullBitNum, ALUIfsm_PC_inc, ALUIfsm_ALUin1, ALUIfsm_ALUin2, ALUIfsm_ALU_outlach, ALUIfsm_ALU_outEN, ALUIfsm_done,
                immediate_out_Alui, ALUIfsm_param2num, ALUIfsm_G0_in, ALUIfsm_G0_out, ALUIfsm_G1_in, ALUIfsm_G1_out, ALUIfsm_G2_in, ALUIfsm_G2_out,
                ALUIfsm_G3_in, ALUIfsm_G3_out, ALUIfsm_P0_in, ALUIfsm_P0_out, ALUIfsm_P1_in, ALUIfsm_P1_out, IF_active);

    MemLoadStorefsm MLSfsm(clk, rst, fullBitNum, MFC, MLSfsm_PC_inc, MLSfsm_MAR_EN, MLSfsm_mem_EN, MLSfsm_mem_RW, MLSfsm_MDR_EN_read, MLSfsm_MDR_out, 
                MDR_EN_write, MLSfsm_done, MLSfsm_G0_in,  MLSfsm_G0_out, MLSfsm_G1_in, MLSfsm_G1_out, MLSfsm_G2_in, MLSfsm_G2_out, MLSfsm_G3_in, MLSfsm_G3_out,
                MLSfsm_P0_in, MLSfsm_P0_out, MLSfsm_P1_in, MLSfsm_P1_out, IF_active);

    MOVfsm movFSM(clk, rst, fullBitNum, movFSM_PC_inc, movFSM_done, movFSM_G0_in, movFSM_G0_out, movFSM_G1_in, movFSM_G1_out,
                 movFSM_G2_in, movFSM_G2_out, movFSM_G3_in, movFSM_G3_out, movFSM_P0_in, movFSM_P0_out, movFSM_P1_in, movFSM_P1_out, IF_active);

    MOVIfsm moviFSM(clk, rst, fullBitNum, moviFSM_PC_inc, moviFSM_done, immediate_out_Movi, moviFSM_param2num, 
                    moviFSM_G0_in, moviFSM_G1_in, moviFSM_G2_in, moviFSM_G3_in, moviFSM_P0_in, moviFSM_P1_in, IF_active);

            

    //ALU
    wire [15:0] ALU_data_out, ALUdata0, ALUdata1, ALU_latch_data;

    //General Registers
    wire [15:0] G0_data_out, G1_data_out, G2_data_out, G3_data_out;

    //Program Counter
    wire [15:0] PC_data_out;
    
    //I/O Port 
    wire [15:0] P1_data_out;
    
    //MAR/MDR 
    wire [15:0] memAddr, mem_dataIn, mem_dataOut, mem_latch_data;
    
    //----- Mapping the ports -----
    
    //--- ALU ---
    dff R0(clk, rst, ALUin0, bus, ALUdata0);
    dff R1(clk, rst, ALUin1, bus, ALUdata1);
    ALU Alu(fullBitNum[14:12], ALUdata0, ALUdata1, ALU_latch_data);
    dff R2_out(clk, rst, ALU_outlach, ALU_latch_data, ALU_data_out);
    tri_state t0(ALU_outEN, ALU_data_out, bus);

    //--- General Registers* ---
    //#1
    dff G0(clk, rst, G0_in, bus, G0_data_out);
    tri_state t1(G0_out, G0_data_out, bus);
    //#2
    dff G1(clk, rst, G1_in, bus, G1_data_out);
    tri_state t2(G1_out, G1_data_out, bus);
    //#3
    dff G2(clk, rst, G2_in, bus, G2_data_out);
    tri_state t3(G2_out, G2_data_out, bus);
    //#4
    dff G3(clk, rst, G3_in, bus, G3_data_out);
    tri_state t4(G3_out, G3_data_out, bus);

    //--- Program Counter** ---
    program_c counter(clk, PC_data_out, rst, PC_inc);
    tri_state t5(PC_Out, PC_data_out, bus);

    //--- I/O Ports*** ---
    //P0
    dff P0(clk, rst, P0_in, bus, P0_data_out);
    tri_state t6(P0_out, P0_data_out, bus);
    //P1
    dff P1(clk, rst, P1_in, P1data_from_TB, P1_data_out); 
    tri_state t7(P1_out, P1_data_out, bus);

    //Memory
    memory mem(mem_EN, MFC, memAddr, mem_RW, mem_dataIn, mem_latch_data);
    //--- MAR ---
    dff MAR(clk, rst, MAR_EN, bus, memAddr);
    //--- MDR ---
    dff MDR_write(clk, rst, MDR_EN_write, bus, mem_dataIn);
    dff MDR_read(clk, rst, MDR_EN_read, mem_latch_data, mem_dataOut);
    tri_state t8(MDR_out, mem_dataOut, bus);

    //Instruction Register
    dff IR (clk, rst, IF_EN, bus, fullBitNum);

    //Tri-states for Immideate;
    tri_state ALUInum(immediate_out_Alui, ALUIfsm_param2num, bus);

    tri_state MOVInum(immediate_out_Movi, moviFSM_param2num, bus);

endmodule 