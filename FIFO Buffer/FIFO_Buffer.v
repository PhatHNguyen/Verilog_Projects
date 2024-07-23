module FIFO_Buffer(
	input [31:0] data_in,
	input        clk,
		     en,
		     rd,
		     rst,
		     wr,
	output reg [31:0] data_out,
	output reg        empty,
			  full
);

reg [2:0] counter <= 0;
reg [2:0] write_counter <= 0;
reg [2:0] read_counter <= 0;
reg [255:0] memory <= 0;

always@(posedge clk) begin
	// reset memory and status 
	if(rst) begin
		memory <= 0;
		full <= 0;
		empty <= 1;
		counter <= 0;
	end else if(en) begin
		// Write data to memory
		if(wr && counter < 8) begin
			memory [(32*write_counter)+:(31)] <= data_in;
			write_counter <= write_counter + 1;
		//read data from memory
		end else if(rd && counter != 0) begin
			data_out <= memory [(32*read_counter)+:(31)];
			read_counter <= read_counter + 1;
		end
	end

	// Update counter 
	if(read_counter > write_counter) begin
		counter <= read_counter - write_counter;
	end else if( write_counter > read_counter) begin
		counter <= write_counter - read_counter;
	end

	// Reset counters when reached maximum
	if(write_counter == 8) begin
	  write_counter <= 0;
	end
	if(read_counter == 8) begin
	  read_counter <= 0;
	end
end  

endmodule 
