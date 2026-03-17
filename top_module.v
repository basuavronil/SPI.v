module top_module(
 input rst, clk, start, 
 input [7:0] data_out,
 input [7:0] m_out, s_out,
 output [7:0] m_in, s_in,
 output done
    );
 reg slave_clk;
 reg mosi;
 reg miso;
 
 master dut1(
 .rst(rst),
 .clk(clk),
 .start(start),
 .data_out(m_out),
 .m_out(m_out),
 .slave_clk(slave_clk),
 .mosi(mosi),
 .done(done),
 .cs_n(cs_n),
 .data_in(m_in)
 );
 
 slave dut2(
 .rst(rst),
 .slave_clk(slave_clk),
 .mosi(mosi),
 .miso(miso),
 .cs_n(cs_n),
 .data_out(s_out),
 .data_in(s_in)
 );
 
endmodule
