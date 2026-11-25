`timescale 1ns / 1ps

module result_mux_tb();
    reg [1:0] resultsrc;
    reg [31:0] aluresult, readdata, pcplus4;
    wire [31:0] result;
    
    result_mux dut(
        .resultsrc(resultsrc),
        .aluresult(aluresult), .readdata(readdata), .pcplus4(pcplus4),
        .result(result)
        );
        
        initial
            begin
                aluresult = 32'h0000_2002;
                readdata = 32'h0000_2005;
                pcplus4 = 32'h0000_2006;
                
                // Test 1:
                resultsrc = 2'b00;
                #1;
                
                if (result === 32'h0000_2002)
                    $display ("Test 1 PASSED: result = aluresult @ resultsrc = 00");
                else
                    $display ("Test 1 FAILED: expected 00002002, got %h", result);
                
                // Test 2:
                resultsrc = 2'b01;
                #1;
                
                if (result === 32'h0000_2005)
                    $display ("Test 2 PASSED: result = readdata @ resultsrc = 01");
                else
                    $display ("Test 2 FAILED: expected 00002005, got %h", result);
                    
                // Test 3:
                resultsrc = 2'b10;
                #1;
                
                if (result === 32'h0000_2006)
                    $display ("Test 3 PASSED: result = pcplus4 @ resultsrc = 10");
                else
                    $display ("Test 3 FAILED: expected 00002006, got %h", result);
                    
                // Test 4:
                resultsrc = 2'b11;
                #1;
                
                if (result === 32'bx)
                    $display ("Test 4 PASSED: result = %h @ resultsrc = 11", result);
                else
                    $display ("Test 4 FAILED: expected xxxxxxxx, got %h", result);
                
                $finish;
                
            end
                
endmodule
