/*######################################################################*\
## Class Name: APB_Monitor   
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/
import uvm_pkg::*;
`ifndef APB_Monitor
`define APB_Monitor
class APB_Monitor  extends uvm_monitor;
    `uvm_component_utils(APB_Monitor)

    APB_Sequence_Item item_mon;
    virtual APB_IF vif;
    uvm_analysis_port #(APB_Sequence_Item) mon_ap;
    
    extern function new(string name="APB_Monitor",uvm_component parent=null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual task run_phase(uvm_phase phase);
    

endclass:APB_Monitor
function APB_Monitor::new(string name="APB_Monitor",uvm_component parent=null);
        super.new(name,parent);
        
endfunction
function void APB_Monitor::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual APB_IF)::get(this,"","vif",vif))
        `uvm_fatal("NOVIF",{"virtual interface must be set for: ",get_full_name(),".vif"});
        item_mon=APB_Sequence_Item::type_id::create("item_mon");
        mon_ap=new("mon_ap",this);
endfunction
task APB_Monitor::run_phase(uvm_phase phase);
    forever begin
@(posedge vif.PCLK);
@(posedge vif.PCLK);
        wait( vif.PREADY==1'b1);
        if(vif.PSELx==1'b1 &&  vif.PENABLE==1'b1 && vif.PREADY==1'b1)begin
            `uvm_info("APB_Monitor","APB_Monitor got the requested item", UVM_LOW)
            item_mon.PRESETn = vif.PRESETn;
            item_mon.PSLVERR = vif.PSLVERR;
            item_mon.PREADY = vif.PREADY;
            item_mon.PWRITE = vif.PWRITE;
            item_mon.PADDR = vif.PADDR;
        if(!vif.PRESETn)begin
            `uvm_info("APB_Monitor","reset phase",UVM_NONE);
            item_mon.PRDATA = vif.PRDATA;

        end
        else begin 
           
            if(vif.PWRITE)begin
                item_mon.PWDATA = vif.PWDATA;
                `uvm_info("APB_Monitor","write operation",UVM_NONE);
            end  
            else begin
                item_mon.PRDATA = vif.PRDATA;
                `uvm_info("APB_Monitor","read operation",UVM_NONE);
            end 
        end
        mon_ap.write(item_mon); 
    
    
        end
       
    end
endtask
`endif//`ifndef APB_Monitor