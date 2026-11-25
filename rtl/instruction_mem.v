`timescale 1ns / 1ps

module instruction_mem(
    input [31:0] a,
    output [31:0] rd
    );
    reg [31:0] mem [2047:0];
    
    initial
        $readmemh("program.hex", mem, 1024, 1029);
    
    assign rd = mem[a[31:2]];
    
endmodule
