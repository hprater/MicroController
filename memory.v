module memory (EN, MFC, addr, RW, Data_in, Data_out);
    input EN, RW;
    input [15:0] addr, Data_in;
    output [15:0] Data_out;
    output MFC;
    reg Data_out, memorycell;
    reg MFC;

    always @(posedge EN)
    begin
        if(RW == 1) begin
            case(addr)
                16'b0000000000000000:
                Data_out = 16'b0111000000001100;    //MOVI R0, #12
                16'b0000000000000001:
                Data_out = 16'b1011000000000000;    //NOT R0
                16'b0000000000000010:
                Data_out = 16'b0110000010000000;    //MOV R1, R0
                16'b0000000000000011:
                Data_out = 16'b0010000000011111;    //SUBI R0 #1F   (1F = 31)
                16'b0000000000000100:
                Data_out = 16'b1110000000000010;    //XOR R0, R1
                16'b0000000000000101:
                Data_out = 16'b1011000010000000;    //NOT R1
                16'b0000000000000110:
                Data_out = 16'b0011000000000010;    //STROE RO, (R1)
                16'b0000000000000111:
                Data_out = 16'b0100000010000001;    //LOAD (R1), PO
                default: Data_out = memorycell;
            endcase
        end
        else memorycell = Data_in;
        #5 MFC = 1;
    end

    always @(negedge EN)
        MFC = 0;

endmodule