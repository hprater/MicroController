//Hayden Prater
//November 21, 2022
//ALUI FSM

module ALUIfsm (clk, rst, fullBitNum, PC_inc, ALUin1, ALUin2, ALU_outlach, ALU_outEN, done,
                G0_in, G0_out, G1_in, G1_out, G2_in, G2_out, G3_in, G3_out);
input clk, rst;
input [15:0] fullBitNum;
output reg PC_inc, ALUin1, ALUin2, ALU_outlach, ALU_outEN, done;
output reg G0_in, G0_out, G1_in, G1_out, G2_in, G2_out, G3_in, G3_out;
reg [3:0] pres_state, next_state;
    parameter st0 = 4'b0000, st1 = 4'b0001, st2 = 4'b0010, st3 = 4'b0011, st4 = 4'b0100,
              st5 = 4'b0101, st6 = 4'b0110, st7 = 4'b0111, st8 = 4'b1000, st9 = 4'b1001;

wire [3:0]opCode = fullBitNum[15:12];
wire [5:0]param1 = fullBitNum[11:6]; 
wire [5:0]param2 = fullBitNum[5:0];

always @(posedge clk or posedge rst) 
    begin
        if (rst)
            pres_state <= st0;
        else if (opCode == 4'b0010 || opCode == 4'b0001)
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
           st5 : next_state <= st6;
           st6 : next_state <= st7;
           st7 : next_state <= st8;
           st8 : next_state <= st9;
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
            ALUin1 <= 0;
            ALUin2 <= 0;
            ALU_outlach <= 0;
            ALU_outEN <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
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
            ALUin1 <= 0;
            ALUin2 <= 0;
            ALU_outlach <= 0;
            ALU_outEN <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
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
            ALUin1 <= 1;
            ALUin2 <= 0;
            ALU_outlach <= 0;
            ALU_outEN <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            done <= 0;
            end
//---------------------------st3-----------------------------
            st3: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0;
            ALUin1 <= 0;
            ALUin2 <= 0;
            ALU_outlach <= 0;
            ALU_outEN <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            done <= 0;
            end
//---------------------------st4-----------------------------
//Passing # into ALUin2 from bus  ?????????????          
             st4: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0;
            ALUin1 <= 0;
            ALUin2 <= 1;
            ALU_outlach <= 0;
            ALU_outEN <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            done <= 0;
            end
//---------------------------st5-----------------------------
             st5: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0;
            ALUin1 <= 0;
            ALUin2 <= 0;
            ALU_outlach <= 1;
            ALU_outEN <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            done <= 0;
            end
//---------------------------st6-----------------------------
             st6: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0;
            ALUin1 <= 0;
            ALUin2 <= 0;
            ALU_outlach <= 0;
            ALU_outEN <= 1;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            done <= 0;
            end
//---------------------------st7-----------------------------
             st7: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0;
            ALUin1 <= 0;
            ALUin2 <= 0;
            ALU_outlach <= 0;
            ALU_outEN <= 1;
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
            done <= 0;
            end
//---------------------------st8-----------------------------
             st8: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0;
            ALUin1 <= 0;
            ALUin2 <= 0;
            ALU_outlach <= 0;
            ALU_outEN <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            done <= 1;
            end
//---------------------------st9-----------------------------
             st9: 
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0;
            ALUin1 <= 0;
            ALUin2 <= 0;
            ALU_outlach <= 0;
            ALU_outEN <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            done <= 0;
            end
//------------------------default----------------------------
            default:
            begin
            PC_inc <= 0;
            //Gxout
            G0_out <= 0; G1_out <= 0; G2_out <= 0; G3_out <= 0;
            ALUin1 <= 0;
            ALUin2 <= 0;
            ALU_outlach <= 0;
            ALU_outEN <= 0;
            //Gxin
            G0_in <= 0; G1_in <= 0; G2_in <= 0; G3_in <= 0;
            done <= 0;
            end
        endcase
    end
endmodule