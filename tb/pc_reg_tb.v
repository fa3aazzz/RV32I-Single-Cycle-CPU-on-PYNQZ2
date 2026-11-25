`timescale 1ns / 1ps

module pc_reg_tb();
    reg clk, reset;
    reg [31:0] pcnext;
    wire [31:0] pc;

    pc_reg dut(
        .clk(clk), .reset(reset),
        .pcnext(pcnext),
        .pc(pc)
        );

    always #5 clk = ~clk;

    initial
        begin
            clk = 0;
            reset = 1;
            pcnext = 32'h0;
            @(posedge clk); #1;

            if (pc === 32'h00001000)
                $display("Test 1 PASSED: reset forces pc to 00001000, pc = %h", pc);
            else
                $display("Test 1 FAILED: expected 00001000, got %h", pc);

            reset = 0;
            pcnext = 32'h00002024;
            @(posedge clk); #1;

            if (pc === 32'h00002024)
                $display("Test 2 PASSED: normal load resumes after reset deasserted, pc = %h", pc);
            else
                $display("Test 2 FAILED: expected 00002024, got %h", pc);

            $finish;
        end
endmodule
