//工作模式选择
module sel_mode(
input clk,
input rst_n,
input [1:0] data,
output  [1:0] sel, 
output reg [3:0] led
);
reg [1:0] select;
always @(posedge clk or negedge rst_n) begin
if(!rst_n) begin
	led <=4'b1110;
	end
else begin 
	case(data)
	2'd0:begin 
	select<=2'b00;
	led <=4'b1110;
	end 
	2'd1: begin
	select<=2'b01;
	led <=4'b1101;
	end
	2'd2: begin
	select<=2'b10;
	led <=4'b1011;
	end
	2'd3: begin
	select<=2'b11;
	led <=4'b0111;
	end
	default:;
	endcase
end 
end
assign sel=select;

endmodule
