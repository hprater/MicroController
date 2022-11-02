//Hayden Prater
//November 2, 2022
//ALU
`timescale 1ns/10ps
module ALU(opCode, in1, in2, out);
input [2:0] opCode;
input [15:0] in1, in2;
output reg [15:0] out;

always @(opCode, in1, in2) 
begin
    case(opCode)
        3'b001:
            out <= in1 + in2;
        3'b010:
            out <= in1 - in2;
        3'b011:
            out <= ~in1;
        3'b100:
            out <= in1 & in2;
        3'b101:
            out <= in1 | in2;
        3'b110:
            out <= in1 ^ in2;
        3'b111:
            out <= in1 ~^ in2;
        default:
            out <= 16'b0000000000000000;
    endcase
end

endmodule