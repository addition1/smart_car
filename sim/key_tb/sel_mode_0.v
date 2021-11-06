//工作模式选择（按键操作）
module sel_mode_0(
input clk,
input rst_n,
input        key_value0,	//消抖后的按键信号
input        key_flag0,    //按键有效信号
input        key_value1,	//消抖后的按键信号
input        key_flag1,    //按键有效信号
input        key_value2,	//消抖后的按键信号
input        key_flag2,    //按键有效信号
input        key_value3,	//消抖后的按键信号
input        key_flag3,    //按键有效信号
output reg  [1:0] sel_type        //模式控制
);
//reg [1:0] select;
//reg  [2:0] pwm;
always @(posedge clk or negedge rst_n) begin
/*if(!rst_n)begin
	sel_type<=2'b00;
	sel_pwm<=3'b010;
	end
else*/ if(key_flag0 && (~key_value0))  //判断按键是否有效按下
	sel_type<=2'b00;
else if(key_flag1 && (~key_value1))  //判断按键是否有效按下
	sel_type<=2'b01;
else if(key_flag2 && (~key_value2))  //判断按键是否有效按下
	sel_type<=2'b10;
else if(key_flag3 && (~key_value3))  //判断按键是否有效按下
	sel_type<=2'b11;
else;
end 

//assign sel_type=select;
//assign sel_pwm=pwm;

endmodule
