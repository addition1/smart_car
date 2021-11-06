`timescale  1ns/1ns                // 定义仿真时间单位1ns和仿真时间精度为1ns

module sel_mode_tb;
parameter  T = 20;                 // 时钟周期为20ns

reg sys_clk;
reg sys_rst_n;
reg    [1:0] data;
reg     [3:0] in0,in1,in2,in3;

wire   [3:0] led;
wire   [3:0] out;

initial begin
	in0=4'b0001;
	in1=4'b0010;
	in2=4'b0100;
	in3=4'b1000;
    sys_clk            = 1'b0;
    sys_rst_n          = 1'b0;     // 复位
    #(T+1)  sys_rst_n  = 1'b1;     // 在第21ns的时候复位信号信号拉高
end

initial begin
while(1)
#100 data={$random}%4;
end 

always #(T/2) sys_clk = ~sys_clk;

sel_mode_top u_sel_mode_top(
.sys_clk (sys_clk),
.sys_rst_n (sys_rst_n),
.data (data),
.in0 (in0),
.in1 (in1),
.in2 (in2),
.in3 (in3),
.led (led),
.out (out)
);

endmodule