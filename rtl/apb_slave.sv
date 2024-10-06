
module apb_slave#(parameter DATA_WIDTH=32,parameter ADDR_WIDTH=32)
(
    input logic PCLK,
    input logic PRESETn,
    input logic [ADDR_WIDTH-1:0] PADDR,
    input logic PSELx,
    input logic PENABLE,
    input logic PWRITE,
    input logic [DATA_WIDTH-1:0] PWDATA,
    output logic PREADY,
    output logic [DATA_WIDTH-1:0] PRDATA,
    output logic PSLVERR);
    
    logic [1:0] current_State,next_state;
    logic [DATA_WIDTH-1:0] mem [32];
   
    always @(posedge PCLK) begin
        if(!PRESETn) begin
            //PREADY <= 1'b1;
            PRDATA <= 32'h0000_0000;
            PSLVERR <= 1'b0;
            foreach (mem[i]) begin
                mem[i] <= 32'h0000_0000;
            end
            PREADY <=1'b1;
            @(posedge PCLK);
            PREADY <=1'b0;
        end
        else begin 
            if(PSELx && PENABLE )begin
                //PREADY <=1'b1;
                if(PWRITE) begin //write operation
                    if(PADDR >=32'h0000_0020 )begin //the address is out of range
                            PSLVERR <=1'b1;
                    end
                    else begin
                        mem[PADDR] <=PWDATA;
                        PSLVERR <=1'b0;
                    end
                end
                else begin
                    if(PADDR >= 32'h0000_0020)begin //the address is out of range
                        PSLVERR <=1'b1;
                    end
                    else begin
                        PRDATA <=mem[PADDR];
                        PSLVERR <=1'b0;
                    end
                end
                PREADY <=1'b1;
                @(posedge PCLK);
                PREADY <=1'b0;
        end
        else begin
            PREADY <=1'b0;
        end
    end
    end
    endmodule
    