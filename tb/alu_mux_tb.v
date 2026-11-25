`timescale 1ns / 1ps

module alu_mux_tb();
    reg alusrc;
    reg [31:0] rd2, immext;
    wire [31:0] srcb;
    
    alu_mux dut(
        .alusrc(alusrc),
        .rd2(rd2), .immext(immext),
        .srcb(srcb)
        );
        
        initial
            begin
                rd2 = 32'h0123_4567;
                immext = 32'h89AB_CDEF;
                
                // Test 1:
                alusrc = 1'b0;
                #1;
                
                if (srcb === 32'h0123_4567)
                    $display ("Test 1 PASSED: srcb = rd2 @ alusrc = 0");
                else
                    $display ("Test 1 FAILED: expected 01234567, got %h", srcb);
                
                //Test 2:
                alusrc = 1'b1;
                #1;
                
                if (srcb === 32'h89AB_CDEF)
                    $display ("Test 2 PASSED: srcb = immext @ alusrc = 1");
                else
                    $display ("Test 2 FAILED: expected 89ABCDEF, got %h", srcb);
                    
                $finish;
                
            end
    
endmodule
