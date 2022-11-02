//Hayden Prater
//November 2, 2022
//D Flip-Flop
`timescale 1ns/10ps
module dff(clk, rst, en, data, q);
input[3:0] data;
input en, clk, rst;
output reg[3:0] q; 

always @(posedge clk or posedge rst)
    begin
    if(rst)
        q <= 4'b0000;
    else if(en)
        q <= data;
    end
endmodule