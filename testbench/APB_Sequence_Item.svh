/*######################################################################*\
## Class Name: APB_Sequence_Item   
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/

`ifndef APB_Sequence_Item
`define APB_Sequence_Item
class APB_Sequence_Item  extends uvm_sequence_item;
    randc bit [31:0] PADDR;
    rand bit PWRITE;
    randc bit [31:0] PWDATA;
    bit PSELx;
    bit PENABLE;
    rand bit PRESETn;

    logic PREADY;
    logic [31:0] PRDATA;
    logic PSLVERR;

    constraint mode_c{
        PRESETn dist {0:=20,1:=80};
        PWRITE dist {0:=50,1:=50};
    }
    constraint addr_valid{
        PADDR < 32'h0000_0020;
    }

    `uvm_object_utils_begin(APB_Sequence_Item)
        `uvm_field_int(PADDR,UVM_HEX)
        `uvm_field_int(PENABLE,UVM_BIN)
        `uvm_field_int(PWRITE,UVM_BIN)
        `uvm_field_int(PWDATA,UVM_HEX)
        `uvm_field_int(PRESETn,UVM_BIN)
        `uvm_field_int(PSELx,UVM_BIN)
        `uvm_field_int(PREADY,UVM_BIN)
        `uvm_field_int(PRDATA,UVM_HEX)
        `uvm_field_int(PSLVERR,UVM_BIN)
    `uvm_object_utils_end

    function new(string name="APB_Sequence_Item");
        super.new(name);
        
    endfunction
endclass:APB_Sequence_Item

`endif//`ifndef APB_Sequence_Item