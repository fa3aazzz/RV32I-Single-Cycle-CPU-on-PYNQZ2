`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/30/2026 02:32:06 AM
// Design Name: 
// Module Name: extend
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module extend(
    input [1:0] immsrc,
    input [31:7] instr,
    output reg [31:0] immext
    );
    
    always @(*)
        case(immsrc)
            2'b00: immext = {{20{instr[31]}}, instr[31:20]};                                 // I-type
            2'b01: immext = {{20{instr[31]}}, instr[31:25], instr[11:7]};                    // S-type
            2'b10: immext = {{20{instr[31]}}, instr[7], instr[30:25], instr[11:8], 1'b0};    // B-type
            2'b11: immext = {{12{instr[31]}}, instr[19:12], instr[20], instr[30:21], 1'b0};  // J-type
        endcase
    
endmodule
