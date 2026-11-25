`timescale 1ns / 1ps

module datapath_tb();
    reg clk;
    reg pcsrc, memwrite, alusrc, regwrite;
    reg [1:0] immsrc, resultsrc;
    reg [2:0] alucontrol;
    wire zero, funct7_5;
    wire [2:0] funct3;
    wire [6:0] op;
    
    datapath dut(
        .clk(clk),
        .pcsrc(pcsrc), .memwrite(memwrite), .alusrc(alusrc), .regwrite(regwrite),
        .immsrc(immsrc), .resultsrc(resultsrc),
        .alucontrol(alucontrol),
        .zero(zero), .funct7_5(funct7_5),
        .funct3(funct3),
        .op(op)
        );
        
        always #5 clk = ~clk;
        
        initial
            begin
                clk = 0;
                //Test 1:
                dut.PC_Register.pc = 32'd0;
                dut.Instruction_Memory.mem[0] = 32'hFFC4_A303;
                dut.Register_File.regs[9] = 32'h0000_0008;
                dut.Data_Memory.mem[1] = 32'd10;
                dut.Register_File.regs[6] = 32'd0;
                memwrite = 1'b0;
                alusrc = 1'b1;
                regwrite = 1'b1;
                immsrc = 2'b00;
                resultsrc = 2'b01;
                alucontrol = 3'b000;
                pcsrc = 1'b0;
                @(posedge clk); #1;
                if(dut.Register_File.regs[6] === 32'd10)
                    $display ("Test 1 PASSED: loaded word correctly, loaded word = %d", dut.Register_File.regs[6]);
                else
                    $display ("Test 1 FAILED: expected 10, got %d", dut.Register_File.regs[6]);
                
                //Test:
                dut.PC_Register.pc = 32'd4;
                dut.Instruction_Memory.mem[1] = 32'h0064A423;
                dut.Register_File.regs[9] = 32'h0000_0008;
                dut.Register_File.regs[6] = 32'd10;
                memwrite = 1'b1;
                alusrc = 1'b1;
                regwrite = 1'b0;
                immsrc = 2'b01;
                resultsrc = 2'b00;
                alucontrol = 3'b000;
                pcsrc = 1'b0;
                @(posedge clk); #1;
                if(dut.Data_Memory.mem[4] === 32'd10)
                    $display ("Test 2 PASSED: stored word correctly, stored word = %d", dut.Data_Memory.mem[4]);
                else
                    $display ("Test 2 FAILED: expected 10, got %d", dut.Data_Memory.mem[4]);
                
                //Test 3:
                dut.PC_Register.pc = 32'd8;
                dut.Instruction_Memory.mem[2] = 32'h0062E233;
                dut.Register_File.regs[4] = 32'd0;
                dut.Register_File.regs[5] = 32'd6;
                dut.Register_File.regs[6] = 32'd10;
                memwrite = 1'b0;
                alusrc = 1'b0;
                regwrite = 1'b1;
                immsrc = 2'b00;
                resultsrc = 2'b00;
                alucontrol = 3'b011;
                pcsrc = 1'b0;
                @(posedge clk); #1;
                if (dut.Register_File.regs[4] === 32'd14)
                    $display ("Test 3 PASSED: or performed correctly, value = %d", dut.Register_File.regs[4]);
                else
                    $display ("Test 3 FAILED: expected 14, got %d", dut.Register_File.regs[4]);
                
                //Test 4:
                dut.PC_Register.pc = 32'd12;
                dut.Instruction_Memory.mem[3] = 32'hFE420AE3;
                dut.Register_File.regs[4] = 32'd14;
                memwrite = 1'b0;
                alusrc = 1'b0;
                regwrite = 1'b0;
                immsrc = 2'b10;
                resultsrc = 2'b00;
                alucontrol = 3'b001;
                pcsrc = 1'b1;
                #1;
                if (zero === 1'b1)
                    $display ("Test 4.1 PASSED: zero flag correct pre-branch, zero = %b", zero);
                else
                    $display ("Test 4.1 FAILED: expected 1, got %b", zero);

                @(posedge clk); #1;
                if (dut.PC_Register.pc === 32'd0)
                    $display ("Test 4.2 PASSED: PC branched correctly, pc = %d", dut.PC_Register.pc);
                else
                    $display ("Test 4.2 FAILED: expected 0, got %d", dut.PC_Register.pc);
                
                //test 5:
                dut.PC_Register.pc = 32'd16;
                dut.Instruction_Memory.mem[4] = 32'h008000EF;
                dut.Register_File.regs[1] = 32'd0;
                memwrite = 1'b0;
                alusrc = 1'b0;
                regwrite = 1'b1;
                immsrc = 2'b11;
                resultsrc = 2'b10;
                alucontrol = 3'b000;
                pcsrc = 1'b1;
                @(posedge clk); #1;
                if (dut.Register_File.regs[1] === 32'd20)
                    $display ("Test 5.1 PASSED: jal performed correctly, value = %d", dut.Register_File.regs[1]);
                else
                    $display ("Test 5.1 FAILED: expected 0, got %d", dut.Register_File.regs[1]);
                if (dut.PC_Register.pc === 32'd24)
                    $display ("Test 5.2 PASSED: PC redirection done, value = %d", dut.PC_Register.pc);
                else
                    $display ("Test 5.2 FAILED: expected 24, got %d", dut.PC_Register.pc);
                $finish;
                
            end

endmodule
