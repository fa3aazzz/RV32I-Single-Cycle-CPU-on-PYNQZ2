`timescale 1ns / 1ps

module alu_decoder(
    input funct7_5, op5,
    input [1:0] aluop,
    input [2:0] funct3,
    output reg [2:0] alucontrol
    );
    
    always @(*)
        case (aluop)
            2'b00: alucontrol = 3'b000; // lw,sw
            2'b01: alucontrol = 3'b001; // beq
            2'b10: 
                case (funct3)
                        3'b000: alucontrol = (op5 & funct7_5) ? 3'b001: 3'b000; //sub/add
                        3'b010: alucontrol = 3'b101; //slt
                        3'b110: alucontrol = 3'b011; //or
                        3'b111: alucontrol = 3'b010;//and
                        default: alucontrol = 3'bx;
                   endcase
            default: alucontrol = 3'bx;
        endcase
    
endmodule
