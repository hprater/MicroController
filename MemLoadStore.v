//Hayden Prater
//November 21, 2022
//Memory Load/Store

module MemLoadStore (clk, rst, fullBitNum, PC_inc, MAR_EN, mem_EN, mem_RW, MDR_EN_read, MDR_out, MDR_EN_write, done,
                    G0_in, G0_out, G1_in, G1_out, G2_in, G2_out, G3_in, G3_out);
input clk, rst;
input [15:0] fullBitNum;
output reg G0_in, G0_out, G1_in, G1_out, G2_in, G2_out, G3_in, G3_out;
output reg PC_inc, MAR_EN, mem_EN, mem_RW, MDR_EN_read, MDR_out, MDR_EN_write, done;
reg [3:0] pres_state, next_state;
    parameter st0 = 4'b0000, st1 = 4'b0001, st2 = 4'b0010, st3 = 4'b0011, st4 = 4'b0100,
              st5 = 4'b0101, st6 = 4'b0110, st7 = 4'b0111, st8 = 4'b1000, st9 = 4'b1001,
              st10 = 4'b1010, st11 = 4'b1011, st12 = 4'b1100;

wire [3:0]opCode = fullBitNum[15:12];
wire [5:0]param1 = fullBitNum[11:6]; 
wire [5:0]param2 = fullBitNum[5:0];

always @(posedge clk or posedge rst) 
    begin
        if (rst)
            pres_state <= st0;
        else if (opCode == 4'b0100 || opCode == 4'b0011)
            pres_state <= next_state;
        else 
            pres_state <= st0;
    end

 always @(pres_state) 
    begin
        case (pres_state)
           st0 : next_state <= st1;
           st1 : next_state <= st2;

           //Choose Load or Store
           st2 : case(opCode)
           4'b0100: next_state <= st3;
           4'b0011: next_state <= st9;
           default: next_state <= st2;
           endcase

           //Store Steps 
           st3 : next_state <= st4;
           st4 : next_state <= st5;
           st5 : next_state <= st6;
           st6 : next_state <= st7;
           st7 : next_state <= st8; 

           st8 : next_state <= st8; //setting all signals back to 0 ** NEED THIS FOR ALL??

           //Load Steps
           st9 : next_state <= st10;
           st10: next_state <= st11;
           st11: next_state <= st12;
           st12: next_state <= st7; 

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
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            end
 //---------------------------st1-----------------------------
        st1: 
            begin
            PC_inc <= 1;
            //Gxout
            case(param1)
            6'b000000: begin
                G0_out <= 1; G1_out <= 0; G2_out <= 0; G3_out <= 0;
                end
            6'b000010: begin 
                G0_out <= 0; G1_out <= 1; G2_out <= 0; G3_out <= 0;
                end
            6'b000011: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 1; G3_out <= 0;
                end
            6'b000100: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 1;
            end
            endcase
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            end
 //---------------------------st2-----------------------------
        st2: 
            begin
            PC_inc <= 0;
            //Gxout
            case(param1)
            6'b000000: begin
                G0_out <= 1; G1_out <= 0; G2_out <= 0; G3_out <= 0;
                end
            6'b000010: begin 
                G0_out <= 0; G1_out <= 1; G2_out <= 0; G3_out <= 0;
                end
            6'b000011: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 1; G3_out <= 0;
                end
            6'b000100: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 1;
            end
            endcase
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            MAR_EN <= 1;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            end
 //---------------------------st3-----------------------------
        st3: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            end  
//---------------------------st4-----------------------------
        st4: 
            begin
            PC_inc <= 0;
            //Gxout
            case(param2)
            6'b000000: begin
                G0_out <= 1; G1_out <= 0; G2_out <= 0; G3_out <= 0;
                end
            6'b000010: begin 
                G0_out <= 0; G1_out <= 1; G2_out <= 0; G3_out <= 0;
                end
            6'b000011: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 1; G3_out <= 0;
                end
            6'b000100: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 1;
            end
            endcase
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            end   
//---------------------------st5-----------------------------
        st5: 
            begin
            PC_inc <= 0;
            //Gxout
            case(param2)
            6'b000000: begin
                G0_out <= 1; G1_out <= 0; G2_out <= 0; G3_out <= 0;
                end
            6'b000010: begin 
                G0_out <= 0; G1_out <= 1; G2_out <= 0; G3_out <= 0;
                end
            6'b000011: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 1; G3_out <= 0;
                end
            6'b000100: begin
                G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 1;
            end
            endcase
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 1;
            done <= 0;
            end 
//---------------------------st6-----------------------------
        st6: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 1;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            end
//---------------------------st7-----------------------------
        st7: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 1;
            end  
//---------------------------st8 - Setting done t0 0----------
        st8: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            end
//---------------------------st9-----------------------------
        st9: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 1;
            mem_RW <= 1;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            end
//---------------------------st10-----------------------------
        st10: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 1;
            mem_RW <= 1;
            MDR_EN_read <= 1;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            end
//---------------------------st11-----------------------------
        st11: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 1;
            MDR_EN_write <= 0;
            done <= 0;
            end   
//---------------------------st12-----------------------------
        st12: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0;
            //Gxin
            case(param1)
            6'b000000: begin
                G0_in <= 1; G1_in <= 0; G2_in <= 0; G3_in <= 0;
                end
            6'b000010: begin 
                G0_in <= 0; G1_in <= 1; G2_in <= 0; G3_in <= 0;
                end
            6'b000011: begin
                G0_in <= 0; G1_in <= 0; G2_in <= 1; G3_in <= 0;
                end
            6'b000100: begin
                G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 1;
            end
            endcase
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 1;
            MDR_EN_write <= 0;
            done <= 0;
            end                                                                                                                       
//------------------------default-----------------------------
        default: 
        begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            MDR_EN_write <= 0;
            done <= 0;
            end
        endcase
    end
endmodule