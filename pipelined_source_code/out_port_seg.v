module out_port_seg (data_in ,data_out_ten,data_out_one); 
	input [31:0] data_in ;
	output reg [6:0] data_out_ten ;
	output reg [6:0] data_out_one ;
	
	reg[4:0] tens_data;
	reg[4:0] ones_data;
	always @(data_in )
		begin 
			data_out_one = 7'b1111111;
			data_out_ten = 7'b1111111;
			tens_data = data_in/10;
			ones_data = data_in%10;
			case (ones_data)
				4'b0000: data_out_one = 7'b1000000; // 0 
				4'b0001: data_out_one = 7'b1111001; // 1
				4'b0010: data_out_one = 7'b0100100; // 2
				4'b0011: data_out_one = 7'b0110000; // 3
				4'b0100: data_out_one = 7'b0011001; // 4 
				4'b0101: data_out_one = 7'b0010010; // 5 
				4'b0110: data_out_one = 7'b0000011; // 6 
				4'b0111: data_out_one = 7'b1111000; // 7 
				4'b1000: data_out_one = 7'b0000000; // 8 
				4'b1001: data_out_one = 7'b0011000; // 9 
				default:  data_out_one = 7'b1111111; //不显示
			endcase
			case (tens_data)
				4'b0000: data_out_ten = 7'b1000000; // 0 
				4'b0001: data_out_ten = 7'b1111001; // 1
				4'b0010: data_out_ten = 7'b0100100; // 2
				4'b0011: data_out_ten = 7'b0110000; // 3
				4'b0100: data_out_ten = 7'b0011001; // 4 
				4'b0101: data_out_ten = 7'b0010010; // 5 
				4'b0110: data_out_ten = 7'b0000011; // 6 
				4'b0111: data_out_ten = 7'b1111000; // 7 
				4'b1000: data_out_ten = 7'b0000000; // 8 
				4'b1001: data_out_ten = 7'b0011000; // 9 
				default:  data_out_ten = 7'b1111111; //不显示
			endcase
		end
endmodule