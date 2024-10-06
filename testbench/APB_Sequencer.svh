/*######################################################################*\
## Class Name: APB_Sequencer   
## Author : Omnia Mohamed
## Date: jul 2024
## 
\*######################################################################*/
import uvm_pkg::*;
`ifndef APB_Sequencer
`define APB_Sequencer
class APB_Sequencer extends uvm_sequencer#(APB_Sequence_Item);
    `uvm_component_utils(APB_Sequencer)
    function new(string name="APB_Sequencer",uvm_component parent=null);
        super.new(name,parent);
    endfunction:new;
endclass:APB_Sequencer
`endif//`ifndef APB_Sequencer