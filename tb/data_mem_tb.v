`timescale 1ns / 1ps

module data_mem_tb();
    reg clk, we;
    reg [31:0] a, wd;
    wire [31:0] rd;
    
    data_mem dut(
        .clk(clk), .we(we),
        .a(a), .wd(wd),
        .rd(rd)
        );
        
        always #5 clk = ~clk;
        
        initial
            begin
                clk = 0;
                we = 0;
                a = 0;
                wd = 0;
                
                //Test 1:
                a = 32'h0000_0000;
                we = 1;
                wd = 32'h1234_5678;
                @(posedge clk);
                #1;
                we = 0;
                
                if (rd === 32'h1234_5678)
                    $display ("Test 1 PASSED: read data correctly, rd = %h", rd);
                else
                    $display ("Test 1 FAILED: expected 12345678, got %h", rd);
                
                //Test 2:
                a = 32'h0000_0000;
                we = 1;
                wd = 32'h8765_4321;
                @(posedge clk)
                #1;
                we = 0;
                
                if (rd === 32'h8765_4321)
                    $display ("Test 2 PASSED: overwritten successful, rd = %h", rd);
                else
                    $display ("Test 2 FAILED: expected 87654321, got %h", rd);
                
                //Test 3:
                a = 32'h0000_0000;
                we = 0;
                wd = 32'h0000_0067;
                @(posedge clk);
                #1;
                
                if (rd === 32'h8765_4321)
                    $display ("Test 3 PASSED: No change, rd = %h", rd);
                else
                    $display ("Test 3 FAILED: expected 87654321, got %h", rd);
                
                //Test 4:
                a = 32'h0000_0004;
                we = 1;
                wd = 32'h6666_7777;
                @(posedge clk);
                #1;
                we = 0;
                
                if (rd === 32'h6666_7777)
                    $display ("Test 4.1 PASSED: address 4 holds new data, rd = %h", rd);
                else
                    $display ("Test 4.1 FAILED: expected 66667777, got %h", rd);
                
                a = 32'h0000_0000;
                #1;
                
                if (rd === 32'h8765_4321)
                    $display ("Test 4.2 PASSED: address 0 unaffected, rd = %h", rd);
                else
                    $display ("Test 4.2 FAILED: expected 87654321, got %h", rd);
                    
                $finish;
                
            end
        
endmodule
