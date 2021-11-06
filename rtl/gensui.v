module gensui(
input clk,
input D1,D4,
input pwm,
input [19:0] disten,
output [3:0]  motor
);
reg IN4,IN3,IN2,IN1;
always @(posedge clk)
begin
if(disten<=20'd5)begin
	  IN4<=1'b0;
     IN3<=1'b0;
	  IN2<=1'b0;
	  IN1<=1'b0;
	 end
else begin  
	case({D1,D4})
	2'b00:begin
	  IN4<=pwm;
     IN3<=1'b0;
	  IN2<=1'b0;
	  IN1<=pwm;
	end
	2'b01:begin
	  IN4<=1'b0;
     IN3<=1'b0;
	  IN2<=1'b0;
	  IN1<=pwm;
	end
	2'b10:begin
	  IN4<=pwm;
     IN3<=1'b0;
	  IN2<=1'b0;
	  IN1<=1'b0;
	 end
	2'b11:begin
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