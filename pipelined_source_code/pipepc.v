module pipepc( npc,wpcir,clock,resetn,pc );
	input wpcir, clock, resetn;
	input [31:0] npc;
	output [31:0] pc;
	
	reg [31:0] pc;
	integer firstcommand;
	
	initial
	firstcommand=0;
	
	always @ (posedge clock) begin
		if (resetn == 0) 
		begin
			pc <= 0;
			firstcommand <= 0;
		end
		else 	
			if (wpcir&(firstcommand!=0)) 
			begin
				pc <= npc;
			end
			else
			begin
			firstcommand <= 1;
			end
	end
endmodule