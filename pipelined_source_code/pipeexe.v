module pipeexe ( ealuc,ealuimm,ea,eb,eimm,esa,eshift,ern0,epc4,ejal,ern,ealu ,ezero);
	input ealuimm, ejal, eshift;
	input [3:0] ealuc;
	input [4:0] ern0;
	input [31:0] ea, eb, eimm, epc4, esa;
	output [31:0] ealu;
	output [4:0] ern;
	output ezero;
	
	wire [31:0] a, b, sa, r;// epc8;
	
	//assign epc8 = epc4 + 4;
	mux2x32 get_a(ea, esa, eshift, a);
	mux2x32 get_b(eb, eimm, ealuimm, b);
	alu algorithm_unit(a,b,ealuc,r,ezero);
	mux2x32 get_ealu(r, epc4, ejal, ealu);
	
	assign ern = ejal ? 5'b11111 : ern0;
endmodule