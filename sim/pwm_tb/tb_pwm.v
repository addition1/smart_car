`timescale  1ns/1ns                // 定义仿真时间单位1ns和仿真时间精度为1ns
module tb_pwm;
parameter  T = 20;                 // 时钟周期为20ns

reg  sys_clk;                      // 时钟信号
reg  [2:0] pwm0;

wire out;

//reg   [2:0] pwm0;
 initial begin
    sys_clk            = 1'b0;
    //sys_rst_n          = 1'b0;     // 复位
    //#(T+1)  sys_rst_n  = 1'b1;     // 在第21ns的时候复位信号信号拉高
end
 initial begin
 while(1)begin
 #200 pwm0={$random}%6;
 end
 end
 
always #(T/2) sys_clk = ~sys_clk;

 pwm u_pwm(
.clk (sys_clk),
.pulse_width (pwm0),
.out (out)
);

endmodule