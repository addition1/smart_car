`timescale 1ns/1ns

module tb_top_gensui;

parameter  T = 20;                 // 时钟周期为20ns

reg sys_clk;
reg sys_rst_n;
reg D1,D4;

wire [3:0] motor;

//reg  D;

initial begin
    sys_clk            = 1'b0;
    sys_rst_n          = 1'b0;     // 复位
    #(T+1)  sys_rst_n  = 1'b1;     // 在第21ns的时候复位信号信号拉高
end
initial begin
repeat(10)
begin
#100 D1={$random}%2;
     D4={$random}%2; 
	 end
end
always #(T/2) sys_clk = ~sys_clk;

gensui u_gensui(
.clk (sys_clk),
.rst_n (sys_rst_n),
.D1(D1),
.D4 (D4),
.motor (motor)
);

endmodule