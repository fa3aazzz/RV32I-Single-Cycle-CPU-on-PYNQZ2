`timescale 1ns / 1ps

module Control_unit(
    input zero, funct7_5,
    input [2:0] funct3,
    input [6:0] op,
    output pcsrc, memwrite, alusrc, regwrite,
    output [1:0] resultsrc, immsrc,
    output [2:0] alucontrol
    );
    wire branch, jump;
    wire [1:0] aluop;
    
    assign pcsrc = (zero & branch) | jump;
    
    main_decoder Main_Decoder(
        .op(op),
        .branch(branch), .jump(jump), .memwrite(memwrite), .alusrc(alusrc), .regwrite(regwrite),
        .resultsrc(resultsrc), .immsrc(immsrc), .aluop(aluop)
        );
        
    alu_decoder ALU_Decoder(
        .funct7_5(funct7_5), .op5(op[5]),
        .aluop(aluop),
        .funct3(funct3),
        .alucontrol(alucontrol)
        );
    
endmodule
