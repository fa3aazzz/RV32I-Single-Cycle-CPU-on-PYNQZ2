`timescale 1ns / 1ps

module main_decoder(
    input [6:0] op,
    output branch, jump, memwrite, alusrc, regwrite,
    output [1:0] resultsrc, immsrc, aluop
    );
    reg [10:0] control_signals;
    
    assign {regwrite,immsrc,alusrc,memwrite,resultsrc,branch,aluop,jump} = control_signals;
    
    always @(*)
        case (op)
            7'b0000011: control_signals = 11'b1_00_1_0_01_0_00_0; // lw
            7'b0100011: control_signals = 11'b0_01_1_1_00_0_00_0; // sw
            7'b0110011: control_signals = 11'b1_00_0_0_00_0_10_0; // R-type
            7'b1100011: control_signals = 11'b0_10_0_0_00_1_01_0; // beq
            7'b0010011: control_signals = 11'b1_00_1_0_00_0_10_0; // addi
            7'b1101111: control_signals = 11'b1_11_0_0_10_0_00_1; // jal
            default: control_signals = 11'bx;
        endcase
    
endmodule
