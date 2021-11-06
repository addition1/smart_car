`timescale  1ns/1ns 
 
module tb_remote_ctrl;
    parameter  T = 20;                 // 时钟周期为20ns

    reg                  sys_clk;       // 时钟信号
    reg                  sys_rst_n;       // 复位信号
    reg         [2:0]     data;       
	wire [3:0]  motor;
	
initial begin
    sys_clk            = 1'b0;
    sys_rst_n          = 1'b0;     // 复位
    #(T+1)  sys_rst_n  = 1'b1;     // 在第21ns的时候复位信号信号拉高
end

initial begin
#50;
repeat(10)
#200 data={$random}%5;
end
always #(T/2) sys_clk = ~sys_clk;

remote_ctrl u_remote_ctrl(
    .clk   (sys_clk),     // 时钟信号
    .rst_n  (sys_rst_n ),        // 复位信号
    .data   (data),        
	.motor (motor)
	 
    );
	
endmodule