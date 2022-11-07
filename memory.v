module memory (Data_out, MFC, EN, addr, Data_in, RW);
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
                Data_out = 16'b0000000000000000;
                16'b0000000000000001:
                Data_out = 16'b0000000000000000;
                16'b0000000000000010:
                Data_out = 16'b0000000000000000;
                16'b0000000000000011:
                Data_out = 16'b0000000000000000;
                16'b0000000000000100:
                Data_out = 16'b0000000000000000;
                16'b0000000000000101:
                Data_out = 16'b0000000000000000;
                16'b0000000000000110:
                Data_out = 16'b0000000000000000;
                16'b0000000000000111:
                Data_out = 16'b0000000000000000;
                default: Data_out = memorycell;
            endcase
        end
        else memorycell = Data_in;
        #10 MFC = 1;
    end

    always @(negedge EN)
        MFC = 0;
        
endmodule