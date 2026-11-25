`timescale 1ns / 1ps

module pc_mux_tb();
    reg pcsrc;
    reg [31:0] pcplus4, pctarget;
    wire [31:0] pcnext;
    
    pc_mux dut(
        .pcsrc(pcsrc),
        .pcplus4(pcplus4), .pctarget(pctarget),
        .pcnext(pcnext)
        );
        
        initial
            begin
                pctarget = 32'h0000_0032;
                pcplus4 = 32'h0000_0036;
                
                // Test 1:
                pcsrc = 1'b1;
                #1;
                
                if (pcnext === 32'h0000_0032)
                    $display ("Test 1 PASSED: pcnext = pctarget @ pcsrc = 1");
                else
                    $display ("Test 1 FAILED: expected 00000032, got %h", pcnext);
                
                //Test 2:
                pcsrc = 1'b0;
                #1;
                
                if (pcnext === 32'h0000_0036)
                    $display ("Test 2 PASSED: pcnext = pcplus4 @ pcsrc = 0");
                else
                    $display ("Test 2 FAILED: expected 00000036, got %h", pcnext);
                    
                $finish;
            end
endmodule
