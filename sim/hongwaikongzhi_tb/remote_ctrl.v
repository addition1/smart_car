
module remote_ctrl(
    input                   clk    ,       // 时钟信号
    input                   rst_n  ,       // 复位信号
    input         [2:0]     data  ,       
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
		3'd1:begin
				IN4<=1'b1;
				IN3<=1'b0;
				IN2<=1'b0;
				IN1<=1'b1;
                                    end
		3'd2:begin
		IN4<=1'b0;
		IN3<=1'b1;
		IN2<=1'b1;
		IN1<=1'b0;
		end
		3'd3:begin
		IN4<=1'b0;
		IN3<=1'b0;
		IN2<=1'b0;
		IN1<=1'b1;
		end
		3'd4:begin
		IN4<=1'b1;
		IN3<=1'b0;
		IN2<=1'b0;
		IN1<=1'b0;
		end
		3'd0:begin
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