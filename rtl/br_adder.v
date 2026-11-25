`timescale 1ns / 1ps

module br_adder(
    input [31:0] pc, immext,
    output [31:0] pctarget
    );
    
    assign pctarget = pc + immext;
    
endmodule
