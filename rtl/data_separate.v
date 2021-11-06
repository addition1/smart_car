//红外接收到的控制码分类
module data_separate(
    input                  sys_clk   ,  //系统时钟
    //input                  sys_rst_n ,  //系统复位信号，低电平有效
	 input          [7:0]   data,
	 output    reg  [7:0]   data_mode,         //工作模式
	 output    reg  [7:0]   data_pwm,         //调速
	 output    reg  [7:0]   data_move         //红外遥控移动
);

always @(posedge sys_clk) begin
			case (data)
			8'd69:data_mode<=data;//红外遥控
			8'd70:data_mode<=data;//红外循迹
			8'd71:data_mode<=data;//红外跟随
			8'd68:data_mode<=data;//超声波避障
			8'd22:data_pwm<=data;//
			8'd25:data_pwm<=data;
			8'd13:data_pwm<=data;
			8'd24:data_move<=data;//前
			8'd08:data_move<=data;//左
			8'd90:data_move<=data;//右
			8'd82:data_move<=data;//后
			8'd28:data_move<=data;//停
			default:;
			endcase
	end 
endmodule