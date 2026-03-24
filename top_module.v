`timescale 1ns / 1ps

module top_module(
    input clk,
    input rst,
    input start,
    input [7:0] master_data,
    input [7:0] slave_data,

    output done,
    output [7:0] master_rx,
    output [7:0] slave_rx
);


wire mosi, miso, cs_n, slave_clk;


master u_master (
    .clk(clk),
    .rst(rst),
    .start(start),
    .miso(miso),
    .data_out(master_data),
    .mosi(mosi),
    .slave_clk(slave_clk),
    .cs_n(cs_n),
    .done(done),
    .data_in(master_rx)
);


slave u_slave (
    .slave_clk(slave_clk),
    .cs_n(cs_n),
    .rst(rst),
    .mosi(mosi),
    .data_in(slave_data),
    .miso(miso),
    .data_out(slave_rx)
);

endmodule
