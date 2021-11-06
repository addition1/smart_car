module TrigSignal(clk_1m, rst, trig); //产生10us的触发信号
input clk_1m, rst;
output  trig;

reg trig;
reg[19:0] count;
// 模1000 000计数器
always@(posedge clk_1m, negedge rst)
begin
    if (~rst)
        count <= 20'd0;
    else
    begin
        if (20'd9 == count)
        begin
            trig <= 1'd0;
            count <= count + 20'd1;
        end
        else 
        begin
            if (20'd100_000 == count)
            begin
                trig <= 1'd1;
                count <= 20'd0;
            end
            else
                count <= count + 20'd1;
        end
    end
end
endmodule