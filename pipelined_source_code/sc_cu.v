module sc_cu (op, func, rs, rt, rsrtequ, ewreg, em2reg, ern, mwreg, mm2reg, mrn,
		   pcsource, wpcir, wreg, m2reg, wmem, jal, aluc, aluimm, shift, regrt, sext, fwdb, fwda, flush);
   input  [5:0] op,func;
	input  [4:0] rs, rt, ern, mrn;
	input		ewreg, em2reg, mwreg, mm2reg, rsrtequ;
	output   wpcir, wreg, regrt, jal, m2reg, shift, aluimm, sext, wmem, flush;
	output [3:0] aluc;
	output [1:0] pcsource, fwda, fwdb;
	reg [1:0] fwda, fwdb;
   wire r_type = ~|op;
   wire i_add = r_type & func[5] & ~func[4] & ~func[3] &
                ~func[2] & ~func[1] & ~func[0];          //100000
   wire i_sub = r_type & func[5] & ~func[4] & ~func[3] &
                ~func[2] &  func[1] & ~func[0];          //100010
	wire i_ham = r_type & func[5] & ~func[4] & ~func[3] &
                ~func[2] & ~func[1] & func[0];          //100001
   
   wire i_and = r_type & func[5] & ~func[4] & ~func[3] & //100100
                func[2] & ~func[1] & ~func[0];
   wire i_or  = r_type & func[5] & ~func[4] & ~func[3] & //100101
                func[2] & ~func[1] & func[0];

   wire i_xor = r_type & func[5] & ~func[4] & ~func[3] & //100110
                func[2] & func[1] & ~func[0];
   wire i_sll = r_type & ~func[5] & ~func[4] & ~func[3] & //000000
                ~func[2] & ~func[1] & ~func[0];
   wire i_srl = r_type & ~func[5] & ~func[4] & ~func[3] & //000010
                ~func[2] & func[1] & ~func[0];
   wire i_sra = r_type & ~func[5] & ~func[4] & ~func[3] & //000011
                ~func[2] & func[1] & func[0];
   wire i_jr  = r_type & ~func[5] & ~func[4] & func[3] & //001000
                ~func[2] & ~func[1] & ~func[0];
					 
	wire i_max = r_type & func[5] & func[4] & ~func[3] & //110011
                ~func[2] & func[1] & func[0];
                
   wire i_addi = ~op[5] & ~op[4] &  op[3] & ~op[2] & ~op[1] & ~op[0]; //001000
   wire i_andi = ~op[5] & ~op[4] &  op[3] &  op[2] & ~op[1] & ~op[0]; //001100
   
   wire i_ori  = ~op[5] & ~op[4] &  op[3] &  op[2] & ~op[1] & op[0]; //001101
   wire i_xori = ~op[5] & ~op[4] &  op[3] &  op[2] & op[1] & ~op[0]; //001110  
   wire i_lw   = op[5] & ~op[4] &  ~op[3] &  ~op[2] & op[1] & op[0]; //100011    
   wire i_sw   = op[5] & ~op[4] &  op[3] &  ~op[2] & op[1] & op[0]; //101011    
   wire i_beq  = ~op[5] & ~op[4] &  ~op[3] &  op[2] & ~op[1] & ~op[0]; //000100    
   wire i_bne  = ~op[5] & ~op[4] &  ~op[3] &  op[2] & ~op[1] & op[0]; //000101 
   wire i_lui  = ~op[5] & ~op[4] &  op[3] &  op[2] & op[1] & op[0]; //001111 
   wire i_j    = ~op[5] & ~op[4] &  ~op[3] &  ~op[2] & op[1] & ~op[0]; //000010
   wire i_jal  = ~op[5] & ~op[4] &  ~op[3] &  ~op[2] & op[1] & op[0]; //000011
   
  
   assign pcsource[1] = i_jr | i_j | i_jal;
   assign pcsource[0] = ( i_beq & rsrtequ ) | (i_bne & ~rsrtequ) | i_j | i_jal ;
   
   assign wreg = i_add | i_sub | i_and | i_or   | i_xor  |
                 i_sll | i_srl | i_sra | i_addi | i_andi |
                 i_ori | i_xori | i_lw | i_lui  | i_jal  | i_max | i_ham;
   
   assign aluc[3] = i_sra | i_max | i_ham;
   assign aluc[2] =  i_sub | i_beq | i_bne | i_or | i_ori |
							i_lui | i_srl | i_sra;
   assign aluc[1] =  i_xor | i_xori | i_lui | i_sll | i_srl | i_sra | i_max | i_ham;
   assign aluc[0] =  i_and | i_andi | i_or | i_ori | i_sll | i_srl | i_sra | i_max;
   assign shift   = i_sll | i_srl | i_sra ;

   assign aluimm  =  i_lui  | i_addi | i_andi | i_ori | i_xori  | i_lw |
							i_sw;
   assign sext    = i_lui | i_addi | i_lw | i_sw | i_beq | i_bne;
   assign wmem    = 	i_sw; 
   assign m2reg   = i_lw; 
   assign regrt   = i_lui | i_addi | i_andi | i_ori | i_xori | i_lw;
   assign jal     = i_jal;
	
	wire i_rs = i_add | i_sub | i_and | i_or | i_xor | i_jr | i_addi |
				i_andi | i_ori | i_xori | i_lw | i_sw | i_beq | i_bne | i_ham | i_max;
	wire i_rt = i_add | i_sub | i_and | i_or | i_xor | i_sll | i_srl |
				i_sra | i_addi | i_andi | i_ori | i_xori | i_lw | i_sw |
				i_beq | i_bne | i_lui | i_ham | i_max;
	
	always @ (ewreg or mwreg or ern or mrn or em2reg or mm2reg or rs or rt) begin
		fwda = 2'b00; // default forward a: no hazards
		if (ewreg & (ern != 0) & (ern == rs) & ~em2reg) begin
			fwda =2'b01; // select exe_alu
		end else begin
			if (mwreg & (mrn != 0) & (mrn == rs) & ~mm2reg) begin
				fwda =2'b10; // select mem_alu
			end else begin
				if (mwreg & (mrn != 0) & (mrn == rs) & mm2reg) begin
					fwda = 2'b11; // select mem_lw
				end
			end
		end
		fwdb = 2'b00; // default forward b: no hazards
		if (ewreg & (ern != 0) & (ern == rt) & ~em2reg) begin
			fwdb = 2'b01; // select exe_alu
		end else begin
			if (mwreg & (mrn != 0) & (mrn == rt) & ~mm2reg) begin
				fwdb =2'b10; // select mem_alu
			end else begin
				if (mwreg & (mrn != 0) & (mrn == rt) & mm2reg) begin
					fwdb = 2'b11; // select mem_lw
				end
			end
		end
	end
	
	assign wpcir = ~(ewreg & (ern != 0) & em2reg &((i_rs & (ern == rs)) | (i_rt & (ern == rt))));
	assign flush = pcsource !=2'b00;
	
endmodule
