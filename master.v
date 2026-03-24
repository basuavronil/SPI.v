`timescale 1ns / 1ps

module master(
    input clk,
    input rst,
    input start,
    input miso,
    input [7:0] data_out,

    output reg mosi,
    output reg cs_n,
    output reg slave_clk,
    output reg done,
    output reg [7:0] data_in
);

reg [7:0] shift_reg;
reg [2:0] bit_count;
reg busy;

always @(posedge clk or negedge rst)
begin
    if (!rst)
    begin
        slave_clk <= 0;
        cs_n <= 1;
        mosi <= 0;
        done <= 0;
        busy <= 0;
        bit_count <= 3'd7;
        shift_reg <= 0;
        data_in <= 0;
    end
    else
    begin
        done <= 0; // default

        if (start && !busy)
        begin
            busy <= 1;
            cs_n <= 0;
            shift_reg <= data_out;
            bit_count <= 3'd7;
            slave_clk <= 0;
        end
        
        else if (busy)
        begin
            slave_clk <= ~slave_clk;
            if (slave_clk == 0)
            begin
                mosi <= shift_reg[bit_count]; //send
            end
            else
            begin
                data_in[bit_count] <= miso; //receive

                if (bit_count == 0)
                begin
                    busy <= 0;
                    cs_n <= 1;
                    done <= 1;
                end
                else
                begin
                    bit_count <= bit_count - 1;
                end
            end
        end
    end
end

endmodule
