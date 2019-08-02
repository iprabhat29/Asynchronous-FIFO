module gray_counter #(parameter size = 8)(
    input                   				clk,
                           			 		rst_n,
                            				inc,
                            				status,
  	output                  	[size-2:0] 	adr,
  								[size-1:0] 	ptr);

  logic [size-1 : 0] bnext;
  logic [size-1 : 0] gnext;
  logic [size-1 : 0] bin;
  logic [size-1 : 0] ptr_temp;
  logic [size-2 : 0] adr;
  logic [size-1 : 0] ptr;

    //assign bnext = (!rst_n) ? 0 : bin + (inc & !status);

    assign adr = bin[size - 2 : 0];
  
    always @(inc,status,rst_n,bin) begin
      if(!rst_n) bnext = 0;
      else if(inc & !status) begin
        bnext = bin + (inc & !status);
      end
      else bnext = bin;
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            bin <= 0;
        end
        else begin
            bin <= bnext;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            ptr_temp = 0;
        end
        else begin
            ptr_temp <= gnext;
        end
    end

    assign ptr = ptr_temp;

    assign gnext = bnext ^ (bnext >> 1);

endmodule