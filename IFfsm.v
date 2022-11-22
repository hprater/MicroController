//Hayden Prater
//November 21, 2022
//Instruction Fetch

module IFfsm(clk, rst, done, MFC, PC_Out, MAR_EN, mem_EN, mem_RW, MDR_EN_read, MDR_out, IR_EN);
    input clk, rst, done, MFC;
    output reg PC_Out, MAR_EN, mem_EN, mem_RW, MDR_EN_read, MDR_out, IR_EN;
    reg [3:0] pres_state, next_state;
    parameter st0 = 4'b0000, st1 = 4'b0001, st2 = 4'b0010, st3 = 4'b0011, st4 = 4'b0100,
              st5 = 4'b0101, st6 = 4'b0110, st7 = 4'b0111, st8 = 4'b1000;

    always @(posedge clk or posedge rst or posedge done) 
    begin
        if(rst || done)
            pres_state <= st0;
        else if (pres_state == st4 && !MFC)
            pres_state <= st4;
        else
            pres_state <= next_state;
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
        default: next_state <= st0;
        endcase
    end

    always @(pres_state) 
    begin
        case (pres_state)
//---------------------------st0-----------------------------
        st0: 
            begin
            PC_Out <= 1;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            IR_EN <= 0;
            end
//---------------------------st1-----------------------------
        st1: 
            begin
            PC_Out <= 1;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            IR_EN <= 0;
            end
//---------------------------st2-----------------------------
        st2: 
            begin
            PC_Out <= 1;
            MAR_EN <= 1;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            IR_EN <= 0;
            end
//---------------------------st3-----------------------------
        st3: 
            begin
            PC_Out <= 0;
            MAR_EN <= 0;
            mem_EN <= 1;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            IR_EN <= 0;
            end
//---------------------------st4-----------------------------
        st4: 
            begin
            PC_Out <= 0;
            MAR_EN <= 0;
            mem_EN <= 1;
            mem_RW <= 1;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            IR_EN <= 0;
            end
//---------------------------st5-----------------------------
        st5: 
            begin
            PC_Out <= 0;
            MAR_EN <= 0;
            mem_EN <= 1;
            mem_RW <= 1;
            MDR_EN_read <= 1;
            MDR_out <= 0;
            IR_EN <= 0;
            end
//---------------------------st6-----------------------------
        st6: 
            begin
            PC_Out <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 1;
            MDR_EN_read <= 0;
            MDR_out <= 1;
            IR_EN <= 0;
            end
//---------------------------st7-----------------------------
        st7: 
            begin
            PC_Out <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 1;
            MDR_EN_read <= 0;
            MDR_out <= 1;
            IR_EN <= 1;
            end
//---------------------------st8-----------------------------
        st8: 
            begin
            PC_Out <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            IR_EN <= 0;
            end
//------------------------default-----------------------------
        default: 
            begin
            PC_Out <= 0;
            MAR_EN <= 0;
            mem_EN <= 0;
            mem_RW <= 0;
            MDR_EN_read <= 0;
            MDR_out <= 0;
            IR_EN <= 0;
            end
        endcase   
    end  
endmodule
