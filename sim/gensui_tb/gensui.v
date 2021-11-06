module gensui(
input clk,
input  rst_n,
input D1,D4,
output [3:0]  motor
);
reg IN4,IN3,IN2,IN1;
always @(posedge clk or negedge rst_n )
begin
	case({D1,D4})
	2'b00:begin
	IN4<=1'b1;
    IN3<=1'b0;
	IN2<=1'b0;
	IN1<=1'b1;
	end
	2'b01:begin
	IN4<=1'b0;
    IN3<=1'b0;
	IN2<=1'b0;
	IN1<=1'b1;
	end
	2'b10:begin
	IN4<=1'b1;
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
assign motor={IN4,IN3,IN2,IN1};
endmodule