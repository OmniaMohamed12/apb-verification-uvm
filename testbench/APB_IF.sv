interface APB_IF();
    logic PCLK;
    logic PRESETn;
    logic [31:0] PADDR;
    logic PSELx;
    logic PENABLE;
    logic PWRITE;
    logic [31:0] PWDATA;
    logic PREADY;
    logic [31:0] PRDATA;
    logic PSLVERR;
    p1: assert property(@(posedge PCLK)
    (!PRESETn) |=> (PRDATA ==32'h0000_0000 && PSLVERR==1'b0))
        $display("Assertion is succeeded at %0t",$time);
    else
        $error("Assertion is Failed at%0t",$time);
    
    p2: assert property(@(posedge PCLK)
    disable iff(!PRESETn)
    ($rose(PSELx)) |=> ($rose(PENABLE) && $stable(PWDATA) && $stable(PWRITE) && $stable(PADDR)))
        $display("Assertion is succeeded at %0t",$time);
    else
        $error("Assertion is Failed at%0t",$time);
    p3: assert property(@(posedge PCLK)
    disable iff(!PRESETn)
    ($fell(PREADY)) |-> ($fell(PENABLE) && $fell(PSELx) ))
        $display("Assertion is succeeded at %0t",$time);
    else
        $error("Assertion is Failed at%0t",$time);    

endinterface