//Hayden Prater
//November 21, 2022
//MOV 
`timescale 1ns/10ps

module MOVfsm (clk, rst, fullBitNum, PC_inc, done, G0_in, G0_out, G1_in, G1_out, G2_in, G2_out, G3_in, G3_out, P0_in, P0_out);
input clk, rst;
input [15:0] fullBitNum;
output reg G0_in, G0_out, G1_in, G1_out, G2_in, G2_out, G3_in, G3_out, P0_in, P0_out;
output reg PC_inc, done;
reg [2:0] pres_state, next_state;
    parameter st0 = 3'b000, st1 = 3'b001, st2 = 3'b010, st3 = 3'b011, st4 = 3'b100;

wire [3:0]opCode = fullBitNum[15:12];
wire [5:0]param1 = fullBitNum[11:6]; 
wire [5:0]param2 = fullBitNum[5:0];

always @(posedge clk or posedge rst) 
    begin
        if (rst)
            pres_state <= st0;
        else if (opCode == 4'b0110)
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
           st4 : next_state <= st4;
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
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0;
            done <= 0;
            end
//---------------------------st1-----------------------------
        st1: 
            begin
            PC_inc <= 1;
            //Gxout
            case(param2)
            6'b000000: begin
                G0_out <= 1; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0;
                end
            6'b000001: begin
                G0_out <= 1; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 1;
                end
            6'b000010: begin 
                G0_out <= 0; G1_out <= 1; G2_out <= 0; G3_out <= 0; P0_out <= 0;
                end
            6'b000011: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 1; G3_out <= 0; P0_out <= 0;
                end
            6'b000100: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 1; P0_out <= 0;
            end
            endcase
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0;
            done <= 0;
            end
//---------------------------st2-----------------------------
        st2: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0;
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
            done <= 0;
            end  
//---------------------------st3-----------------------------
        st3: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0;
            done <= 1;
            end
//---------------------------st4-----------------------------
        st4: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0;
            done <= 0;
            end          
//------------------------default-----------------------------
        default: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0;
            done <= 0;
            end
        endcase
    end
endmodule