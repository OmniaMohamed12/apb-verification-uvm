/*######################################################################*\
## Class Name: APB_Scoreboard   
## Author : Omnia Mohamed
## Date: Jul 2024
## 
\*######################################################################*/
import uvm_pkg::*;
`ifndef APB_Scoreboard
`define APB_Scoreboard
class APB_Scoreboard extends uvm_scoreboard;
    `uvm_component_utils(APB_Scoreboard)

    uvm_analysis_imp#(APB_Sequence_Item,APB_Scoreboard) scb_analyais_imp;
    int num_passed_cases;
    int num_failed_cases;
    logic [31:0] PRDATA;
    logic PSLVERR;
    logic [31:0] mem [31:0];
    extern function new(string name="APB_Scoreboard",uvm_component parent=null);
    extern virtual function void build_phase(uvm_phase phase);
    extern function void write (input APB_Sequence_Item item_scb);
endclass:APB_Scoreboard
function APB_Scoreboard::new(string name="APB_Scoreboard",uvm_component parent=null);
    super.new(name,parent);
endfunction
function void APB_Scoreboard::build_phase(uvm_phase phase);
    super.build_phase(phase);
    scb_analyais_imp=new("scb_analyais_imp",this);
endfunction

function void APB_Scoreboard::write (input APB_Sequence_Item item_scb);
    
    if(!item_scb.PRESETn)begin
        PRDATA =32'h0000_0000;
        PSLVERR =1'h0;
        foreach (mem[i]) 
                mem[i] = 32'h0000_0000;
    end
    else begin
        if(item_scb.PWRITE)begin
            if(item_scb.PADDR < 32)begin
                mem[item_scb.PADDR] =item_scb.PWDATA;
                PSLVERR=1'b0;
            end
            else
               PSLVERR=1'b1;
        end
        else begin
            if(item_scb.PADDR < 32)begin
                PRDATA=mem[item_scb.PADDR];
                PSLVERR=1'b0;
            end
            else
                PSLVERR=1'b1;
        end  
    end
    item_scb.print();
    `uvm_info("scb", $sformatf("Scoreboard pwrite %0b   pwdata : %0h prdata : %0h , exp prdata : %0h and paddr  : %0h", item_scb.PWRITE,item_scb.PWDATA,item_scb.PRDATA,PRDATA, item_scb.PADDR), UVM_NONE);
    $display("%0p",mem);
    if ( item_scb.PWRITE==1'b0)begin
    if(item_scb.PSLVERR==PSLVERR && item_scb.PRDATA==PRDATA )begin
         `uvm_info("APB_Scoreboard","TEST PASSED ",UVM_NONE);
        num_passed_cases++;
    end 
    else begin
        `uvm_info("APB_Scoreboard","TEST FAILED ",UVM_NONE);
        num_failed_cases++;
        item_scb.print();
    end
        $display("num_passed_cases=%0d num_failed_cases=%0d",num_passed_cases,num_failed_cases);

    end

endfunction

`endif //`ifndef APB_Scoreboard