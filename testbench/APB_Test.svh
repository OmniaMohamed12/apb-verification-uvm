/*######################################################################*\
## Class Name: APB_Test   
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/
class APB_Test extends uvm_test;
    `uvm_component_utils(APB_Test)
    APB_Env env;
    APB_Base_Seq base_seq;
    APB_Reset_Seq seq1;
    APB_Write_Seq seq2;
    APB_Write_Invalid_Seq seq3;
    APB_Read_Seq seq4;
    APB_Read_Invalid_Seq seq5;
    APB_Write_Read_Seq seq6;

    virtual APB_IF vif;

    function new (string name="APB_Test", uvm_component parent =null);
        super.new(name,parent);
    endfunction
    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        if(!uvm_config_db#(virtual APB_IF)::get(this,"","vif",vif))
            `uvm_error("APB_Test","Can't get vif from the config db")
        uvm_config_db#(virtual APB_IF)::set(this,"env","vif",vif);
        env=APB_Env::type_id::create("env",this);
        configure_env();
        base_seq=APB_Base_Seq::type_id::create("base_seq");
        seq1=APB_Reset_Seq::type_id::create("seq1");
        seq2=APB_Write_Seq::type_id::create("seq2");
        seq3=APB_Write_Invalid_Seq::type_id::create("seq3");
        seq4=APB_Read_Seq::type_id::create("seq4");
        seq5=APB_Read_Invalid_Seq::type_id::create("seq5");
        seq6=APB_Write_Read_Seq::type_id::create("seq6");
        base_seq.num_transactions=512;
        seq1.num_transactions=512;
        seq2.num_transactions=512;
        seq3.num_transactions=512;
        seq4.num_transactions=512;
        seq5.num_transactions=512;
        seq6.num_transactions=512;
        
    endfunction
    task run_phase(uvm_phase phase);
        super.run_phase(phase);
        env.agent.sequencer.set_arbitration(SEQ_ARB_RANDOM);
        phase.raise_objection(this);
        seq1.start(env.agent.sequencer);
       wait(seq1.finish_tr==1);
         seq2.start(env.agent.sequencer);
         wait(seq2.finish_tr==1);
         seq3.start(env.agent.sequencer);
         wait(seq3.finish_tr==1);
         seq4.start(env.agent.sequencer);
         wait(seq4.finish_tr==1);
         seq5.start(env.agent.sequencer);
         wait(seq5.finish_tr==1);
        seq6.start(env.agent.sequencer);
        wait(seq6.finish_tr==1);
        phase.drop_objection(this);
    endtask
function void configure_env();
    uvm_config_db#(bit)::set(this,"*","agent_is_active", 1'b1);
endfunction
endclass:APB_Test