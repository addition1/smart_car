module key_debounce(
    input               sys_clk,          //外部50M时钟
    input               sys_rst_n,        //外部复位信号，低有效
    
    input       key0,              //外部按键输入
    input       key1, 
    input       key2, 
    input       key3, 
   output reg          key_flag0,         //按键数据有效信号
   output reg          key_value0,         //按键消抖后的数据  
   output reg          key_flag1,         //按键数据有效信号
   output reg          key_value1,         //按键消抖后的数据  
   output reg          key_flag2,         //按键数据有效信号
   output reg          key_value2,         //按键消抖后的数据  
   output reg          key_flag3,         //按键数据有效信号
   output reg          key_value3         //按键消抖后的数据  
    );

//reg define    
reg [31:0] delay_cnt0;
reg [3:0]  key_reg0;
reg [31:0] delay_cnt1;
reg [3:0]  key_reg1;
reg [31:0] delay_cnt2;
reg [3:0]  key_reg2;
reg [31:0] delay_cnt3;
reg [3:0]  key_reg3;
//*****************************************************
//**                    main code
//*****************************************************
always @(posedge sys_clk or negedge sys_rst_n) begin 
    if (!sys_rst_n) begin 
        key_reg0   <= 1'b1;
        delay_cnt0 <= 32'd0;
    end
    else begin
        key_reg0 <= key0;
        if(key_reg0 != key0)             //一旦检测到按键状态发生变化(有按键被按下或释放)
            delay_cnt0 <= 32'd1000000;  //给延时计数器重新装载初始值（计数时间为20ms）
        else if(key_reg0 == key0) begin  //在按键状态稳定时，计数器递减，开始20ms倒计时
                 if(delay_cnt0 > 32'd0)
                     delay_cnt0 <= delay_cnt0 - 1'b1;
                 else
                     delay_cnt0 <= delay_cnt0;
             end           
    end   
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
    if (!sys_rst_n) begin 
        key_flag0  <= 1'b0;
        key_value0 <= 1'b1;          
    end
    else begin
        if(delay_cnt0 == 32'd1) begin   //当计数器递减到1时，说明按键稳定状态维持了20ms
            key_flag0  <= 1'b1;         //此时消抖过程结束，给出一个时钟周期的标志信号
            key_value0 <= key0;          //并寄存此时按键的值
        end
        else begin
            key_flag0  <= 1'b0;
            key_value0 <= key_value0; 
        end  
    end   
end
////////////////////////////////////////////////////////////////////////1
always @(posedge sys_clk or negedge sys_rst_n) begin 
    if (!sys_rst_n) begin 
        key_reg1   <= 1'b1;
        delay_cnt1 <= 32'd0;
    end
    else begin
        key_reg1 <= key1;
        if(key_reg1 != key1)             //一旦检测到按键状态发生变化(有按键被按下或释放)
            delay_cnt1 <= 32'd1000000;  //给延时计数器重新装载初始值（计数时间为20ms）
        else if(key_reg1 == key1) begin  //在按键状态稳定时，计数器递减，开始20ms倒计时
                 if(delay_cnt1 > 32'd0)
                     delay_cnt1 <= delay_cnt1 - 1'b1;
                 else
                     delay_cnt1 <= delay_cnt1;
             end           
    end   
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
    if (!sys_rst_n) begin 
        key_flag1  <= 1'b0;
        key_value1 <= 1'b1;          
    end
    else begin
        if(delay_cnt1 == 32'd1) begin   //当计数器递减到1时，说明按键稳定状态维持了20ms
            key_flag1  <= 1'b1;         //此时消抖过程结束，给出一个时钟周期的标志信号
            key_value1 <= key1;          //并寄存此时按键的值
        end
        else begin
            key_flag1  <= 1'b0;
            key_value1 <= key_value1; 
        end  
    end   
end
////////////////////////////////////////////////////////////////2
always @(posedge sys_clk or negedge sys_rst_n) begin 
    if (!sys_rst_n) begin 
        key_reg2   <= 1'b1;
        delay_cnt2 <= 32'd0;
    end
    else begin
        key_reg2 <= key2;
        if(key_reg2 != key2)             //一旦检测到按键状态发生变化(有按键被按下或释放)
            delay_cnt2 <= 32'd1000000;  //给延时计数器重新装载初始值（计数时间为20ms）
        else if(key_reg2 == key2) begin  //在按键状态稳定时，计数器递减，开始20ms倒计时
                 if(delay_cnt2 > 32'd0)
                     delay_cnt2 <= delay_cnt2 - 1'b1;
                 else
                     delay_cnt2 <= delay_cnt2;
             end           
    end   
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
    if (!sys_rst_n) begin 
        key_flag2  <= 1'b0;
        key_value2 <= 1'b1;          
    end
    else begin
        if(delay_cnt2 == 32'd1) begin   //当计数器递减到1时，说明按键稳定状态维持了20ms
            key_flag2  <= 1'b1;         //此时消抖过程结束，给出一个时钟周期的标志信号
            key_value2 <= key2;          //并寄存此时按键的值
        end
        else begin
            key_flag2  <= 1'b0;
            key_value2 <= key_value2; 
        end  
    end   
end
///////////////////////////////////////////////////////////////3
always @(posedge sys_clk or negedge sys_rst_n) begin 
    if (!sys_rst_n) begin 
        key_reg3   <= 1'b1;
        delay_cnt3 <= 32'd0;
    end
    else begin
        key_reg3 <= key3;
        if(key_reg3 != key3)             //一旦检测到按键状态发生变化(有按键被按下或释放)
            delay_cnt3 <= 32'd1000000;  //给延时计数器重新装载初始值（计数时间为20ms）
        else if(key_reg3 == key3) begin  //在按键状态稳定时，计数器递减，开始20ms倒计时
                 if(delay_cnt3 > 32'd0)
                     delay_cnt3 <= delay_cnt3 - 1'b1;
                 else
                     delay_cnt3 <= delay_cnt3;
             end           
    end   
end

always @(posedge sys_clk or negedge sys_rst_n) begin 
    if (!sys_rst_n) begin 
        key_flag3  <= 1'b0;
        key_value3 <= 1'b1;          
    end
    else begin
        if(delay_cnt3 == 32'd1) begin   //当计数器递减到1时，说明按键稳定状态维持了20ms
            key_flag3  <= 1'b1;         //此时消抖过程结束，给出一个时钟周期的标志信号
            key_value3 <= key3;          //并寄存此时按键的值
        end
        else begin
            key_flag3  <= 1'b0;
            key_value3 <= key_value3; 
        end  
    end   
end    
endmodule 