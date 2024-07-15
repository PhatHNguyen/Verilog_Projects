module tb_SRAMControl();

reg 	clk,
		rst,
      write,
		read;
reg [7:0] data_in;
reg [2:0] Addr;

wire data_out;

SRAM_Control UUT (

	.clk(clk),
	.rst(rst),
	.write(write),
	.read(read),
	.data_in(data_in),
	.Addr(Addr),
	.data_out(data_out)
	
);

initial begin 
	clk <= 0;
	forever #5 clk <= ~clk;
end

initial begin 
	resetButton;
	DataWrite;
	DataRead;
end


task resetButton;
   begin   
	rst = 1;
	repeat(5) @(posedge clk);
    data_in = 1;
	 Addr = 0;
	 write = 1;
	 read = 0;
	 rst = 0;
	repeat(2) @(posedge clk);
	 data_in = 2;
	 Addr = 1;
	 write = 1;
	 read = 0;
	 rst = 0;
	repeat(2) @(posedge clk);
	 data_in = 3;
	 Addr = 2;
	 write = 1;
	 read = 0;
	 rst = 0;
	repeat(2) @(posedge clk);
	 data_in = 4;
	 Addr = 3;
	 write = 1;
	 read = 0;
	 rst = 0; 
   repeat(10) @(posedge clk);
    data_in = 0;
	 Addr = 0;
	 write = 0;
	 read = 0;
	 rst = 1; 
	repeat(5) @(posedge clk);
	end
endtask

task DataWrite;
   begin   
    data_in = 1;
	 Addr = 0;
	 write = 1;
	 read = 0;
	 rst = 0;
	repeat(2) @(posedge clk);
	 data_in = 2;
	 Addr = 1;
	 write = 1;
	 read = 0;
	 rst = 0;
	repeat(2) @(posedge clk);
	 data_in = 3;
	 Addr = 2;
	 write = 1;
	 read = 0;
	 rst = 0;
	repeat(2) @(posedge clk);
	 data_in = 4;
	 Addr = 3;
	 write = 1;
	 read = 0;
	 rst = 0; 
   repeat(5) @(posedge clk);
	end
endtask

task DataRead;
   begin   
    data_in = 0;
	 Addr = 0;
	 write = 0;
	 read = 1;
	 rst = 0;
	repeat(2) @(posedge clk);
	 data_in = 0;
	 Addr = 0;
	 write = 0;
	 read = 1;
	 rst = 0;
	repeat(2) @(posedge clk);
	 data_in = 0;
	 Addr = 0;
	 write = 0;
	 read = 1;
	 rst = 0;
	repeat(2) @(posedge clk);
	 data_in = 0;
	 Addr = 0;
	 write = 0;
	 read = 1;
	 rst = 0; 
   repeat(5) @(posedge clk);
	end
endtask

endmodule
