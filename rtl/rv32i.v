`timescale 1ns / 1ps

module rv32i(
    input clk, reset,
    output [31:0] mmio_addr, mmio_wdata, dbg_pc,
    output mmio_we
    );
    
    wire pcsrc, memwrite, alusrc, regwrite;
    wire [1:0] resultsrc, immsrc;
    wire [2:0] alucontrol;
    wire zero, funct7_5;
    wire [2:0] funct3;
    wire [6:0] op;
    
    Control_unit Control_unit(
        .pcsrc(pcsrc), .memwrite(memwrite), .alusrc(alusrc), .regwrite(regwrite),
        .resultsrc(resultsrc), .immsrc(immsrc),
        .alucontrol(alucontrol),
        .zero(zero), .funct7_5(funct7_5),
        .funct3(funct3),
        .op(op)
        );
        
    datapath Datapath(
        .clk(clk), .reset(reset),
        .pcsrc(pcsrc), .memwrite(memwrite), .alusrc(alusrc), .regwrite(regwrite),
        .resultsrc(resultsrc), .immsrc(immsrc),
        .alucontrol(alucontrol),
        .zero(zero), .funct7_5(funct7_5),
        .funct3(funct3),
        .op(op),
        .mmio_addr(mmio_addr), .mmio_wdata(mmio_wdata), .mmio_we(mmio_we), .dbg_pc(dbg_pc)
        );
    
endmodule
