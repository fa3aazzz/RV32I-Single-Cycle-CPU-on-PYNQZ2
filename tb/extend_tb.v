`timescale 1ns / 1ps

module extend_tb();
    reg [1:0] immsrc;
    reg [31:7] instr;
    wire [31:0] immext;
    
    extend dut(
        .immsrc(immsrc),
        .instr(instr),
        .immext(immext)
        );
        
        reg [31:0] full_instr;
        
        initial
            begin
                //Test 1: I-type
                immsrc = 2'b00;
                full_instr = 32'hFFC4A303;
                instr = full_instr[31:7];
                #1;
                
                if (immext === 32'hFFFFFFFC)
                    $display ("Test 1 PASSED: MSB sign extended for I-type Instruction, immext = %h", immext);
                else
                    $display ("Test 1 FAILED: expected FFFFFFFC, got %h", immext);
                
                //Test 2: S-type
                immsrc = 2'b01;
                full_instr = 32'h0064A423;
                instr = full_instr[31:7];
                #1;
                
                if (immext === 32'h00000008)
                    $display ("Test 2 PASSED: MSB sign extended for S-type Instruction, immext = %h", immext);
                else
                    $display ("Test 2 FAILED: expected 00000008, got %h", immext);
                
                //Test 3: B-type
                immsrc = 2'b10;
                full_instr = 32'hFE420AE3;
                instr = full_instr[31:7];
                #1;
                
                if (immext === 32'hFFFFFFF4)
                    $display ("Test 3.1 PASSED: MSB sign extended for B-type Instruction, immext = %h", immext);
                else
                    $display ("Test 3.1 FAILED: expected FFFFFFF4, got %h", immext);
                
                if (immext[0] === 1'b0)
                    $display ("Test 3.2 PASSED: LSB forced to %b", immext[0]);
                else
                    $display ("Test 3.2 FAILED: expected 0, got %b", immext[0]);
                
                //Test 4: J-type
                immsrc = 2'b11;
                full_instr = 32'h008000EF;
                instr = full_instr[31:7];
                #1;
                
                if (immext === 32'h00000008)
                    $display ("Test 4.1 PASSED: MSB sign extended for J-type Instruction, immext = %h", immext);
                else
                    $display ("Test 4.1 FAILED: expected 00000008, got %h", immext);
                
                if (immext[0] === 1'b0)
                    $display ("Test 4.2 PASSED: LSB forced to %b", immext[0]);
                else
                    $display ("Test 4.2 FAILED: expected 0, got %b", immext[0]);
                
                $finish;
                
            end
    
endmodule
