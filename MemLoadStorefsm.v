//Hayden Prater
//November 21, 2022
//Memory Load/Store
`timescale 1ns/10ps

module MemLoadStorefsm (clk, rst, fullBitNum, MFC, PC_inc, MAR_EN, mem_EN, mem_RW, MDR_EN_read, MDR_out, MDR_EN_write, done, param2num, Load_out_addr,
                    G0_in, G0_out, G1_in, G1_out, G2_in, G2_out, G3_in, G3_out, P0_in, P0_out, P1_in, P1_out, IF_active);
input clk, rst, MFC, IF_active;
input [15:0] fullBitNum;
output reg G0_in, G0_out, G1_in, G1_out, G2_in, G2_out, G3_in, G3_out, P0_in, P0_out, P1_in, P1_out;
output reg PC_inc, MAR_EN, mem_EN, mem_RW, MDR_EN_read, MDR_out, MDR_EN_write, done, Load_out_addr;
reg [3:0] pres_state, next_state;
    parameter st0 = 4'b0000, st1 = 4'b0001, st2 = 4'b0010, st3 = 4'b0011, st4 = 4'b0100,
              st5 = 4'b0101, st6 = 4'b0110, st7 = 4'b0111, st8 = 4'b1000, st9 = 4'b1001,
              st10 = 4'b1010, st11 = 4'b1011, st12 = 4'b1100, st13 = 4'b1101, st14 = 4'b1110, st15 = 4'b1111;

wire [3:0]opCode = fullBitNum[15:12];
wire [5:0]param1 = fullBitNum[11:6]; 
wire [5:0]param2 = fullBitNum[5:0];
output reg[15:0] param2num;

always @(posedge clk or posedge rst) 
    begin
        if (rst)
            pres_state <= st0;
        else if (IF_active)
            pres_state <= st0;
        else if (opCode == 4'b0100 || opCode == 4'b0011)
            pres_state <= next_state;
        else 
            pres_state <= st0;
    end

 always @(pres_state or MFC or opCode) 
    begin
        case (pres_state)
           //Choose Load or Store
           st0 : case(opCode)
           4'b0011: next_state <= st1;
           4'b0100: next_state <= st9;
           default: next_state <= st0;
           endcase

           //Store Steps 
           st1 : next_state <= st2;
           st2 : next_state <= st3;
           st3 : next_state <= st4;
           st4 : next_state <= st5;
           st5 : next_state <= st6;
           st6 : case(MFC)              //MFC == 1 to move to next state
           1'b0: next_state <= st6;
           1'b1: next_state <= st7;     //Done
           default: next_state <= st6;
           endcase

           st7 : next_state <= st8;     //setting Done to 0 for both operations
           st8 : next_state <= st8;     //keeping Done to 0 for both operations

           //Load Steps
           st9 : next_state <= st10;
           st10: next_state <= st11;
           st11: next_state <= st12;
           st12: case(MFC)              //MFC == 1 to move to next state
           1'b0: next_state <= st12;
           1'b1: next_state <= st13;     
           default: next_state <= st12;
           endcase
           st13: next_state <= st14;
           st14: next_state <= st15;
           st15: next_state <= st7;     //Done

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
            param2num <= 16'b0000000000000000;
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0; P1_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            Load_out_addr <= 0;
            end
 //---------------------------st1-----------------------------
        st1: 
            begin
            PC_inc <= 1;
            //Gxout
            case(param2)
            6'b000000: begin
                G0_out <= 1; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
                end
            6'b000001: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 1; P1_out <= 0;
                end
            6'b000010: begin 
                G0_out <= 0; G1_out <= 1; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
                end
            6'b000011: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 1; G3_out <= 0; P0_out <= 0; P1_out <= 0;
                end
            6'b000100: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 1; P0_out <= 0; P1_out <= 0;
                end
            6'b000101: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 1;
                end
            endcase
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0; P1_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            Load_out_addr <= 0;
            end
 //---------------------------st2-----------------------------
        st2: 
            begin
            PC_inc <= 0;
            //Gxout
            case(param2)
            6'b000000: begin
                G0_out <= 1; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
                end
            6'b000001: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 1; P1_out <= 0;
                end
            6'b000010: begin 
                G0_out <= 0; G1_out <= 1; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
                end
            6'b000011: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 1; G3_out <= 0; P0_out <= 0; P1_out <= 0;
                end
            6'b000100: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 1; P0_out <= 0; P1_out <= 0;
                end
            6'b000101: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 1;
                end
            endcase
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0; P1_in <= 0;
            MAR_EN <= 1;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            Load_out_addr <= 0;
            end
 //---------------------------st3-----------------------------
        st3: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0; P1_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            Load_out_addr <= 0;
            end  
//---------------------------st4-----------------------------
        st4: 
            begin
            PC_inc <= 0;
            //Gxout
            case(param1)
            6'b000000: begin
                G0_out <= 1; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
                end
            6'b000001: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 1; P1_out <= 0;
                end
            6'b000010: begin 
                G0_out <= 0; G1_out <= 1; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
                end
            6'b000011: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 1; G3_out <= 0; P0_out <= 0; P1_out <= 0;
                end
            6'b000100: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 1; P0_out <= 0; P1_out <= 0;
                end
            6'b000101: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 1;
                end
            endcase
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0; P1_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            Load_out_addr <= 0;
            end   
//---------------------------st5-----------------------------
        st5: 
            begin
            PC_inc <= 0;
            //Gxout
            case(param1)
            6'b000000: begin
                G0_out <= 1; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
                end
            6'b000001: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 1; P1_out <= 0;
                end
            6'b000010: begin 
                G0_out <= 0; G1_out <= 1; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
                end
            6'b000011: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 1; G3_out <= 0; P0_out <= 0; P1_out <= 0;
                end
            6'b000100: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 1; P0_out <= 0; P1_out <= 0;
                end
            6'b000101: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 1;
                end
            endcase
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0; P1_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 1;
            done <= 0;
            Load_out_addr <= 0;
            end 
//---------------------------st6-----------------------------
//MFC == 1 to move to next state
        st6: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0; P1_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 1;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            Load_out_addr <= 0;
            end
//---------------------------st7-----------------------------
        st7: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0; P1_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 1;
            Load_out_addr <= 0;
            end  
//---------------------------st8 - Setting done to 0----------
        st8: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0; P1_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            Load_out_addr <= 0;
            end
//---------------------------st9----------------------------- // Load
        st9: 
            begin
            PC_inc <= 0;
            param2num <= {16'b0011111111111111};
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0; P1_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            Load_out_addr <= 1;
            end
//---------------------------st10----------------------------- //
        st10: 
            begin
            PC_inc <= 0;
            param2num <= {16'b0011111111111111};
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0; P1_in <= 0;
            MAR_EN <= 1;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            Load_out_addr <= 1;
            end
//---------------------------st11----------------------------- //
        st11: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0; P1_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 1;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            Load_out_addr <= 0;
            end
//---------------------------st12----------------------------- //
//MFC == 1 to move to next state
        st12: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0; P1_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 1;
            mem_RW <= 1;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            Load_out_addr <= 0;
            end
            
//---------------------------st13-----------------------------
        st13: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0; P1_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 1;
            mem_RW <= 1;
            MDR_EN_read <= 1;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            Load_out_addr <= 0;
            end
//---------------------------st14-----------------------------
        st14: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0; P1_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 1;
            MDR_EN_write <= 0;
            done <= 0;
            Load_out_addr <= 0;
            end   
//---------------------------st15-----------------------------
        st15: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
            //Gxin
            case(param1)
            6'b000000: begin
                G0_in <= 1; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0; P1_in <= 0;
                end
            6'b000001: begin
                G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 1; P1_in <= 0;
                end
            6'b000010: begin 
                G0_in <= 0; G1_in <= 1; G2_in <= 0; G3_in <= 0; P0_in <= 0; P1_in <= 0;
                end
            6'b000011: begin
                G0_in <= 0; G1_in <= 0; G2_in <= 1; G3_in <= 0; P0_in <= 0; P1_in <= 0;
                end
            6'b000100: begin
                G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 1; P0_in <= 0; P1_in <= 0;
            end
            6'b000101: begin
                G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0; P1_in <= 1;
            end
            endcase
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 1;
            MDR_EN_write <= 0;
            done <= 0;
            Load_out_addr <= 0;
            end                                                                                                                       
//------------------------default-----------------------------
        default: 
        begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0; P0_out <= 0; P1_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0; P0_in <= 0; P1_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            Load_out_addr <= 0;
            end
        endcase
    end
endmodule