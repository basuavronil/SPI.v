`timescale 1ns / 1ps
module tb_top;

// Inputs
reg clk;
reg rst;
reg start;
reg [7:0] master_data;
reg [7:0] slave_data;

// Outputs
wire done;
wire [7:0] master_rx;
wire [7:0] slave_rx;

// 🔷 Instantiate TOP MODULE
top_module dut (
    .clk(clk),
    .rst(rst),
    .start(start),
    .master_data(master_data),
    .slave_data(slave_data),
    .done(done),
    .master_rx(master_rx),
    .slave_rx(slave_rx)
);

always #5 clk = ~clk;
initial
begin
    
    clk = 0;
    rst = 0;
    start = 0;

    master_data = 8'hA5; // Master sends
    slave_data  = 8'h3C; // Slave sends

    #10 rst = 1;

    #10 start = 1;
    #10 start = 0;

    wait(done);

    // Display results
    $display("=================================");
    $display("Master Sent     = %h", master_data);
    $display("Slave Received  = %h", slave_rx);
    $display("Slave Sent      = %h", slave_data);
    $display("Master Received = %h", master_rx);
    $display("=================================");
    #20 $finish;
end
// 🔷 MONITOR SIGNALS
initial
begin
    $monitor("T=%0t | DONE=%b | Master_RX=%h | Slave_RX=%h",
              $time, done, master_rx, slave_rx);
end
endmodule
