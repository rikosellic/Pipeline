module pipedereg (  drs, drt, dwreg, dm2reg, dwmem,
daluc, daluimm, da, db, dimm, dsa, drn, dshift, djal,
dpc4, clock, resetn, ers, ert, ewreg, em2reg,
ewmem, ealuc, ealuimm, ea, eb, eimm, esa, ern0, eshift, ejal, epc4); 
	input [31:0] da, db, dimm, dpc4;
	input [4:0] drn,drs,drt, dsa;
	input [3:0] daluc;
	input dwreg, dm2reg, dwmem, daluimm, dshift,
		  djal, clock, resetn;
	output [31:0] ea, eb, eimm, epc4;
	output [4:0] ern0,ers,ert,esa;
	output [3:0] ealuc;
	output ewreg, em2reg, ewmem, ealuimm, eshift,
			ejal;
	
	reg [31:0] ea, eb, eimm, epc4;
	reg [4:0] ern0, esa, ers, ert;
	reg [3:0] ealuc;
	reg ewreg, em2reg, ewmem, ealuimm, eshift, ejal, ebubble;
	
	always @ (posedge clock) begin
		if (resetn == 0) begin
			ewreg <= 0;
			em2reg <= 0;
			ewmem <= 0;
			ealuc <= 0;
			ealuimm <= 0;
			ea <= 0;
			eb <= 0;
			eimm <= 0;
			ern0 <= 0;
			eshift <= 0;
			ejal <= 0;
			epc4 <= 0;
			esa <= 0;
			ers <= 0;
			ert <= 0;
		end
		else begin
			ewreg <= dwreg;
			em2reg <= dm2reg;
			ewmem <= dwmem;
			ealuc <= daluc;
			ealuimm <= daluimm;
			ea <= da;
			eb <= db;
			eimm <= dimm;
			ern0 <= drn;
			eshift <= dshift;
			ejal <= djal;
			epc4 <= dpc4;
			esa <= dsa;
			ers <= drs;
			ert <= drt;
		end
	end
endmodule