`timescale 1ns/1ns
`define  T  20
module remote_rcv_tb;
	
              //  parameter  T = 20;                 // 时钟周期为20ns

	reg Clk;
	reg Rst_n;
	reg remote_in;
	
	wire repeat_en;
	wire data_en;
	wire  [7:0]   data ;
	
	integer i;

	remote_rcv u_remote_rcv(
		.sys_clk(Clk),
		.sys_rst_n(Rst_n),
		
		.remote_in(remote_in),
		
		.repeat_en(repeat_en),
		.data_en(data_en),
		.data (data )
	);
	
	initial Clk = 1'b1;
	always #(`T/2) Clk = ~Clk;

	initial begin
		Rst_n = 1'b0;
		remote_in = 1'b1;
		#(`T*10+1'b1);
		Rst_n = 1'b1;
		#2000;
		remote_in = 1'b1;
		send_data(16'd1,8'haa);
		#60000000;
		$stop	;
	end


	
	task send_data;
                                input [15:0]addr;
		input [7:0]data;
		begin
			remote_in = 0;#9000000;
			remote_in = 1;#4500000;
			for(i=0;i<=15;i=i+1)begin
				bit_send(addr[i]);		
			end
			for(i=0;i<=7;i=i+1)begin
				bit_send(data[i]);		
			end
			for(i=0;i<=7;i=i+1)begin
				bit_send(~data[i]);		
			end
			remote_in = 0;#560000;
			remote_in = 1;		
		end
	endtask
	
	task bit_send;
		input one_bit;
		begin
			remote_in = 0; #560000;
			remote_in = 1;
			if(one_bit)
				#1690000;
			else
				#560000;
		end	
	endtask

endmodule