/*######################################################################*\
## Class Name: APB_Coverage   
## Author : Omnia Mohamed
## Date: Aug 2024
## 
\*######################################################################*/
import uvm_pkg::*;
`ifndef APB_Coverage
`define APB_Coverage
class APB_Coverage extends uvm_subscriber#(APB_Sequence_Item);
    `uvm_component_utils(APB_Coverage)

    uvm_analysis_imp#(APB_Sequence_Item,APB_Coverage) cov_analyais_imp;
    APB_Sequence_Item item_cov;
    
    extern function new(string name="APB_Coverage",uvm_component parent=null);
    extern virtual function void build_phase(uvm_phase phase);
    extern function void write (APB_Sequence_Item t);
    extern function void report_phase (uvm_phase phase);
    covergroup cg;
        PADDR: coverpoint item_cov.PADDR{
			bins b1[]={[32'h0000_0000:32'h0000_0020]};
			}
		PWRITE:coverpoint item_cov.PWRITE{
			bins read={0};
			bins write={1};
			bins wtor = (1=> 0);
			bins wtor32 = (1[*32]=> 0[*32]);
			}
		PRESETn:coverpoint item_cov.PRESETn{
			bins low={0};
			bins high={1};
			bins ltoh=(0[=32]=> 1);
		}
		PWDATA: coverpoint item_cov.PWDATA;
		PREADY: coverpoint item_cov.PREADY{
			bins high={1};}
		PRDATA:	coverpoint item_cov.PRDATA;
		PSLVERR:coverpoint item_cov.PSLVERR{
			bins low={0};
			illegal_bins high={1};
			}
    endgroup
endclass:APB_Coverage
function APB_Coverage::new(string name="APB_Coverage",uvm_component parent=null);
    super.new(name,parent);
     cg=new();
endfunction
function void APB_Coverage::build_phase(uvm_phase phase);
    super.build_phase(phase);
    cov_analyais_imp=new("cov_analyais_imp",this);
endfunction

function void APB_Coverage::write ( APB_Sequence_Item t);
    item_cov=t;
    item_cov.print();
    cg.sample();
endfunction
function void APB_Coverage::report_phase (uvm_phase phase);
        `uvm_info("APB_Coverage", $sformatf("coverage =%0d", cg.get_coverage), UVM_NONE);
endfunction
`endif //`ifndef APB_Coverage