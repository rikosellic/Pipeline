module io_input(
  addr,io_clk,io_read_data,in_port0,in_port1, in_port2
  );
  input  [31:0]  addr;
  input  io_clk;
  input  [31:0]  in_port0,in_port1,in_port2;
  output [31:0]  io_read_data;

  reg  [31:0]  in_reg0; // input port0
  reg  [31:0]  in_reg1; // input port1
  reg  [31:0]  in_reg2;
  io_input_mux io_imput_mux2x32(in_reg0,in_reg1,in_reg2, addr[7:2],io_read_data);
  
  always @(posedge io_clk)
  begin
	in_reg0 <= in_port0; //  输入端口在 io_clk 上升沿时进行数据锁存
	in_reg1 <= in_port1; //  输入端口在 io_clk 上升沿时进行数据锁存
	in_reg2 <= in_port2; 
	end 
	
endmodule