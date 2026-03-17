module master(
 input clk, start, miso, rst,
 input [7:0] data_out,
 output reg done, cs_n, mosi, slave_clk,
 output reg [7:0] data_in
 );
 reg [7:0] shift_reg;
 reg [2:0] bit_count;
 reg busy;
 always@(posedge clk or negedge rst)
 begin
  if (!rst)
    begin
       slave_clk <= 0;
       done = 1'b0;
       cs_n = 1'd1;
       mosi = 1'd0;
       data_in = 8'd0;
       shift_reg = 8'd0;
       bit_count = 3'd7;
       busy = 1'd0;
    end
  else 
  begin
    if (start == 1'b1 && busy == 1'd0)
       begin
         busy <= 1'd0;
         cs_n <= 1'd0;
         shift_reg <= data_out; 
       end
    else if (busy == 1'd1)
        begin 
          slave_clk <= ~ slave_clk;
          if (slave_clk == 1'd0)
          //drive mosi
            mosi <= shift_reg;
          else 
            begin
          //drive miso
            data_in[bit_count] <= miso;
            if (bit_count == 0)
              begin
                 busy = 1'd0;
                 cs_n <= 1;
                 done <= 1;
              end 
            else 
              bit_count <= bit_count -1 ;
            end
              
       end
  end
   
 end
  
    
endmodule
