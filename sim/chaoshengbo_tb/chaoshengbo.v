module chaoshengbo(
input sys_clk,
input sys_rst_n,
input echo,

output [3:0]  motor
);

wire [3:0] dis_count;
wire  clk_1m;

Clk_1M u_0(.clk_out(clk_1m), 
                  .clk_in(sys_clk),
                  .rst(sys_rst_n)); // 50分频

PosCounter u_PosCounter(.clk_1m(clk_1m),
                        .rst(sys_rst_n), 
                        .echo(echo), 
                        .dis_count(dis_count));
	
dianji u_dianji(
.clk    (sys_clk),      // 时钟信号
.rst_n  (sys_rst_n),        // 复位信号
.disten  (dis_count),    
.motor (motor)
    );	
endmodule	
	