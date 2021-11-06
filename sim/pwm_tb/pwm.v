module pwm(
input clk,
input [2:0]pulse_width,
output out
);

reg [2:0]cnt;
reg wave;
assign out = wave;
always @(posedge clk )
if(cnt<3'd5)
 cnt <= cnt + 3'd1;
else 
 cnt <= 0;
 
always @(posedge clk)
if(cnt<pulse_width)
 wave <= 1;
else 
 wave <= 0;

endmodule