`timescale 1 ns/ 1 ns
module tb_top_key();

//parameter define
parameter T = 20;

//reg define
reg  sys_clk;
reg  sys_rst_n;
reg       key0;             //外部按键输入
reg      key1; 
reg       key2; 
reg       key3;
//reg  key_value;

// wire define                                               
wire [1:0] sel_type;        //模式控制

//*****************************************************
//**                    main code                  
//*****************************************************

//给信号初始值
initial begin
    key0                         <= 1'b1;
	key1                         <= 1'b1;
	key2                         <= 1'b1;
	key3                         <= 1'b1;
    sys_clk                      <= 1'b0;
    sys_rst_n                    <= 1'b0; 
    #20           sys_rst_n      <= 1'b1;  //在第20ns的时候复位信号信号拉高 
    #30           key0            <= 1'b0;  //在第50ns的时候按下按键
    #20           key0            <= 1'b1;  //模拟抖动
    #20           key0            <= 1'b0;  //模拟抖动
    #20           key0            <= 1'b1;  //模拟抖动
    #20           key0            <= 1'b0;  //模拟抖动
    #170          key0            <= 1'b1;  //在第300ns的时候松开按键
    #20           key0            <= 1'b0;  //模拟抖动
    #20           key0            <= 1'b1;  //模拟抖动
    #20           key0            <= 1'b0;  //模拟抖动
    #20           key0            <= 1'b1;  //模拟抖动
    #170         key1            <= 1'b0;
    #20           key1            <= 1'b1;
    #20           key1            <= 1'b0;
    #20          key1            <= 1'b1;
    #20          key1            <= 1'b0;
    #170        key1            <= 1'b1;
    #20          key1            <= 1'b0;
    #20          key1            <= 1'b1;
    #20           key1            <= 1'b0;
    #20           key1            <= 1'b1;
end

//50Mhz的时钟，周期则为1/50Mhz=20ns,所以每10ns，电平取反一次  
 always # (T/2) sys_clk <= ~sys_clk;

//例化key_beep模块                        
top_key u1 (
	.sys_clk (sys_clk),
	.sys_rst_n (sys_rst_n),
                .key0 (key0),              //外部按键输入
	.key1 (key1), 
	.key2 (key2), 
	.key3 (key3),
	.sel_type (sel_type)
);           
                                       
endmodule
