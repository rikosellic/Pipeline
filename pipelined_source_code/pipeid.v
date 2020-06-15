module pipeid (flush_input,mwreg,mrn,ern,ewreg,em2reg,mm2reg,dpc4,inst,
	            wrn,wdi,ealu,malu,mmo,wwreg,rom_clock,resetn,
	            bpc,jpc,pcsource,wpcir,dwreg,dm2reg,dwmem,daluc,
	            daluimm,da,db,dimm,dsa, drn,dshift,djal,mzero,
					drs,drt,flush);
	input [31:0] dpc4, inst, wdi, ealu, malu, mmo;
	input [4:0] ern, mrn, wrn;
	input mwreg, ewreg, em2reg, mm2reg,
		  wwreg, rom_clock, resetn, mzero, flush_input;
	output [31:0] bpc, jpc, da, db, dimm, dsa;
	output [4:0] drn,drs,drt;
	output [3:0] daluc;
	output [1:0] pcsource;
	output wpcir, dwreg, dm2reg, dwmem,
		   daluimm, dshift, djal, flush;
	
	wire [3:0] i_daluc;
	wire  i_dwreg, i_dm2reg, i_dwmem,
		   i_daluimm, i_dshift, i_djal;
	
	
	wire [31:0]i_inst;
	wire rsrtequ, wpcir, regrt, sext;
	wire [1:0] pcsource, fwdb, fwda;
	wire [4:0] drn,drs,drt;
	wire [31:0] q1, q2, da, db, bpc, jpc;
	wire [15:0]	imm = {16{e}};
	wire [31:0] offset = {imm[13:0],inst[15:0],1'b0,1'b0};
	wire		e = sext & inst[15];
	wire [31:0]	dimm = {imm,inst[15:0]};
	
	mux2x32 control_nop_creater (inst,32'h00000000,flush_input,i_inst);
	
	assign drs = i_inst[25:21];
	assign drt = i_inst[20:16];
	assign dsa = i_inst[10:6];
	
	sc_cu control_unit(i_inst[31:26], i_inst[5:0], drs, drt, rsrtequ, ewreg, em2reg, ern, mwreg, mm2reg, mrn,
		   pcsource, wpcir, i_dwreg, i_dm2reg, i_dwmem, i_djal, i_daluc, i_daluimm, i_dshift, regrt, sext, fwdb, fwda, flush);
	
	regfile rf(i_inst[25:21],i_inst[20:16],wdi,wrn,wwreg,rom_clock,resetn,q1,q2);
	
	assign bpc = dpc4 + offset;
	assign jpc = {dpc4[31:28],inst[25:0],1'b0,1'b0};
	
	
	mux4x32 get_da(q1, ealu, malu, mmo, fwda, da);
	mux4x32 get_db(q2, ealu, malu, mmo, fwdb, db);
	assign rsrtequ = (da == db);

	mux2x5	get_drn(i_inst[15:11],i_inst[20:16],regrt,drn);
	
	mux2x32 lw_nop_creater1 (i_daluc,0,~wpcir,daluc);
	mux2x32 lw_nop_creater2 (i_dwreg,0,~wpcir,dwreg);
	mux2x32 lw_nop_creater3 (i_dm2reg,0,~wpcir,dm2reg);
	mux2x32 lw_nop_creater4 (i_dwmem,0,~wpcir,dwmem);
	mux2x32 lw_nop_creater5 (i_daluimm,0,~wpcir,daluimm);
	mux2x32 lw_nop_creater6 (i_dshift,0,~wpcir,dshift);
	mux2x32 lw_nop_creater7 (i_djal,0,~wpcir,djal);
	
endmodule