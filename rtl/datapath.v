`timescale 1ns / 1ps

module datapath(
    input clk, reset,
    input pcsrc, memwrite, alusrc, regwrite,
    input [1:0] immsrc, resultsrc,
    input [2:0] alucontrol,
    output zero, funct7_5,
    output [2:0] funct3,
    output [6:0] op,
    output [31:0] mmio_addr, mmio_wdata, dbg_pc,
    output mmio_we
    );
    
    wire [31:0] result, pcplus4, pcnext, pc, instr, srca, rd2, srcb, immext, aluresult, pctarget, readdata;
    
    pc_reg PC_Register(
        .clk(clk), .reset(reset),
        .pcnext(pcnext),
        .pc(pc)
        );
        
    instruction_mem Instruction_Memory(
        .a(pc),
        .rd(instr)
        );
        
    pc4_adder PC_Plus_4_Adder(
        .pc(pc),
        .pcplus4(pcplus4)
        );
        
    regfile Register_File(
        .clk(clk), .we3(regwrite),
        .a1(instr[19:15]), .a2(instr[24:20]), .a3(instr[11:7]),
        .wd3(result),
        .rd1(srca), .rd2(rd2)
        );
        
    extend Extend(
        .immsrc(immsrc),
        .instr(instr[31:7]),
        .immext(immext)
        );
        
    br_adder Branch_Adder(
        .pc(pc), .immext(immext),
        .pctarget(pctarget)
        );
    
    alu_mux ALU_MUX(
        .alusrc(alusrc),
        .rd2(rd2), .immext(immext),
        .srcb(srcb)
        );
    
    alu ALU(
        .alucontrol(alucontrol),
        .srca(srca), .srcb(srcb),
        .aluresult(aluresult), .zero(zero)
        );
    
    data_mem Data_Memory(
        .clk(clk), .we(memwrite),
        .a(aluresult), .wd(rd2),
        .rd(readdata)
        );
    
    result_mux Result_MUX(
        .resultsrc(resultsrc),
        .aluresult(aluresult), .readdata(readdata), .pcplus4(pcplus4),
        .result(result)
        );
    
    pc_mux PC_MUX(
        .pcsrc(pcsrc),
        .pcplus4(pcplus4), .pctarget(pctarget),
        .pcnext(pcnext)
        );
    
    assign op = instr[6:0];
    assign funct3 = instr[14:12];
    assign funct7_5 = instr[30];
    
    assign mmio_addr = aluresult;
    assign mmio_wdata = rd2;
    assign mmio_we = memwrite;
    assign dbg_pc = pc;
    
endmodule
