module top_smart_car(
    input             sys_clk  ,    //系统时钟 
    input             sys_rst_n,    //系统复位信号，低电平有效
    input             remote_in,    //红外遥控接收信号
	 input             D1,D2,D3,D4,        //红外循迹接收信号
	 input             Echo,
	 input       key0,              //外部按键输入
    input       key1, 
    input       key2, 
    input       key3,              //外部按键输入
	 
    output  [3:0]     motor,
    output            Trig,
	 output  [3:0]      led
);

//wire define
wire  [7:0]   data;
wire  [7:0]   data_mode;         //工作模式
wire  [7:0]   data_pwm;         //调速
wire  [7:0]   data_move;         //红外遥控移动
wire   pwm;
wire  [12:0] mod;
wire  clk_1m;
wire  [19:0] dis; // 回波高电平持续时间us
wire  [1:0] sel;
wire  [3:0]     motor_0,motor_1,motor_2,motor_3;
wire  [1:0] sel_type;       //模式控制
//wire  [2:0]   sel_pwm;         //调速

wire        key_value0;	//消抖后的按键信号
wire        key_flag0;   //按键有效信号
wire        key_value1;	//消抖后的按键信号
wire        key_flag1;   //按键有效信号
wire        key_value2;	//消抖后的按键信号
wire        key_flag2;   //按键有效信号
wire        key_value3;	//消抖后的按键信号
wire        key_flag3;   //按键有效信号
//*****************************************************
//**                    main code
//*****************************************************

//红外遥控控制模块
remote_ctrl u_remote_ctrl(
    .clk            (sys_clk),   
    .rst_n          (sys_rst_n),
    .data           (data_move),           //红外数据
    .motor          (motor_0),
	 .pwm            (pwm)
    );

//HS0038B驱动模块
remote_rcv u_remote_rcv(               
    .sys_clk        (sys_clk),  
    .sys_rst_n      (sys_rst_n),    
    .remote_in      (remote_in),
    .repeat_en      (),                
    .data_en        (),
	 .data           (data)
    );

data_separate u_data_separate(
    .sys_clk        (sys_clk),  //系统时钟
    //.sys_rst_n      (sys_rst_n),  //系统复位信号，低电平有效
	 .data           (data),
	 .data_mode      (data_mode),
	 .data_pwm       (data_pwm),
	 .data_move      (data_move)
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
	 
key_pwm  u_key_pwm(
    .sys_clk         (sys_clk)    ,    //50Mhz系统时钟
    .sys_rst_n        (sys_rst_n)     ,    //系统复位，低有效
    .key             (data_pwm)  ,   
    // .sel_pwm	      (sel_pwm),
    .mod     (mod)
    );
pwm u_pwm(
.clk(sys_clk),
.pulse_width(mod),
.out  (pwm)
);

xunji u_xunji(
.clk (sys_clk),
.rst_n (sys_rst_n),
.D2 (D2),
.D3  (D3),
.pwm (pwm),
.motor (motor_1)
);

Clk_1M u_0(.clk_out(clk_1m), .clk_in(sys_clk), .rst(sys_rst_n)); // 50分频
TrigSignal u_1(.clk_1m(clk_1m), .rst(sys_rst_n), .trig(Trig));
PosCounter u_2(.clk_1m(clk_1m), .rst(sys_rst_n), .echo(Echo), .dis_count(dis));
dianji u_3(
   .clk   (clk_1m) ,  
   .rst_n  (sys_rst_n),      
   .disten  (dis),     
	.motor (motor_2),
	.pwm (pwm) 
    );
	 
gensui u_gensui(
.clk (sys_clk),
.D1 (D1),
.D4 (D4),
.pwm (pwm),
.disten (dis),
.motor (motor_3)
);

sel_mode u_sel_mode(
.clk (sys_clk),
.rst_n (sys_rst_n),
.data (data_mode),
.sel_type (sel_type),
.sel  (sel),
.led (led)
);

sel_mode_0 u_sel_mode_0(
.clk (sys_clk),
//.rst_n (sys_rst_n),
.key_value0 (key_value0),	//消抖后的按键信号
.key_flag0 (key_flag0),    //按键有效信号
.key_value1 (key_value1),	//消抖后的按键信号
.key_flag1 (key_flag1),    //按键有效信号
.key_value2 (key_value2),	//消抖后的按键信号
.key_flag2 (key_flag2),    //按键有效信号
.key_value3 (key_value3),	//消抖后的按键信号
.key_flag3 (key_flag3),    //按键有效信号
.sel_type (sel_type)        //模式控制
//.sel_pwm  (sel_pwm)        //调速
);

mux4_1 u_mux4_1(
.out (motor),
.in0 (motor_0),
.in1 (motor_1),
.in2 (motor_2),
.in3 (motor_3),
.sel (sel)
);
endmodule