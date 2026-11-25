`timescale 1ns / 1ps

module result_mux(
    input [1:0] resultsrc,
    input [31:0] aluresult, readdata, pcplus4,
    output reg [31:0] result
    );
    
    always @(*)
        case (resultsrc)
            2'b00: result = aluresult;
            2'b01: result = readdata;
            2'b10: result = pcplus4;
            default: result = 32'bx;
        endcase
    
endmodule
