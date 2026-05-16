`timescale 1ns / 1ps

module uart_top(
    input rst,
    input [7:0] data_in,
    input wr_en,
    input clk,
    input rdy_clr,

    output rdy,
    output busy,
    output [7:0] data_out
);

wire rx_clk_en;
wire tx_clk_en;

wire tx;

baud_rate_generator bg(
    .clk(clk),
    .rst(rst),
    .tx_enb(tx_clk_en),
    .rx_enb(rx_clk_en)
);

uart_transmitter ut(
    .clk(clk),
    .rst(rst),
    .wr_enb(wr_en),
    .enb(tx_clk_en),
    .data_in(data_in),
    .tx(tx),
    .busy(busy)
);

uart_receiver ur(
    .clk(clk),
    .rst(rst),
    .rx(tx),
    .rdy_clr(rdy_clr),
    .clk_en(tx_clk_en),
    .rdy(rdy),
    .data_out(data_out)
);

endmodule