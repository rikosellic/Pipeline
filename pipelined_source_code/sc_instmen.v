module sc_instmem (addr,inst,rom_clk);
   input  [31:0] addr;
   input      rom_clk;
   output [31:0] inst;
   
   lpm_rom_irom irom (addr[7:2],rom_clk,inst); 

endmodule 