`timescale 1ns / 1ps

module br_adder_tb();
    reg [31:0] pc, immext;
    wire [31:0] pctarget;
    
    br_adder dut(
        .pc(pc), .immext(immext),
        .pctarget(pctarget)
        );
        
        initial
            begin
                // Test 1:
                pc = 32'h0000_2024;
                immext = 32'h0000_0004;
                #1;
                
                if (pctarget === 32'h0000_2028)
                    $display ("Test 1 PASSED: 00002024 + 00000004 = %h", pctarget);
                else
                    $display ("Test 1 FAILED: expected 00002028, got %h", pctarget);
                    
                //Test 2:
                pc = 32'hFFFF_FFFF;
                immext = 32'h0000_0004;
                #1;
                
                if (pctarget === 32'h0000_0003)
                    $display ("Test 2 PASSED: wraparound confirmed, pctarget = %h", pctarget);
                else
                    $display ("Test 2 FAILED: expected 00000003, got %h", pctarget);
                
                //test 3:
                pc = 32'h0000_0002;
                immext = 32'hFFFF_FFFC;
                #1;
                
                if (pctarget === 32'hFFFF_FFFE)
                    $display ("Test 3 PASSED: underflow, pctarget = %h", pctarget);
                else
                    $display ("Test 3 FAILED: expected FFFFFFFE, got %h", pctarget);
                
                $finish;
                
            end
    
endmodule
