`timescale 1ns / 1ps

module pc4_adder_tb();
    reg [31:0] pc;
    wire [31:0] pcplus4;
    
    pc4_adder dut(
        .pc(pc),
        .pcplus4(pcplus4)
        );
        
        initial
            begin
                // Test 1:
                pc = 32'h0000_2024;
                #1;
                
                if (pcplus4 === 32'h0000_2028)
                    $display ("Test 1 PASSED: 00002024 + 00000004 = %h", pcplus4);
                else
                    $display ("Test 1 FAILED: expected 00002028, got %h", pcplus4);
                
                // Test 2:
                pc = 32'hFFFF_FFFF;
                #1;
                
                if (pcplus4 === 32'h0000_0003)
                    $display ("Test 2 PASSED: wraparound confirmed, pcplus4 = %h", pcplus4);
                else
                    $display ("Test 2 FAILED: expected 00000003, got %h", pcplus4);
                
                $finish;
                
            end

endmodule
