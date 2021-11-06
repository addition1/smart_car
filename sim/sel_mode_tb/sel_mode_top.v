module sel_mode_top(
input sys_clk,
input sys_rst_n,
input    [1:0] data,
input    [3:0] in0,in1,in2,in3,

output   [3:0] led,
output   [3:0] out
);

wire   [1:0] sel;

sel_mode u_sel_mode(
.clk (sys_clk),
.rst_n (sys_rst_n),
.data (data),
.sel (sel), 
.led (led)
);

 mux4_1 u_mux4_1(
 .out (out),
 .in0 (in0),
 .in1 (in1),
 .in2 (in2),
 .in3 (in3),
 .sel (sel));
 
 endmodule