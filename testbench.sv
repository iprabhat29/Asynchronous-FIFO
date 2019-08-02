// Code your testbench here
// or browse Examples
module gc_tb;
  localparam ASIZE = 4;
  localparam WSIZE = 16;
  logic rrst_n,wrst_n,mrst_n,winc,rinc;
  bit wclk,rclk,mclk;
  logic wfull,rempty;
  logic [WSIZE - 1: 0] wdata;
  logic [WSIZE - 1: 0] rdata;
    
  task write();
    if(!wfull) begin
      	winc <= 1;
    	wdata <= $random;
    	@(posedge wclk);
    end
    else ;
  endtask  
  
  task read();
    if(!rempty) begin
      rinc <= 1;
      @(posedge rclk);
    end
    else ;
  endtask
  
  
  initial forever #10 wclk = ~ wclk;
  initial forever #4 rclk  = ~ rclk;
  initial forever #20 mclk = ~ mclk;
  
  initial begin
    wrst_n <= 0;
    rrst_n <= 0;
    mrst_n <= 0;
    #50;
    wrst_n <= 1;
    rrst_n <= 1;
    mrst_n <= 1;
    @(posedge wclk);
    #10;
    write();
    winc <= 0;
    @(posedge wclk);
    write();
    winc <= 0;
    @(posedge wclk);
    write();
    winc <= 0;
    @(posedge wclk);
    write();
    winc <= 0;
    @(posedge wclk);
    write();
    winc <= 0;
    @(posedge wclk);
    write();
    winc <= 0;
    @(posedge wclk);
    write();
    winc <= 0;
    @(posedge wclk);   
    write();
    winc <= 0;
    @(posedge wclk);
    write();
    winc <= 0;
    @(posedge wclk);
    write();
    winc <= 0;
    @(posedge wclk);
    read();
    rinc <= 0;
    @(posedge rclk);
  end
  
  fifo_top #(ASIZE,WSIZE) fifo_top_inst( .mclk(mclk),
                                         .mrst_n(mrst_n),
                                         .wclk(wclk),
                                         .wrst_n(wrst_n),
                                         .rclk(rclk),
                                         .rrst_n(rrst_n),
                                         .winc(winc),
                                         .wdata(wdata),
                                         .rinc(rinc),
                                         .rdata(rdata),
                                         .wfull(wfull),
                                         .rempty(rempty)
                        );
  
  initial #1000 $finish;
  
  initial begin
    $dumpfile("dump.vcd"); 
    $dumpvars;
  end
  
  
endmodule
  