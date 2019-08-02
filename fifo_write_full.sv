module fifo_write_full #(parameter size = 8)(
  input 								clk,
  										rst_n,
  										winc,
  							[size-1:0] 	wq2_rptr,
  output                  	[size-2:0] 	wadr,
  							[size-1:0] 	wptr,
  										wfull
);
  
  logic [size-1:0] 	wadr;
  logic [size:0] 	wptr;
  logic wfull;
  
  gray_counter #(size) write_gray
  							(	.clk(clk),
                             	.rst_n(rst_n),
                             	.inc(winc),
                             	.status(wfull),
                             	.adr(wadr),
                             	.ptr(wptr)
                            );
  
  
  
  assign wfull = (wq2_rptr[size-1] != wptr[size-1]) ? ((wq2_rptr[size-2] != wptr[size-2]) ? ((wq2_rptr[size-3:0] == wptr[size-3:0]) ? 1 : 0): 0) : 0;
  
  initial begin 
    $monitor("wq2_rptr[3] %b\t  wptr[3] %b\t  wq2_rptr[2] %b\t  wptr[2] %b\t wq2_rptr[1:0] %b\t  wptr[1:0] %b\n",wq2_rptr[size-1],wptr[size-1],wq2_rptr[size - 2],wptr[size - 2],wq2_rptr[size-3:0],wptr[size-3:0]);
  end
  
endmodule
  
  
  
  
  
  