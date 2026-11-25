`timescale 1ns / 1ps

module pc_reg(
    input clk, reset,
    input [31:0] pcnext,
    output reg [31:0] pc
    );
    
    always @(posedge clk)
        if (reset)
            pc <= 32'h0000_1000;
        else
            pc <= pcnext;
    
endmodule
