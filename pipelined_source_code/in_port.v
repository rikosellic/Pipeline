module in_port( switch4, switch3, switch2, switch1, switch0, data_out);
  input switch4, switch3, switch2, switch1, switch0;
  output reg [31:0]  data_out;
  
  always @(switch4 or switch3 or switch2 or switch1 or switch0)
  begin
	data_out = switch4*16 + switch3*8 + switch2*4 +switch1*2 + switch0;
	end 
endmodule