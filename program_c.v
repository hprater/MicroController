//Hayden Prater
//November 7, 2022
//Program Counter

`timescale 1ns/10ps

module program_c(count, rst, increment);
input increment, rst;
output reg [15:0] count;

always @(increment)
    begin
    if(rst)
        count <= 16'b0000000000000000;
    else
        count <= count + 1;
    end
endmodule