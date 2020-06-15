
module pipeir ( pc4,ins,wpcir,clock,resetn,flush,dpc4,inst,flush_out);
	input wpcir, clock, resetn, flush;
	input [31:0] pc4, ins;
	output [31:0] dpc4, inst;
	output flush_out;
	
	reg [31:0] dpc4, inst;
	reg flush_out;
	always @ (posedge clock) begin
		if (resetn == 0) begin
			dpc4 <= 0;
			inst <= 0;
			flush_out <= 0;
		end
		else begin
			if (wpcir) 
			begin
				dpc4 <= pc4;
				inst <= ins;
				flush_out <= flush;
			end
		end
	end
endmodule