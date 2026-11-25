`timescale 1ns / 1ps

module rv32i_fpga_top(
    input  clk_125mhz,
    input  reset,
    output [3:0] led
    );

    wire clk_50mhz, locked;

    clk_wiz_0 clk_gen (
        .clk_in1  (clk_125mhz),
        .clk_out1 (clk_50mhz),
        .reset    (reset),
        .locked   (locked)
    );

    wire [31:0] mmio_addr, mmio_wdata, dbg_pc;
    wire mmio_we;

    rv32i cpu (
        .clk       (clk_50mhz),
        .reset     (reset),
        .mmio_addr (mmio_addr),
        .mmio_wdata(mmio_wdata),
        .mmio_we   (mmio_we),
        .dbg_pc    (dbg_pc)
    );

    // VIO Core for JTAG hardware debugging
    vio_0 debug_vio (
        .clk        (clk_50mhz),
        .probe_in0  (dbg_pc),
        .probe_in1  (mmio_wdata)
    );

    // MMIO LED Register
    reg [3:0] led_reg;
    always @(posedge clk_50mhz)
        if (reset)
            led_reg <= 4'b0000;
        else if (mmio_we && mmio_addr == 32'hFFFFFFF0)
            led_reg <= mmio_wdata[3:0];

    assign led = led_reg;

endmodule
