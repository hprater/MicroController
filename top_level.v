//Hayden Prater
//November 2, 2022
//TopLevel

`timescale 1ns/10ps

//------For Visual Studio-------
`include "ALU.v"
`include "dff.v"
`include "tri_state.v"
//------------------------------

module top_level(clk, rst, bus, R0out, R1out, R0in, R1in, tem0, tem1);
    input clk, rst;
    output wire[3:0] bus; 
    input R0in, R1in, R0out, R1out;
    input [3:0] tem0; //Houses output of R0-Dff
    input [3:0] tem1; //Houses output of R1-Dff
    

    //Mapping the ports
    dff R0(clk, rst, R0in, bus, tem0);
    dff R1(clk, rst, R1in, bus, tem1);
    tri_state t0(R0out, tem0, bus);
    tri_state t1(R1out, tem1, bus);

endmodule 