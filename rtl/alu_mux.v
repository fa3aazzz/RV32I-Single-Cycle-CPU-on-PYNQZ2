`timescale 1ns / 1ps

module alu_mux(
    input alusrc,
    input [31:0] rd2, immext,
    output [31:0] srcb
    );
    
    assign srcb = alusrc ? immext : rd2;
    
endmodule
