//工作模式选择
module sel_mode(
input clk,
input rst_n,
input [7:0] data,
input  [1:0] sel_type,        //模式控制
output  [1:0] sel, 
output reg [3:0] led
);
reg [1:0] select;
always @(posedge clk or negedge rst_n) begin
if(!rst_n) begin
	select<=2'b00;
	led <=4'b1110;
	end 
else if((data==8'd69)||(sel_type==2'b00))begin 
	select<=2'b00;
	led <=4'b1110;
	end 
else if((data==8'd70)||(sel_type==2'b01))begin 
	select<=2'b01;
	led <=4'b1101;
	end
else if((data==8'd71)||(sel_type==2'b10))begin 
	select<=2'b10;
	led <=4'b1011;
	end
else if((data==8'd68)||(sel_type==2'b11))begin 
	select<=2'b11;
	led <=4'b0111;
	end
else;
end
assign sel=select;

endmodule
