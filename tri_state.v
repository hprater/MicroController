//Hayden Prater
//November 2, 2022
//TriState
`timescale 1ns/10ps
module tri_state (en, d, q);
    input en;
    input [3:0] d; 
    output reg [3:0] q;

    always @(en or d) 
    begin 
    if(en)
        q = d;
    else 
        q = 4'bzzzz;
    end
endmodule