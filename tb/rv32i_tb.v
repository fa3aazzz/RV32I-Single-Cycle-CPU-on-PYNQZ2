`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 09/12/2026 04:07:11 AM
// Design Name: 
// Module Name: rv32i_tb
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


module rv32i_tb();
    reg clk;
    reg reset;
    wire [31:0] mmio_addr;
    wire [31:0] mmio_wdata;
    wire [31:0] dbg_pc;
    wire mmio_we;
    
    rv32i dut(
        .clk(clk),
        .reset(reset),
        .mmio_addr(mmio_addr),
        .mmio_wdata(mmio_wdata),
        .dbg_pc(dbg_pc),
        .mmio_we(mmio_we)
        );
        
        always #5 clk = ~clk;
        
        initial
            begin
                clk = 0;
                reset = 1;
                
                dut.Datapath.Instruction_Memory.mem[1024] = 32'hFFC4A303; //lw
                dut.Datapath.Instruction_Memory.mem[1025] = 32'h0064A423; //sw
                dut.Datapath.Instruction_Memory.mem[1026] = 32'h0062E233; //or
                dut.Datapath.Instruction_Memory.mem[1027] = 32'hFE420AE3; //beq

                dut.Datapath.Register_File.regs[9] = 32'h00002004;
                dut.Datapath.Register_File.regs[5] = 32'd6;
                dut.Datapath.Data_Memory.mem[2048] = 32'd10;
                
                @(posedge clk); #1;
                reset = 0;
                
                @(posedge clk); #1;
                if (dut.Datapath.Register_File.regs[6] === 32'd10)
                    $display ("PASSED: lw executes correctly");
                else
                    $display ("FAILED: ecpected 10, got %d", dut.Datapath.Register_File.regs[6]);
                
                @(posedge clk); #1;
                if (dut.Datapath.Data_Memory.mem[2051] === 32'd10)
                    $display ("PASSED: sw executes correctly");
                else
                    $display ("FAILED: ecpected 10, got %d", dut.Datapath.Data_Memory.mem[2051]);
                
                @(posedge clk); #1;
                if (dut.Datapath.Register_File.regs[4] === 32'd14)
                    $display ("PASSED: or executes correctly");
                else
                    $display ("FAILED: ecpected 14, got %d", dut.Datapath.Register_File.regs[4]);
                
                @(posedge clk); #1;
                if (dut.Datapath.PC_Register.pc === 32'h00001000)
                    $display ("PASSED: beq executes correctly");
                else
                    $display ("FAILED: ecpected 00001000, got %h", dut.Datapath.PC_Register.pc);
                
                $finish;
                
            end
endmodule
