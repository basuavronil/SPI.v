module slave(
 input rst, slave_clk, mosi, cs_n,
 input [7:0] data_out,
 output reg miso,
 output reg [7:0] data_in
 );
 reg [7:0] shift_reg;
 reg [2:0] bit_count;
 always@(negedge cs_n or negedge rst)
 begin
  if (!rst)
    begin
      miso <= 1'd0;
      data_in <= 8'd0; 
      shift_reg <= 8'd0;
      bit_count <= 3'd0;
    end
  else 
    begin
      shift_reg <= data_out;
      bit_count <=  3'd7;
    end
 end
 
 always@(negedge slave_clk)
 begin
   //mosi
   if (!cs_n)
   data_in <= mosi;
 end 
 
 always@(posedge slave_clk)
 begin
   //miso
   if (!cs_n)
   begin
   miso <= shift_reg[bit_count];
      if (bit_count == 0)
         bit_count <= 3'd7;
      else 
         bit_count <= bit_count - 1;
   end
 end
   

endmodule
