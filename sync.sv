module sync #(parameter size = 8)(
  input 								clk,
  										rst_n,
  						[size-1 : 0] 		ptr,
  output 				[size-1 : 0]  	sptr
);
  logic [size-1  : 0]  sptr;
  logic [size-1  : 0]  temp_ptr;
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      sptr <= 0;
      temp_ptr <= 0;
    end
    else begin
      temp_ptr <= ptr;
      sptr <= temp_ptr;
    end
  end
  
endmodule