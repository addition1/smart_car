module top_key(
input sys_clk,
input sys_rst_n,
input       key0,              //外部按键输入
input       key1, 
input       key2, 
input       key3,

output  [1:0] sel_type      //模式控制 
);

wire        key_value0;	//消抖后的按键信号
wire        key_flag0;   //按键有效信号
wire        key_value1;	//消抖后的按键信号
wire        key_flag1;   //按键有效信号
wire        key_value2;	//消抖后的按键信号
wire        key_flag2;   //按键有效信号
wire        key_value3;	//消抖后的按键信号
wire        key_flag3;   //按键有效信号

sel_mode_0 u_sel_mode_0(
.clk (sys_clk),
.rst_n (sys_rst_n),
.key_value0 (key_value0),	//消抖后的按键信号
.key_flag0 (key_flag0),    //按键有效信号
.key_value1 (key_value1),	//消抖后的按键信号
.key_flag1 (key_flag1),    //按键有效信号
.key_value2 (key_value2),	//消抖后的按键信号
.key_flag2 (key_flag2),    //按键有效信号
.key_value3 (key_value3),	//消抖后的按键信号
.key_flag3 (key_flag3),    //按键有效信号
.sel_type (sel_type)        //模式控制
);

key_debounce u_key_debounce(
.sys_clk (sys_clk),          //外部50M时钟
.sys_rst_n (sys_rst_n),        //外部复位信号，低有效
    
.key0 (key0),              //外部按键输入
.key1 (key1), 
.key2 (key2), 
.key3 (key3), 
.key_flag0 (key_flag0),         //按键数据有效信号
.key_value0 (key_value0),         //按键消抖后的数据  
.key_flag1 (key_flag1),         //按键数据有效信号
.key_value1 (key_value1),         //按键消抖后的数据  
.key_flag2 (key_flag2),         //按键数据有效信号
.key_value2 (key_value2),         //按键消抖后的数据  
.key_flag3 (key_flag3),         //按键数据有效信号
.key_value3 (key_value3)        //按键消抖后的数据 
    );
endmodule	