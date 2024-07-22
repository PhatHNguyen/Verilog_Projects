module tb_FIFO();

reg [31:0] data_in;
reg clk;
reg en;
reg rd;
reg rst;
reg wr;

wire [31:0] data_out;
wire empty; 
wire full;

FIFO_Buffer UUT(
	.data_in(data_in),
	.clk(clk),
	.en(en),
	.rd(rd),
	.rst(rst),
	.wr(wr),
	.data_out(data_out),
	.empty(empty),
	.full(full)
);

initial begin
	clk = 0;
	forever #5 clk <= ~clk;
end

initial begin
	resetMemory;
	storeData;
	readAndStoreData;
	readData;
end

task resetMemory;
	begin 
	rst = 0;
	en = 0;
	rd = 0;
	wr = 0;
	repeat (2) @(posedge clk);
	rst = 1; 
	repeat (2) @(posedge clk);
	end
endtask

task storeData;
	begin 
	en = 1;
	wr = 1;
	data_in = 1;
	repeat(1) @(posedge clk);
	data_in = 2;
	repeat(1) @(posedge clk);
	data_in = 3;
	repeat(1) @(posedge clk);
	data_in = 4;
	repeat(1) @(posedge clk);
	data_in = 5;
	repeat(1) @(posedge clk);
	data_in = 6;
	repeat(1) @(posedge clk);
	data_in = 7;
	repeat(1) @(posedge clk);
	data_in = 8;
	repeat(1) @(posedge clk);
	end
endtask
	
task readAndStoreData;
	begin
	wr = 0;
	rd = 1;
	repeat(4) @(posedge clk);
	wr = 1;
	rd =0;
	data = 9;
	repeat(1) @(posedge clk);
	data_in = 10;
	repeat(1) @(posedge clk);
	data_in = 11;
	repeat(1) @(posedge clk);
	data_in = 12;
	repeat(1) @(posedge clk);
	end
endtask

task readData;
	begin
	wr = 0;
	rd = 1;
	repeat(9) @(posedge clk);
	rst = 1;
	repeat(1) @(posedge clk);
	end
endtask

endmodule
	
	
