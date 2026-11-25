`timescale 1ns / 1ps

module instruction_mem_tb();
    reg [31:0] a;
    wire [31:0] rd;
    
    instruction_mem dut(
        .a(a),
        .rd(rd)
        );
        
        initial
            begin
                dut.mem[0] = 32'h0020_81B3; // add x3, x1, x2
                dut.mem[1] = 32'h00A0_0293; // addi x5, x0, 10
                dut.mem[2] = 32'hFFA9_A383; // lw x7, -6(x19)
                
                // Test 1:
                a = 32'h0000_0000;
                #1;
                if (rd === 32'h0020_81B3)
                    $display ("Test 1 PASSED: rd returns correct instruction, rd = %h", rd);
                else
                    $display ("Test 1 FAILED: expected 002081B3, got %h", rd);
                
                // Test 2:
                a = 32'h0000_0004;
                #1;
                if (rd === 32'h00A0_0293)
                    $display ("Test 2 PASSED: rd returns correct instruction, rd = %h", rd);
                else
                    $display ("Test 2 FAILED: expected 00A00293, got %h", rd);
                
                // Test 3:
                a = 32'h0000_0008;
                #1;
                if (rd === 32'hFFA9_A383)
                    $display ("Test 3 PASSED: rd returns correct instruction, rd = %h", rd);
                else
                    $display ("Test 3 FAILED: expected FFA9A383, got %h", rd);
                    
                $finish;
                
            end

endmodule
