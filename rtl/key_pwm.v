module key_pwm(
    input               sys_clk  ,    //50Mhz系统时钟
    input               sys_rst_n,    //系统复位，低有效
    input        [7:0]  key,          //按键输入信号
	 //input       [2:0]    sel_pwm,         //调速
    output [12:0] mod
    );
reg[12:0]speedmod;
assign mod=speedmod;
always @(posedge sys_clk or negedge sys_rst_n) begin
    if(!sys_rst_n) 
    speedmod<=13'd2500; 
    else if(key==8'd22)  
     speedmod<=13'd2000;
    else if (key==8'd25)  
      speedmod<=13'd2500;
    else if (key==8'd13)  
       speedmod<=13'd3500; 
    else
        speedmod=13'd2500;  
end

endmodule 