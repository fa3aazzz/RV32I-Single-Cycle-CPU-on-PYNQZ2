`timescale 1ns / 1ps

module regfile_tb;
    reg clk, we3;
    reg [4:0] a1, a2, a3;
    reg [31:0] wd3;
    wire [31:0] rd1, rd2;
    
    regfile dut (
        .clk(clk), .we3(we3),
        .a1(a1), .a2(a2), .a3(a3),
        .wd3(wd3),
        .rd1(rd1), .rd2(rd2)
        );
        
    always #5 clk = ~clk;
    
    initial
        begin
            clk = 0;
            we3 = 0;
            a1 = 0;
            a2 = 0;
            a3 = 0;
            wd3 = 0;
            
            // Test 1:
            a3 = 5'd5;
            wd3 = 32'hAAAA_AAAA;
            we3 = 1;
            @(posedge clk);
            #1; we3 = 0;
            
            a1 = 5'd5; #1;
            
            if (rd1 === 32'hAAAA_AAAA)
                $display ("PASS Test 1: x5 read back correctly, rd1 = %h", rd1);
            else
                $display ("FAIL Test 1: expected AAAAAAAA, got %h", rd1);
                
            // Test 2:
            a3 = 5'd0;
            wd3 = 32'hFFFF_FFFF;
            we3 = 1;
            @(posedge clk);
            #1; we3 = 0;
            
            a1 = 5'd0; #1;
            
            if (rd1 === 32'h0000_0000)
                $display ("PASS Test 2: x0 stays 0, rd1 = %h", rd1);
            else
                $display ("FAIL Test 2: expected 0, got %h", rd1);
            
            //Test 3:
            a3 = 5'd5;
            wd3 = 32'h1234_5678;
            we3 = 1;
            @(posedge clk);
            #1; we3 = 0;
            
            a1 = 5'd5; #1;
            
            if (rd1 === 32'h1234_5678)
                $display ("PASS Test 3: x5 overwritten to %h", rd1);
            else
                $display ("FAIL Test 3: expected 12345678, got %h", rd1);
                
            // Test 4:
            we3 = 1;
            wd3 = 32'h0000_2028;
            a3 = 5'd1;
            @(posedge clk);
            #1; we3 = 0;
            a1 = 5'd1; #1;
            
            we3 = 1;
            wd3 = 32'h0000_2030;
            a3 = 5'd2;
            @(posedge clk);
            #1; we3 = 0;
            a2 = 5'd2; #1;
            
            if (rd1 === 32'h0000_2028)
                $display ("PASS Test 4.1: x1 read back correctly, rd1 = %h", rd1);
            else 
                $display ("FAIL Test 4.1: expected 00002028, got %h", rd1);
                
            if (rd2 === 32'h0000_2030)
                $display ("PASS Test 4.2: x2 read back correctly, rd2 = %h", rd2);
            else 
                $display ("FAIL Test 4.2: expected 00002030, got %h", rd2);
            
            //Test 5:
            we3 = 0;
            wd3 = 32'h6666_7777;
            a3 = 5'd5;
            @(posedge clk); #1;
            
            a1 = 5'd5; #1;
            
            if (rd1 === 32'h1234_5678)
                $display ("PASS Test 5: No change to x5, rd1 = %h", rd1);
            else
                $display ("FAIL Test 5: x5 got overwritten, expected 12345678, got %h", rd1);
                
            $finish;
        end
            
endmodule
