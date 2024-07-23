/*
Author:    Phat Nguyen
Date:      6/15/24
File Contents:
This module implements a simple SRAM (Static Random-Access Memory) controller with synchronous reset and single-clock cycle write and read operations.
The module utilizes an 8-bit data bus and a 3-bit address bus to access a 64-byte memory array, allowing user to store/read data from the bus.
*/
module SRAM_Control(

     input      clk,
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
	
