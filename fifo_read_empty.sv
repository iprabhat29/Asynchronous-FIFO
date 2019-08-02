module fifo_read_empty #(parameter size = 8)(
  input 										clk,
  												rst_n,
  												rinc,
  							[size-1 : 0 ] 		rq2_wptr,
  output                  	[size-2 : 0 ] 		radr,
  							[size-1: 0] 		rptr,
  												rempty
);
  
  logic [size-2:0] 	radr;
  logic [size-1:0] 	rptr;
  logic rempty;
  
  gray_counter #(size) read_gray 
  								( .clk(clk),
                                   .rst_n(rst_n),
                                   .inc(rinc),
                                   .status(rempty),
                                   .adr(radr),
                                   .ptr(rptr)
                           		);
  
  
  assign rempty = (rptr == rq2_wptr);
  
endmodule
  
  