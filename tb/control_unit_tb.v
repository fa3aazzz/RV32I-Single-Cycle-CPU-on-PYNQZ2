`timescale 1ns / 1ps

module control_unit_tb();
    reg zero, funct7_5;
    reg [2:0] funct3;
    reg [6:0] op;
    wire pcsrc, memwrite, alusrc, regwrite;
    wire [1:0] resultsrc, immsrc;
    wire [2:0] alucontrol;
    
    Control_unit dut(
        .zero(zero), .funct7_5(funct7_5),
        .funct3(funct3),
        .op(op),
        .pcsrc(pcsrc), .memwrite(memwrite), .alusrc(alusrc), .regwrite(regwrite),
        .resultsrc(resultsrc), .immsrc(immsrc),
        .alucontrol(alucontrol)
        );
        
        initial
            begin
                //Test 1:
                op = 7'b0000011;
                funct3 = 3'b000;
                funct7_5 = 1'b0;
                zero = 1'b0;
                #1;
                if (alucontrol === 3'b000)
                    $display ("Test 1 PASSED: alucontrol = %b for lw control signal", alucontrol);
                else
                    $display ("Test 1 FAILED: expected alucontrol = 000, got %b", alucontrol);
                
                //Test 2;
                op = 7'b1100011;
                funct3 = 3'b000;
                funct7_5 = 1'b0;
                zero = 1'b0;
                #1;
                if (alucontrol === 3'b001)
                    $display ("Test 2 PASSED: alucontrol = %b for beq control signal", alucontrol);
                else
                    $display ("Test 2 FAILED: expected alucontrol = 001, got %b", alucontrol);
                
                //Test 3:
                op = 7'b0110011;
                funct3 = 3'b000;
                {op[5],funct7_5} = 2'b10;
                zero = 1'b0;
                #1;
                if (alucontrol === 3'b000)
                    $display ("Test 3 PASSED: alucontrol = %b for add control signal", alucontrol);
                else
                    $display ("Test 3 FAILED: expected alucontrol = 000, got %b", alucontrol);
                
                //Test 4:
                op = 7'b1100011;
                funct3 = 3'b000;
                funct7_5 = 1'b0;
                zero = 1'b1;
                #1;
                if (pcsrc === 1'b1)
                    $display ("Test 4 PASSED: comb circuit tested with branch and zero = 1 and no jump");
                else
                    $display ("Test 4 FAILED: expected 1, got %b", pcsrc);
                
                //Test 5:
                op = 7'b1100011;
                funct3 = 3'b000;
                funct7_5 = 1'b0;
                zero = 1'b0;
                #1;
                if (pcsrc === 1'b0)
                    $display ("Test 5 PASSED: comb circuit tested with branch=1, zero=0 and no jump");
                else
                    $display ("Test 5 FAILED: expected 0, got %b", pcsrc);
                
                //Test 6:
                op = 7'b1101111;
                funct3 = 3'b000;
                funct7_5 = 1'b0;
                zero = 1'b0;
                #1;
                if (pcsrc === 1'b1)
                    $display ("Test 6 PASSED: comb circuit tested with jump = 1");
                else
                    $display ("Test 6 FAILED: expected 1, got %b", pcsrc);
                    
                //Test 7:
                op = 7'b0010011;
                funct3 = 3'b000;
                funct7_5 = 1'b0;
                zero = 1'b0;
                #1;
                if (pcsrc === 1'b0)
                    $display ("Test 7 PASSED: comb circuit tested with neither branch nor jump");
                else
                    $display ("Test 7 FAILED: expected 0, got %b", pcsrc);
                    
                //Test 8:
                op = 7'b1111111;
                funct3 = 3'b000;
                funct7_5 = 1'b0;
                zero = 1'b0;
                #1;
                if ({alucontrol,pcsrc} === 4'bx)
                    $display ("Test 8 PASSED: default case tested");
                else
                    $display ("Test 8 FAILED: expected xxxx, got %b", {alucontrol,pcsrc});
                
                $finish;
                
            end
        
endmodule
