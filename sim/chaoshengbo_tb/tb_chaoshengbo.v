`timescale  1ns/1ns 

module tb_chaoshengbo;
parameter  T = 20;                // 时钟周期为20ns

reg sys_clk;
reg sys_rst_n;
reg echo;

wire [3:0]  motor;

initial begin
    sys_clk            = 1'b0;
    sys_rst_n          = 1'b0;     // 复位
    #(T+1)  sys_rst_n  = 1'b1;     // 在第21ns的时候复位信号信号拉高
end
initial begin
echo=1'b0;#100;
echo=1'b1;#580020;
echo=1'b0;#3000000;
echo=1'b1;#500000;
echo=1'b0;
//#60000;
//$stop;
end
always #(T/2) sys_clk = ~sys_clk;

chaoshengbo u_chaoshengbo(
.sys_clk (sys_clk),
.sys_rst_n (sys_rst_n),
.echo (echo),

.motor (motor)
);

endmodule