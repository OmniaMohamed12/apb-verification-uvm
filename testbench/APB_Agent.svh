/*######################################################################*\
## Class Name: APB_Agent   
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/
import uvm_pkg::*;
`ifndef APB_Agent
`define APB_Agent
class APB_Agent extends uvm_agent;
    `uvm_component_utils(APB_Agent)

    APB_Driver driver;
    APB_Sequencer sequencer;
    APB_Monitor monitor;
    uvm_analysis_port#(APB_Sequence_Item) agent_ap;
    virtual APB_IF vif;
    extern function new(string name="APB_Agent",uvm_component parent=null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
   
endclass:APB_Agent
function APB_Agent::new(string name="APB_Agent",uvm_component parent=null);
    super.new(name,parent);
endfunction
function void APB_Agent::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual APB_IF)::get(this,"","vif",vif))
            `uvm_error("APB_Env","Can't get vif from the config db")
    uvm_config_db#(virtual APB_IF)::set(this,"driver","vif",vif);
    uvm_config_db#(virtual APB_IF)::set(this,"monitor","vif",vif);
    if(get_is_active == UVM_ACTIVE) begin
        driver=APB_Driver::type_id::create("driver",this);
        sequencer=APB_Sequencer::type_id::create("sequencer",this);
    end
    monitor=APB_Monitor::type_id::create("monitor",this);
    agent_ap=new("agent_ap",this);
endfunction
function void APB_Agent::connect_phase(uvm_phase phase);
    super.connect_phase (phase);
    if (get_is_active() == UVM_ACTIVE) begin
        driver.seq_item_port.connect(sequencer.seq_item_export);
    end
   monitor.mon_ap.connect(this.agent_ap);
endfunction
`endif//`ifndef APB_Agent
