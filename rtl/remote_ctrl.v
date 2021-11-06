
module remote_ctrl(
    input                   clk    ,        // 时钟信号
    input                   rst_n  ,        // 复位信号
    input         [7:0]     data   ,        
	 input                   pwm    ,
	 output [3:0]  motor
	 
    );

reg IN4,IN3,IN2,IN1;
always @ (posedge clk or negedge rst_n) begin
    if (!rst_n)begin
      IN4<=1'b0;
		IN3<=1'b0;
		IN2<=1'b0;
		IN1<=1'b0;
		end
    else begin
      case (data) 
		8'd24:begin
				IN4<=pwm;
				IN3<=1'b0;
				IN2<=1'b0;
				IN1<=pwm;
		end
		8'd82:begin
		IN4<=1'b0;
		IN3<=pwm;
		IN2<=pwm;
		IN1<=1'b0;
		end
		8'd08:begin
		IN4<=1'b0;
		IN3<=1'b0;
		IN2<=1'b0;
		IN1<=pwm;
		end
		8'd90:begin
		IN4<=pwm;
		IN3<=1'b0;
		IN2<=1'b0;
		IN1<=1'b0;
		end
		8'd28:begin
		IN4<=1'b0;
		IN3<=1'b0;
		IN2<=1'b0;
		IN1<=1'b0;
		end
		default:begin
		IN4<=1'b0;
		IN3<=1'b0;
		IN2<=1'b0;
		IN1<=1'b0;
		end
      endcase
		    end 
end
assign motor={IN4,IN3,IN2,IN1};


endmodule 