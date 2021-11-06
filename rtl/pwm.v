module pwm(
input clk,
input [12:0]pulse_width,
output out
);

reg [12:0]cnt;
reg wave;
assign out = wave;
always @(posedge clk )
if(cnt<13'd5000)
 cnt <= cnt + 13'd1;
else 
 cnt <= 0;
 
always @(posedge clk)
if(cnt<pulse_width)
 wave <= 1;
else 
 wave <= 0;

endmodule