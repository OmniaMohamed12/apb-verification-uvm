/*######################################################################*\
## File Name: APB_Sequences.svh   
## Author : Omnia Mohamed
## Date: jun 2024
## 
\*######################################################################*/
import uvm_pkg::*;
`ifndef APB_Base_Seq
`define APB_Base_Seq
class APB_Base_Seq extends uvm_sequence#(APB_Sequence_Item);
`uvm_object_utils(APB_Base_Seq);
APB_Sequence_Item seq_item;
int num_transactions;
extern function new(string name="APB_Base_Seq");
extern virtual task body();
extern virtual task do_item();

endclass:APB_Base_Seq
function APB_Base_Seq:: new(string name="APB_Base_Seq");
    super.new(name);
endfunction:new
task APB_Base_Seq::body();
    repeat(num_transactions)begin
        do_item();
    end
endtask:body
task APB_Base_Seq::do_item();
    seq_item=APB_Sequence_Item::type_id::create("seq_item");
    start_item(seq_item);
    `uvm_info("APB_Base_Seq","APB_Base_Seq is starting an item", UVM_LOW)
    assert(seq_item.randomize())
    else
     `uvm_error("APB_Base_Seq","randomization failed")
    `uvm_info("APB_Base_Seq","APB_Base_Seq is randomizing an item", UVM_LOW)
    finish_item(seq_item);
    `uvm_info("APB_Base_Seq","APB_Base_Seq is finishing an item", UVM_LOW)
        
    endtask:do_item
`endif //`ifndef APB_Base_Seq
`ifndef APB_Reset_Seq
`define APB_Reset_Seq
class APB_Reset_Seq extends APB_Base_Seq;
`uvm_object_utils(APB_Reset_Seq);
APB_Sequence_Item seq_item;
int finish_tr=0;
extern function new(string name="APB_Reset_Seq");
extern virtual task body();
extern virtual task do_item();

endclass:APB_Reset_Seq
function APB_Reset_Seq:: new(string name="APB_Reset_Seq");
    super.new(name);
endfunction:new
task APB_Reset_Seq::body();
    repeat(num_transactions)begin
        do_item();
    end
    finish_tr=1;
endtask:body
task APB_Reset_Seq::do_item();
    seq_item=APB_Sequence_Item::type_id::create("seq_item");
    start_item(seq_item);
    `uvm_info("APB_Reset_Seq","APB_Reset_Seq is starting an item", UVM_LOW)
    assert(seq_item.randomize()with {PRESETn==0; PWRITE==1'b0;PENABLE==0;PSELx==0;PWDATA==32'h0000_0000;})
    else `uvm_error("APB_Reset_Seq","randomization failed")
    `uvm_info("APB_Reset_Seq","APB_Reset_Seq is randomizing an item", UVM_LOW)
    finish_item(seq_item);
    `uvm_info("APB_Reset_Seq","APB_Reset_Seq is finishing an item", UVM_LOW)
        
    endtask:do_item
`endif //`ifndef APB_Reset_Seq
`ifndef APB_Write_Seq
`define APB_Write_Seq
class APB_Write_Seq extends APB_Base_Seq;
`uvm_object_utils(APB_Write_Seq);
APB_Sequence_Item seq_item;
int finish_tr=0;
extern function new(string name="APB_Write_Seq");
extern virtual task body();
extern virtual task do_item();

endclass:APB_Write_Seq
function APB_Write_Seq:: new(string name="APB_Write_Seq");
    super.new(name);
endfunction:new
task APB_Write_Seq::body();
    repeat(num_transactions)begin
        do_item();
    end
   finish_tr=1;
endtask:body
task APB_Write_Seq::do_item();
    seq_item=APB_Sequence_Item::type_id::create("seq_item");
    start_item(seq_item);
    `uvm_info("APB_Write_Seq","APB_Write_Seq is starting an item", UVM_LOW)
    assert(seq_item.randomize()with {PRESETn==1;PWRITE==1;})
    else `uvm_error("APB_Write_Seq","randomization failed")
    `uvm_info("APB_Write_Seq","APB_Write_Seq is randomizing an item", UVM_LOW)
    finish_item(seq_item);
    `uvm_info("APB_Write_Seq","APB_Write_Seq is finishing an item", UVM_LOW)
        
    endtask:do_item
`endif //`ifndef APB_Write_Seq
`ifndef APB_Write_Invalid_Seq
`define APB_Write_Invalid_Seq
class APB_Write_Invalid_Seq extends APB_Base_Seq;
`uvm_object_utils(APB_Write_Invalid_Seq);
APB_Sequence_Item seq_item;
int finish_tr=0;

extern function new(string name="APB_Write_Invalid_Seq");
extern virtual task body();
extern virtual task do_item();

endclass:APB_Write_Invalid_Seq
function APB_Write_Invalid_Seq:: new(string name="APB_Write_Invalid_Seq");
    super.new(name);
endfunction:new
task APB_Write_Invalid_Seq::body();
    repeat(num_transactions)begin
        do_item();
    end
   finish_tr=1;
endtask:body
task APB_Write_Invalid_Seq::do_item();
    seq_item=APB_Sequence_Item::type_id::create("seq_item");
    seq_item.addr_valid.constraint_mode(0);
    start_item(seq_item);
    `uvm_info("APB_Write_Invalid_Seq","APB_Write_Invalid_Seq is starting an item", UVM_LOW)
    assert(seq_item.randomize()with {PRESETn==1;PWRITE==1;PADDR>=32;})
    else `uvm_error("APB_Write_Invalid_Seq","randomization failed")
    `uvm_info("APB_Write_Invalid_Seq","APB_Write_Invalid_Seq is randomizing an item", UVM_LOW)
    finish_item(seq_item);
    `uvm_info("APB_Write_Invalid_Seq","APB_Write_Invalid_Seq is finishing an item", UVM_LOW)
    endtask:do_item
`endif //`ifndef APB_Write_Invalid_Seq
`ifndef APB_Read_Seq
`define APB_Read_Seq
class APB_Read_Seq extends APB_Base_Seq;
`uvm_object_utils(APB_Read_Seq);
APB_Sequence_Item seq_item;
int finish_tr=0;
extern function new(string name="APB_Read_Seq");
extern virtual task body();
extern virtual task do_item();

endclass:APB_Read_Seq
function APB_Read_Seq:: new(string name="APB_Read_Seq");
    super.new(name);
endfunction:new
task APB_Read_Seq::body();
    repeat(num_transactions)begin
        do_item();
    end
    finish_tr=1;
endtask:body
task APB_Read_Seq::do_item();
    seq_item=APB_Sequence_Item::type_id::create("seq_item");
    start_item(seq_item);
    `uvm_info("APB_Read_Seq","APB_Read_Seq is starting an item", UVM_LOW)
    assert(seq_item.randomize()with {PRESETn==1;PWRITE==0;})
    else `uvm_error("APB_Read_Seq","randomization failed")
    `uvm_info("APB_Read_Seq","APB_Read_Seq is randomizing an item", UVM_LOW)
    finish_item(seq_item);
    `uvm_info("APB_Read_Seq","APB_Read_Seq is finishing an item", UVM_LOW)
        
    endtask:do_item
`endif //`ifndef APB_Read_Seq
`ifndef APB_Read_Invalid_Seq
`define APB_Read_Invalid_Seq
class APB_Read_Invalid_Seq extends APB_Base_Seq;
`uvm_object_utils(APB_Read_Invalid_Seq);
APB_Sequence_Item seq_item;
int finish_tr=0;
int num_transactions=0;

extern function new(string name="APB_Read_Invalid_Seq");
extern virtual task body();
extern virtual task do_item();

endclass:APB_Read_Invalid_Seq
function APB_Read_Invalid_Seq:: new(string name="APB_Read_Invalid_Seq");
    super.new(name);
endfunction:new
task APB_Read_Invalid_Seq::body();
    repeat(num_transactions)begin
        do_item();
    end
    finish_tr=1;
endtask:body
task APB_Read_Invalid_Seq::do_item();
    seq_item=APB_Sequence_Item::type_id::create("seq_item");
    seq_item.addr_valid.constraint_mode(0);
    start_item(seq_item);
    `uvm_info("APB_Read_Invalid_Seq","APB_Read_Invalid_Seq is starting an item", UVM_LOW)
    assert(seq_item.randomize()with {PRESETn==1;PWRITE==0;PADDR>=32;})
    else `uvm_error("APB_Read_Invalid_Seq","randomization failed")
    `uvm_info("APB_Read_Invalid_Seq","APB_Read_Invalid_Seq is randomizing an item", UVM_LOW)
    finish_item(seq_item);
    `uvm_info("APB_Read_Invalid_Seq","APB_Read_Invalid_Seq is finishing an item", UVM_LOW)
    endtask:do_item
`endif //`ifndef APB_Read_Invalid_Seq
`ifndef APB_Write_Read_Seq
`define APB_Write_Read_Seq
class APB_Write_Read_Seq extends APB_Base_Seq;
`uvm_object_utils(APB_Write_Read_Seq);
APB_Sequence_Item seq_item;
int finish_tr=0;
extern function new(string name="APB_Write_Read_Seq");
extern virtual task body();
extern virtual task do_item();

endclass:APB_Write_Read_Seq
function APB_Write_Read_Seq:: new(string name="APB_Write_Read_Seq");
    super.new(name);
endfunction:new
task APB_Write_Read_Seq::body();
    repeat(num_transactions)begin
        do_item();
    end
    finish_tr=1;
endtask:body
task APB_Write_Read_Seq::do_item();
    seq_item=APB_Sequence_Item::type_id::create("seq_item");
    start_item(seq_item);
    `uvm_info("APB_Write_Read_Seq","APB_Write_Read_Seq is starting an item", UVM_LOW)
    assert(seq_item.randomize()with {PRESETn==1;PWRITE==1;})
    else `uvm_error("APB_Write_Read_Seq","randomization failed")
    `uvm_info("APB_Write_Read_Seq","APB_Write_Read_Seq is randomizing an item", UVM_LOW)
    finish_item(seq_item);
    `uvm_info("APB_Write_Read_Seq","APB_Write_Read_Seq is finishing an item", UVM_LOW)
    start_item(seq_item);
    `uvm_info("APB_Write_Read_Seq","APB_Write_Read_Seq is starting an item", UVM_LOW)
    assert(seq_item.randomize()with {PRESETn==1;PWRITE==0;})
    else `uvm_error("APB_Write_Read_Seq","randomization failed")
    `uvm_info("APB_Write_Read_Seq","APB_Write_Read_Seq is randomizing an item", UVM_LOW)
    finish_item(seq_item);
    `uvm_info("APB_Write_Read_Seq","APB_Write_Read_Seq is finishing an item", UVM_LOW)
    endtask:do_item
`endif //`ifndef APB_Write_Read_Seq
