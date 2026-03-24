`timescale 1ns / 1ps

module slave(
    input slave_clk,
    input cs_n,
    input rst,
    input mosi,
    input [7:0] data_in,   // data to send to master

    output reg miso,
    output reg [7:0] data_out // received from master
);

reg [2:0] bit_count;

always @(posedge slave_clk or negedge rst)
begin
    if (!rst)
    begin
        bit_count <= 3'd7;
        data_out <= 0;
        miso <= 0;
    end
    else if (!cs_n)
    begin
        // 🔹 RECEIVE from master (sample MOSI)
        data_out[bit_count] <= mosi;

        // 🔹 SEND to master (drive MISO)
        miso <= data_in[bit_count];

        // 🔹 BIT COUNT UPDATE
        if (bit_count == 0)
            bit_count <= 3'd7;
        else
            bit_count <= bit_count - 1;
    end
end

endmodule
