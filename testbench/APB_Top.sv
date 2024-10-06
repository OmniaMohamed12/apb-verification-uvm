/*######################################################################*\
## File Name: APB_Top.sv  
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/
`timescale 1ns/1ns
import uvm_pkg::*;
`include "uvm_macros.svh"
`include "APB_IF.sv"
`include "apb_slave.sv"
import APB_Pack::*;
module APB_Top;
    APB_IF ifc();
     apb_slave  dut(ifc.PCLK,ifc.PRESETn,ifc.PADDR,ifc.PSELx,ifc.PENABLE,ifc.PWRITE,ifc.PWDATA,ifc.PREADY,ifc.PRDATA,ifc.PSLVERR);
  initial begin
	ifc.PCLK<=0;
	forever #5 ifc.PCLK<=~ifc.PCLK;
  end
    initial begin
        uvm_config_db#(virtual APB_IF)::set(null,"uvm_test_top","vif",ifc);
        run_test("APB_Test");
    end
 initial begin
    $dumpfile("test.vcd");
    $dumpvars;
  end
endmodule
/*
vlog APB_Pack.svh APB_Top.sv +cover
vsim -batch APB_Top -coverage -do "run -all; coverage report -codeAll -cvg -verbose"
*/
