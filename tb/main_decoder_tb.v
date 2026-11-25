`timescale 1ns / 1ps

module main_decoder_tb();
    reg [6:0] op;
    wire branch, jump, memwrite, alusrc, regwrite;
    wire [1:0] resultsrc, immsrc, aluop;
    
    main_decoder dut(
        .op(op),
        .branch(branch), .jump(jump), .memwrite(memwrite), .alusrc(alusrc), .regwrite(regwrite),
        .resultsrc(resultsrc), .immsrc(immsrc), .aluop(aluop)
        );
        
        initial
            begin
                //Test 1:
                op = 7'b0000011;
                #1;
                if ({regwrite,immsrc,alusrc,memwrite,resultsrc,branch,aluop,jump} === 11'b1_00_1_0_01_0_00_0)
                    $display ("Test 1 PASSED: lw control signal tested");
                else
                    $display ("Test 1 FAILED: expected 10010010000, got %b", {regwrite,immsrc,alusrc,memwrite,resultsrc,branch,aluop,jump});
                
                //Test 2:
                op = 7'b0100011;
                #1;
                if ({regwrite,immsrc,alusrc,memwrite,resultsrc,branch,aluop,jump} === 11'b0_01_1_1_00_0_00_0)
                    $display ("Test 2 PASSED: sw control signal tested");
                else
                    $display ("Test 2 FAILED: expected 00111000000, got %b", {regwrite,immsrc,alusrc,memwrite,resultsrc,branch,aluop,jump});
                
                //Test 3:
                op = 7'b0110011;
                #1;
                if ({regwrite,immsrc,alusrc,memwrite,resultsrc,branch,aluop,jump} === 11'b1_00_0_0_00_0_10_0)
                    $display ("Test 3 PASSED: R-type control signal tested");
                else
                    $display ("Test 3 FAILED: expected 10000000100, got %b", {regwrite,immsrc,alusrc,memwrite,resultsrc,branch,aluop,jump});
                
                //Test 4:
                op = 7'b1100011;
                #1;
                if ({regwrite,immsrc,alusrc,memwrite,resultsrc,branch,aluop,jump} === 11'b0_10_0_0_00_1_01_0)
                    $display ("Test 4 PASSED: beq control signal tested");
                else
                    $display ("Test 4 FAILED: expected 01000001010, got %b", {regwrite,immsrc,alusrc,memwrite,resultsrc,branch,aluop,jump});
                    
                //Test 5:
                op = 7'b0010011;
                #1;
                if ({regwrite,immsrc,alusrc,memwrite,resultsrc,branch,aluop,jump} === 11'b1_00_1_0_00_0_10_0)
                    $display ("Test 5 PASSED: addi control signal tested");
                else
                    $display ("Test 5 FAILED: expected 10010000100, got %b", {regwrite,immsrc,alusrc,memwrite,resultsrc,branch,aluop,jump});
                    
                //Test 6:
                op = 7'b1101111;
                #1;
                if ({regwrite,immsrc,alusrc,memwrite,resultsrc,branch,aluop,jump} === 11'b1_11_0_0_10_0_00_1)
                    $display ("Test 6 PASSED: jal control signal tested");
                else
                    $display ("Test 6 FAILED: expected 11100100001, got %b", {regwrite,immsrc,alusrc,memwrite,resultsrc,branch,aluop,jump});
                
                //Test 7:
                op = 7'b1111111;
                #1;
                if ({regwrite,immsrc,alusrc,memwrite,resultsrc,branch,aluop,jump} === 11'bx)
                    $display ("Test 7 PASSED: default case tested");
                else
                    $display ("Test 7 FAILED: expected xxxxxxxxxxx, got %b", {regwrite,immsrc,alusrc,memwrite,resultsrc,branch,aluop,jump});
                
                $finish;
            
            end

endmodule
