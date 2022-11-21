//Hayden Prater
//November 21, 2022
//ALU FSM

module ALUfsm (clk, rst, fullBitNum, PC_inc, Gx_out1, ALUin1, Gx_out2, ALUin2, ALU_outlach, ALU_outEN, Gx_in, done, opControl);
input clk, rst, start;
input [15:0] fullBitNum;
output reg PC_inc, Gx_out1, ALUin1, Gx_out2, ALUin2, ALU_outlach, ALU_outEN, Gx_in, done;
output reg [2:0]opControl;
reg [3:0] pres_state, next_state;
    parameter st0 = 4'b0000, st1 = 4'b0001, st2 = 4'b0010, st3 = 4'b0011, st4 = 4'b0100,
              st5 = 4'b0101, st6 = 4'b0110, st7 = 4'b0111, st8 = 4'b1000, st9 = 4'b1001,
              st10 = 4'b1010;

wire [3:0]opCode = fullBitNum[15:12];
wire [5:0]param1 = fullBitNum[11:6]; 
wire [5:0]param2 = fullBitNum[5:0];


    always @(posedge clk or posedge rst) 
    begin
        if (rst)
            pres_state <= st0;
        else if (opCode == 4'b1001 || opCode == 4'b1010 || opCode == 4'b1011 || opCode == 4'b1100 || opCode == 4'b1101 || opCode == 4'b1110 || opCode == 4'b1111)
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
           st9 : next_state <= st10;
        default: next_state <= st0;
        endcase
    end

    always @(pres_state) 
    begin
        case (pres_state)
            st0: 
            begin
            PC_inc = 0;
            Gx_out1 = 0; 
            ALUin1 = 0;
            Gx_out2 = 0;
            ALUin2 = 0;
            ALU_outlach = 0;
            ALU_outEN = 0;
            Gx_in = 0;
            done = 0;
            end

            st1: 
            begin
            PC_inc = 1;
            Gx_out1 = 1; 
            ALUin1 = 0;
            Gx_out2 = 0;
            ALUin2 = 0;
            ALU_outlach = 0;
            ALU_outEN = 0;
            Gx_in = 0;
            done = 0;
            end

            st2: 
            begin
            PC_inc = 0;
            Gx_out1 = 1; 
            ALUin1 = 1;
            Gx_out2 = 0;
            ALUin2 = 0;
            ALU_outlach = 0;
            ALU_outEN = 0;
            Gx_in = 0;
            done = 0;
            end

            st3: 
            begin
            PC_inc = 0;
            Gx_out1 = 0; 
            ALUin1 = 0;
            Gx_out2 = 0;
            ALUin2 = 0;
            ALU_outlach = 0;
            ALU_outEN = 0;
            Gx_in = 0;
            done = 0;
            end

            st4: 
            begin
            PC_inc = 0;
            Gx_out1 = 0; 
            ALUin1 = 0;
            Gx_out2 = 1;
            ALUin2 = 0;
            ALU_outlach = 0;
            ALU_outEN = 0;
            Gx_in = 0;
            done = 0;
            end

            st5: 
            begin
            PC_inc = 0;
            Gx_out1 = 0; 
            ALUin1 = 0;
            Gx_out2 = 1;
            ALUin2 = 1;
            ALU_outlach = 0;
            ALU_outEN = 0;
            Gx_in = 0;
            done = 0;
            end

            st6: 
            begin
            PC_inc = 0;
            Gx_out1 = 0; 
            ALUin1 = 0;
            Gx_out2 = 0;
            ALUin2 = 0;
            ALU_outlach = 1;
            ALU_outEN = 0;
            Gx_in = 0;
            done = 0;
            end

            st7: 
            begin
            PC_inc = 0;
            Gx_out1 = 0; 
            ALUin1 = 0;
            Gx_out2 = 0;
            ALUin2 = 0;
            ALU_outlach = 0;
            ALU_outEN = 1;
            Gx_in = 0;
            done = 0;
            end

            st8: 
            begin
            PC_inc = 0;
            Gx_out1 = 0; 
            ALUin1 = 0;
            Gx_out2 = 0;
            ALUin2 = 0;
            ALU_outlach = 0;
            ALU_outEN = 1;
            Gx_in = 1;
            done = 0;
            end

            st9: 
            begin
            PC_inc = 0;
            Gx_out1 = 0; 
            ALUin1 = 0;
            Gx_out2 = 0;
            ALUin2 = 0;
            ALU_outlach = 0;
            ALU_outEN = 0;
            Gx_in = 0;
            done = 1;
            end

            st10: 
            begin
            PC_inc = 0;
            Gx_out1 = 0; 
            ALUin1 = 0;
            Gx_out2 = 0;
            ALUin2 = 0;
            ALU_outlach = 0;
            ALU_outEN = 0;
            Gx_in = 0;
            done = 0;
            end


            default: 
            begin
            PC_inc = 0;
            Gx_out1 = 0; 
            ALUin1 = 0;
            Gx_out2 = 0;
            ALUin2 = 0;
            ALU_outlach = 0;
            ALU_outEN = 0;
            Gx_in = 0;
            done = 0;
            end

        endcase   
    end    
endmodule