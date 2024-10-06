/*######################################################################*\
## Class Name: APB_Driver   
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/
import uvm_pkg::*;
`ifndef APB_Driver
`define APB_Driver
class APB_Driver  extends uvm_driver#(APB_Sequence_Item);
    `uvm_component_utils(APB_Driver)
    APB_Sequence_Item item_drv;
    virtual APB_IF vif;
    
    extern function new(string name="APB_Driver",uvm_component parent=null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);
    extern task initialize();
    extern task setup();
    extern task drive_item(input APB_Sequence_Item item_drv);

endclass:APB_Driver
function APB_Driver::new(string name="APB_Driver",uvm_component parent=null);
        super.new(name,parent);
        
endfunction
function void APB_Driver::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual APB_IF)::get(this,"","vif",vif))
        `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
endfunction
task APB_Driver::initialize();
     @(posedge vif.PCLK);
        setup();
        vif.PWDATA <=item_drv.PWDATA;
        @(posedge vif.PCLK);
        vif.PENABLE<=1;
        wait(vif.PREADY==1'b1);
        @(posedge vif.PCLK);
        vif.PRESETn<=1;
        vif.PENABLE<=0;
        vif.PSELx<=0;
endtask
task APB_Driver::run_phase(uvm_phase phase);
    forever begin

    `uvm_info("APB_Driver","APB_Driver is requesting an item", UVM_LOW)
    seq_item_port.get_next_item(item_drv);
    `uvm_info("APB_Driver","APB_Driver got the requested item", UVM_LOW)

    drive_item(item_drv);
    seq_item_port.item_done();
    
    end
endtask
task APB_Driver:: setup();
    vif.PSELx  <=1;
    vif.PWRITE <=item_drv.PWRITE;
    vif.PADDR  <=item_drv.PADDR;
    vif.PRESETn<=item_drv.PRESETn;
    vif.PENABLE<=item_drv.PENABLE;
endtask:setup
task APB_Driver::drive_item(input APB_Sequence_Item item_drv);
    if(item_drv.PRESETn == 0)begin
        initialize();
    end
    else begin
    if(item_drv.PWRITE==1)begin
        @(posedge vif.PCLK);
        setup();
        vif.PWDATA <=item_drv.PWDATA;
        @(posedge vif.PCLK);
        vif.PENABLE<=1;
        wait(vif.PREADY==1'b1);
       @(posedge vif.PCLK);
        vif.PENABLE<=0;
        vif.PSELx<=0;
    end
    else begin
        @(posedge vif.PCLK);
        setup();
        @(posedge vif.PCLK);
        vif.PENABLE<=1;
       wait(vif.PREADY==1'b1);
       @(posedge vif.PCLK);
        vif.PENABLE<=0;
        vif.PSELx<=0;

    end
    end
        

endtask
`endif//`ifndef APB_Driver