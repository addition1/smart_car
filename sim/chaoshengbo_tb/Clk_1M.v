module Clk_1M( 
input clk_in, 
input  rst,
output  clk_out);
reg [4:0] div_cnt;
reg div_clk;

//时钟分频,50Mhz/(2*(24+1))=8khz,T=1us
always @(posedge clk_in or negedge rst  ) begin
    if (!rst) begin
        div_cnt <= 5'd0;
        div_clk <= 1'b0;
    end    
    else if(div_cnt == 5'd24) begin
        div_cnt <= 5'd0;
        div_clk <= ~div_clk;
    end    
    else
        div_cnt = div_cnt + 5'b1;
end

assign clk_out = div_clk;
endmodule