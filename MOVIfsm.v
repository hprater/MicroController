//Hayden Prater
//November 21, 2022
//MOVI
`timescale 1ns/10ps

module MOVIfsm (clk, rst, fullBitNum, PC_inc, done, immediate_out_Movi, param2num, 
                    G0_in, G1_in, G2_in, G3_in, P0_in);

input clk, rst;
input [15:0] fullBitNum;
output reg G0_in, G1_in, G2_in, G3_in, P0_in;
output reg PC_inc, done, immediate_out_Movi;
reg [2:0] pres_state, next_state;
    parameter st0 = 3'b000, st1 = 3'b001, st2 = 3'b010, st3 = 3'b011, st4 = 3'b100, st5 = 3'b101;

wire [3:0]opCode = fullBitNum[15:12];
wire [5:0]param1 = fullBitNum[11:6]; 
wire [5:0]param2 = fullBitNum[5:0];
output reg[15:0] param2num;

always @(posedge clk or posedge rst) 
    begin
        if (rst)
            pres_state <= st0;
        else if (opCode == 4'b0111)
            pres_state <= next_state;
        else 
            pres_state <= st0;
    end    

always @(pres_state) 
    begin
        case (pres_state)
           st0 : next_state <= st1;
           st1 : next_state <= st2;
           st2 : next_state <= st3;
           st3 : next_state <= st4;
           st4 : next_state <= st5;
           st5 : next_state <= st5;
        default: next_state <= st0;
        endcase
    end

 always @(pres_state) 
    begin
        case (pres_state)
//---------------------------st0-----------------------------
        st0: 
            begin
            PC_inc <= 0;
            immediate_out_Movi <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0;
            done <= 0;
            end
//---------------------------st1-----------------------------
        st1: 
            begin
            PC_inc <= 1;
            immediate_out_Movi <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0;
            done <= 0;
            end
//---------------------------st2-----------------------------
        st2: 
            begin
            PC_inc <= 0;
            //Immediate Number to bus
            param2num <= param2;
            immediate_out_Movi <= 1;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0;
            done <= 0;
            end  
//---------------------------st3-----------------------------
        st3: 
            begin
            PC_inc <= 0;
            //Immediate Number to bus
            param2num <= param2;
            immediate_out_Movi <= 1;
            //Gxin
            case(param1)
            6'b000000: begin
                G0_in <= 1; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0;
                end
            6'b000001: begin
                G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 1;
                end
            6'b000010: begin 
                G0_in <= 0; G1_in <= 1; G2_in <= 0; G3_in <= 0; P0_in <= 0;
                end
            6'b000011: begin
                G0_in <= 0; G1_in <= 0; G2_in <= 1; G3_in <= 0; P0_in <= 0;
                end
            6'b000100: begin
                G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 1; P0_in <= 0;
            end
            endcase
            done <= 1;
            end
//---------------------------st4-----------------------------
        st4: 
            begin
            PC_inc <= 0;
            immediate_out_Movi <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0;
            done <= 1;
            end 
//---------------------------st5-----------------------------
        st5: 
            begin
            PC_inc <= 0;
            immediate_out_Movi <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0;
            done <= 0;
            end                       
//------------------------default-----------------------------
        default: 
            begin
            PC_inc <= 0;
            immediate_out_Movi <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0;
            done <= 0;
            end
        endcase
    end
endmodule