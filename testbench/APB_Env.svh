/*######################################################################*\
## Class Name: APB_Env   
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/
import uvm_pkg::*;
`ifndef APB_Env
`define APB_Env
class APB_Env extends uvm_env;
    `uvm_component_utils(APB_Env)

    APB_Agent agent;
    APB_Scoreboard scb;
    APB_Coverage cov;
    bit agent_is_active=1'b0;
    virtual APB_IF vif;
    
    extern function new(string name="APB_Env",uvm_component parent=null);
    extern virtual function void build_phase(uvm_phase phase);
    extern virtual function void connect_phase(uvm_phase phase);
    
endclass:APB_Env
function APB_Env::new(string name="APB_Env",uvm_component parent=null);
    super.new(name,parent);
endfunction
function void APB_Env::build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(bit)::get(this,"","agent_is_active",agent_is_active))
        `uvm_fatal("NoEnvConfig","No set for the parameter agent_is_active")  
    if(!uvm_config_db#(virtual APB_IF)::get(this,"","vif",vif))
            `uvm_error("APB_Env","Can't get vif from the config db")
    uvm_config_db#(virtual APB_IF)::set(this,"agent","vif",vif);
    agent = APB_Agent::type_id::create("agent",this);
    if (agent_is_active)
        agent.is_active = UVM_ACTIVE;
    else
        agent.is_active = UVM_PASSIVE;
   
   scb=APB_Scoreboard::type_id::create("scb",this);
   cov=APB_Coverage::type_id::create("cov",this);
  endfunction
function void APB_Env::connect_phase(uvm_phase phase);
    super.connect_phase (phase);
    agent.agent_ap.connect(scb.scb_analyais_imp);
    agent.agent_ap.connect(cov.cov_analyais_imp);
endfunction
`endif//`ifndef APB_Env
