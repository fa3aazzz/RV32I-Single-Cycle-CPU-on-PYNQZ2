`timescale 1ns / 1ps

module alu_tb();
    reg [31:0] srca, srcb;
    reg [2:0] alucontrol;
    wire [31:0] aluresult;
    wire zero;
    
    alu dut(
        .srca(srca),.srcb(srcb),
        .alucontrol(alucontrol),
        .aluresult(aluresult),
        .zero(zero)
        );
    
    initial
        begin
            // Test 1: ADD, confirm unsigned wraparound
            srca = 32'hFFFF_FFFF;
            srcb = 32'h0000_0001;
            alucontrol = 3'b000;
            #1;
            
            if (aluresult === 32'h0000_0000)
                $display ("Test 1 PASSED: wraparound confirms, aluresult = %h", aluresult);
            else
                $display ("Test 1 FAILED: expected 00000000, got %h", aluresult);
            
            // Test 2: SUB, confirm two's complement negative result
            srca = 32'h0000_0005;
            srcb = 32'h0000_000A;
            alucontrol = 3'b001;
            #1;
            
            if (aluresult === 32'hFFFF_FFFB)
                $display ("Test 2 PASSED: achieved negative result, aluresult = %h", aluresult);
            else
                $display ("Test 2 FAILED: expected FFFFFFFB, got %h", aluresult);
                
            // Test 3: AND 0xAAAAAAAA & 0x55555555, confirm every bit lane correct
            srca = 32'hAAAA_AAAA;
            srcb = 32'h5555_5555;
            alucontrol = 3'b010;
            #1;
            
            if (aluresult === 32'h0000_0000)
                $display ("Test 3 PASSED: AND works properly, aluresult = %h", aluresult);
            else
                $display ("Test 3 FAILED: expected 00000000, got %h", aluresult);
            
            // Test 4: OR 0xAAAAAAAA | 0x55555555, confirm every bit lane correct
            srca = 32'hAAAA_AAAA;
            srcb = 32'h5555_5555;
            alucontrol = 3'b011;
            #1;
            
            if (aluresult === 32'hFFFF_FFFF)
                $display ("Test 4 PASSED: OR works properly, aluresult = %h", aluresult);
            else
                $display ("Test 4 FAILED: expected FFFFFFFF, got %h", aluresult);
            
            // Test 5: SLT positive < positive, true case
            srca = 32'h0000_0003;
            srcb = 32'h0000_0005;
            alucontrol = 3'b101;
            #1;
            
            if (aluresult === 32'h0000_0001)
                $display ("Test 5 PASSED: aluresult = %h", aluresult);
            else
                $display ("Test 5 FAILED: expected 00000001, got %h", aluresult);
            
            // Test 6: SLT positive < positive, false case
            srca = 32'h0000_0005;
            srcb = 32'h0000_0003;
            alucontrol = 3'b101;
            #1;
            
            if (aluresult === 32'h0000_0000)
                $display ("Test 6 PASSED: aluresult = %h", aluresult);
            else
                $display ("Test 6 FAILED: expected 00000000, got %h", aluresult);
            
            // Test 7: SLT negative < positive, true case
            srca = 32'hFFFF_FFFD;
            srcb = 32'h0000_0005;
            alucontrol = 3'b101;
            #1;
            
            if (aluresult === 32'h0000_0001)
                $display ("Test 7 PASSED: aluresult = %h", aluresult);
            else
                $display ("Test 7 FAILED: expected 00000001, got %h", aluresult);
            
            // Test 8: SLT positive < negative, false case
            srca = 32'h0000_0005;
            srcb = 32'hFFFF_FFFD;
            alucontrol = 3'b101;
            #1;
            
            if (aluresult === 32'h0000_0000)
                $display ("Test 8 PASSED: aluresult = %h", aluresult);
            else
                $display ("Test 8 FAILED: expected 00000000, got %h", aluresult);
            
            // Test 9: SLT signed trap case: most negative < 1
            srca = 32'h8000_0000;
            srcb = 32'h0000_0001;
            alucontrol = 3'b101;
            #1;
            
            if (aluresult === 32'h0000_0001)
                $display ("Test 9 PASSED: signed trap case, aluresult = %h", aluresult);
            else
                $display ("Test 9 FAILED: expected 00000001, got %h", aluresult);
            
            // Test 10: Zero flag, true case
            srca = 32'h0000_2030;
            srcb = 32'h0000_2030;
            alucontrol = 3'b001;
            #1;
            
            if (zero === 1'b1)
                $display ("Test 10 PASSED: zero flag checked, aluresult = %b", zero);
            else
                $display ("Test 10 FAILED: expected 1, got %b", zero);
            
            // Test 11: Zero flag, false case
            srca = 32'h0000_2028;
            srcb = 32'h0000_2024;
            alucontrol = 3'b001;
            #1;
            
            if (zero === 1'b0)
                $display ("Test 11 PASSED: zero flag checked, aluresult = %b", zero);
            else
                $display ("Test 11 FAILED: expected 0, got %b", zero);
            
            // Test 12: Undefined ALUControl code, default case triggers
            alucontrol = 3'b111;
            #1;
            
            if (aluresult === 32'bx)
                $display ("Test 12 PASSED: default case triggered, aluresult = %b", aluresult);
            else
                $display ("Test 12 FAILED: default case, got %b", aluresult);
            
            $finish;
        end

endmodule
