`timescale 1ns / 1ps

module regfile(
    input clk, we3,
    input [4:0] a1, a2, a3,
    input [31:0] wd3,
    output [31:0] rd1, rd2
    );  
    
    reg [31:0] regs [31:0];
    
    assign rd1 = ( a1 == 5'd0) ? 32'd0 : regs[a1];
    assign rd2 = ( a2 == 5'd0) ? 32'd0 : regs[a2];
    
    always @(posedge clk)
        if (we3 && a3 != 5'd0)
            regs[a3] <= wd3;
            
endmodule