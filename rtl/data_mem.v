`timescale 1ns / 1ps

module data_mem(
    input clk, we,
    input [31:0] a, wd,
    output [31:0] rd
    );
    reg [31:0] mem [4095:0];
    
    assign rd = mem[a[31:2]];
    
    always  @(posedge clk)
        if (we)
            mem[a[31:2]] <= wd;
    
endmodule
