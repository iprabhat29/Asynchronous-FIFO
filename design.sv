`include "gray_counter.sv"
`include "sync.sv"
`include "fifo_write_full.sv"
`include "fifo_read_empty.sv"
`include "fifo_mem.sv"

module fifo_top #(parameter aw = 8,
                  parameter dw = 16)(
  
  input 								mclk,
  										mrst_n,
  										wclk,  										
  										wrst_n,
  										rclk,
  										rrst_n,
  					 					winc,
    								    rinc,
  						[dw - 1 : 0] 	wdata,
  output 				[dw - 1 : 0 ]	rdata,
  										wfull,
  										rempty);
  
  logic [aw-2:0] 		wadr;
  
  logic [aw-2:0] 		radr;
  
  logic [aw-1:0] 		rptr;
  
  logic [aw-1:0] 		wptr;
  
  logic [aw-1:0] 		rq2_wptr;
  
  logic [aw-1:0] 		wq2_rptr;
  
  logic [dw - 1 : 0 ]	rdata;
  
  logic					wfull;
  
  logic 				rempty;
  
  logic wclken;
  
  assign wclken = winc & !wfull;
  
  sync #(aw) wsync_inst	(
    					.clk(wclk),
    					.rst_n(wrst_n),
    					.ptr(rptr),
    					.sptr(wq2_rptr)
  						);  
  
  
  sync #(aw) rsync_inst	(
    					.clk(rclk),
    					.rst_n(rrst_n),
    					.ptr(wptr),
    					.sptr(rq2_wptr)
  						);
  
  
  fifo_write_full #(aw) fwr_inst(.clk(wclk),
                                 .rst_n(wrst_n),
                                 .winc(winc),
                                 .wq2_rptr(wq2_rptr),
                                 .wadr(wadr), 
                                 .wptr(wptr),
                                 .wfull(wfull)
                                );
  
  fifo_read_empty #(aw) frd_inst(.clk(rclk),
                                 .rst_n(rrst_n),
                                 .rinc(rinc),
                                 .rq2_wptr(rq2_wptr),
                                 .radr(radr),
                                 .rptr(rptr),
                                 .rempty(rempty)
                                );
  
  fifo_mem #(dw,aw) fmem_inst(.clk(mclk),
                              .rst_n(mrst_n),
                              .wclken(wclken),
                              .wdata(wdata),
                              .waddr(wadr),
                              .raddr(radr),
                              .rdata(rdata)
                             );
  
  
                              
endmodule