module fifo_mem #(parameter dw = 16,
                  parameter aw = 8)(
  
  input 								clk,
  										rst_n,
  										wclken,
    					[dw - 1 : 0] 	wdata,
  						[aw - 1 : 0] 	waddr,
  						[aw - 1 : 0] 	raddr,
  output				[dw - 1 : 0] 	rdata
);
  
  logic [dw-1 : 0] mem [0 : 255];
  
  task reset_mem();
    for(int i = 0; i <= 255; i++) begin
      mem[i] <= 0;
    end
  endtask
  
  always @(posedge clk or negedge rst_n) begin
    if(!rst_n) begin
      reset_mem();
    end
    else begin
      if(wclken) begin
        mem[waddr] <= wdata;
      end
      else;
    end
  end
  
  assign rdata = mem[raddr];
  
endmodule
  
  
  