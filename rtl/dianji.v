module dianji(
    input                   clk    ,        // 时钟信号
    input                   rst_n  ,        // 复位信号
    input        [19:0]     disten  ,     
	 input                   pwm,
	 output       [3:0]      motor
	 
    );
	 
//parameter define
parameter  s0  = 4'b0001;  //直行
parameter  s1  = 4'b0010;  //停止
parameter  s2  = 4'b0100;  //后退
parameter  s3  = 4'b1000;  //左转

//reg define
reg    [3:0]    cur_state      ;
reg    [3:0]    next_state     ;

reg    [26:0]    time_cnt       ;  //对小车的各个状态进行计数

reg             time_cnt_clr   ;  //计数器清零信号
reg             time_done      ;  //计时完成信号
reg             time_done1      ;  //计时完成信号
reg             time_done2      ;  //计时完成信号
reg             IN4,IN3,IN2,IN1;
//对小车的各个状态进行计数
always @(posedge clk or negedge rst_n) begin
    if(!rst_n)
        time_cnt <= 27'b0;
    else if(time_cnt_clr)
        time_cnt <= 27'b0;
    else 
        time_cnt <= time_cnt + 27'b1;
end 

//状态机
always @ (posedge clk or negedge rst_n) begin
    if(!rst_n)
        cur_state <= s0;
    else
        cur_state <= next_state ;
end

always @(*) begin
    next_state = s0;
    case(cur_state)
        s0 : begin                           //直行
            if(disten<=20'd25)
                next_state = s1;
            else
                next_state = s0;            
        end
        s1 : begin                  //停止
            if(time_done)
                next_state = s2;
            else
                next_state = s1;
        end
		  s2 : begin                  //停止
            if(time_done1)
                next_state = s3;
            else
                next_state = s2;
        end
        s3 : begin                    //左转
            if(time_done2) 
				next_state = s0;
            else
             next_state = s3;
        end 
        default : next_state = s0;
    endcase
end

always @(posedge clk or negedge rst_n ) begin 
    if (!rst_n) begin  
	   time_cnt_clr <= 1'b1;
      time_done <= 1'b0;
    end
    else begin
        case(cur_state)
            s0 : begin
                if(disten<=20'd25)
                    time_cnt_clr <= 1'b0;
					else 	
					time_cnt_clr <= 1'b1;  
            end   
            s1 : begin                                               
                    if(time_cnt ==27'd80_000)begin
                     time_done <= 1'b1;
		               end					
                    else begin
                     time_done <= 1'b0;
		               end 
                end   
				s2 : begin                                               
						  if(time_cnt ==27'd180_000)begin
							time_done1 <= 1'b1;
							end					
						  else begin
							time_done1 <= 1'b0;
							end 
				     end   
				s3 : begin
                if(time_cnt ==27'd240_000) begin   
                  time_done2 <= 1'b1;
						time_cnt_clr <= 1'b1;
                end 
                else begin
                     time_done2 <= 1'b0;
						   time_cnt_clr <= 1'b0;
		               end					 
            end
            default : ;
        endcase
    end
end
always @(posedge clk or negedge rst_n ) begin 
    if (!rst_n) begin  
      IN4<=1'b0;
		IN3<=1'b0;
		IN2<=1'b0;
		IN1<=1'b0;
    end
    else begin
        case(cur_state)
            s0 : begin
				IN4<=pwm;
				IN3<=1'b0;
				IN2<=1'b0;
				IN1<=pwm;
            end   
            s1 : begin                                               
            IN4<=1'b0;
				IN3<=1'b0;
				IN2<=1'b0;
				IN1<=1'b0;
                end  
				s2 : begin                                               
            IN4<=1'b0;
				IN3<=pwm;
				IN2<=pwm;
				IN1<=1'b0;
                end 
            s3 : begin
				IN4<=1'b0;
				IN3<=pwm;
				IN2<=1'b0;
				IN1<=pwm;			 
            end
            default : ;
        endcase
    end
end
assign motor={IN4,IN3,IN2,IN1};
endmodule