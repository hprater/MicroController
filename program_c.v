//Hayden Prater
//November 7, 2022
//Program Counter

`timescale 1ns/10ps

module program_c(clk, count, rst, increment);
input clk, increment, rst;
output reg [15:0] count;

always @(posedge rst or posedge clk)
    begin
    if(rst)
        count <= 16'b0000000000000000;
    else if (increment)
        count <= count + 1;
    end
endmodule