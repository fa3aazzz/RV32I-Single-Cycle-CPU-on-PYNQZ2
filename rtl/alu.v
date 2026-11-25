`timescale 1ns / 1ps//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/18/2026 01:32:25 PM
// Design Name: 
// Module Name: alu
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


module alu(
    input [31:0] srca, srcb,
    input [2:0] alucontrol,
    output reg [31:0] aluresult,
    output zero
    );
    
    always @(*)
        case(alucontrol)
            3'b000: aluresult = srca + srcb;
            3'b001: aluresult = srca - srcb;
            3'b010: aluresult = srca & srcb;
            3'b011: aluresult = srca | srcb;
            3'b101: aluresult = $signed(srca) < $signed(srcb);
            default: aluresult = 32'bx;
         endcase
         
    assign zero = (aluresult == 32'b0);

endmodule
