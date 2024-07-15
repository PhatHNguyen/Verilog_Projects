module SRAM_Control(

	input     clk,
				 rst,
             write,
			    read,
     [7:0]   data_in,
	  [2:0]   Addr,
	
   output reg [7:0] data_out
);

reg [63:0] memory;

always@(posedge clk) begin
	if (rst) begin 
		memory <= 0;
	end else begin 
		if(write) begin
			memory [(8*Addr)+:(7)] <= data_in;
		end else if(read) begin
			data_out <= memory [(8*Addr)+:(7)];
		end
	end
end	
endmodule 			
	