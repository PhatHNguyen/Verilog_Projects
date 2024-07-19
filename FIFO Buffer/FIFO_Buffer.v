module FIFO_Buffer(
	input [31:0] data_in,
	input        clk,
					 en,
					 rd,
					 rst,
					 Wr,
	output reg [31:0] data_out,
	output reg        empty,
							full
);

reg [2:0] counter <= 0;
reg [2:0] write_counter <= 0;
reg [2:0] read_counter <= 0;
reg [255:0] memory <= 0;

always@(posedge clk) begin
	if(rst) begin
		memory <= 0;
		full <= 0;
		empty <= 1;
		counter <= 0;
	end else if(en) begin
		if(wr) begin
			memory [(32*write_counter)+:(31)] <= data_in;
			write_counter <= write_counter + 1;
		end else if(rd && counter != 0) begin
			data_out <= memory [(32*read_counter)+:(31)];
			read_counter <= read_counter + 1;
		end
	end
	if(read_counter >= write_counter) begin
		counter <= read_counter - write_counter
	end 
end  

endmodule 