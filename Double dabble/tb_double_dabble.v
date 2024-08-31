module tb_double_dabble();

reg clk;
reg enable;
reg [7:0] data_in;
wire [11:0] bcd;
wire done;

integer i;

double_dabble UUT( 
	.clk(clk),
	.enable(enable),
	.data_in(data_in),
	.bcd(bcd),
	.done(done)
);

initial begin
	clk <= 0;
	forever #5 clk <= ~clk;
end
initial begin
	enable = 0;
	repeat(2) @(posedge clk);
	for(i =0; i < 156; i = i + 1) begin
		data_in = 100 + i;
		repeat(2)@(posedge clk);
		enable = 1;
		wait(done);
		$display("data_input = %b = %d, bcd = %b",data_in,data_in,bcd);
		if(data_in != (100*bcd[19:16] + 10*bcd[15:12] + bcd[11:8])) begin
		 $display(" output is wrong!!!");
		 $stop;
		end
		/*
		data_in = 20;
		repeat(2)@(posedge clk);		
		wait(done)
		$display("data_input = %b = %d, bcd = %b",data_in,data_in,bcd);
		data_in = 24;
		repeat(2)@(posedge clk);		
		wait(done)
		$display("data_input = %b = %d, bcd = %b",data_in,data_in,bcd);
		data_in = 100;
		repeat(2)@(posedge clk);		
		wait(done)
		$display("data_input = %b = %d, bcd = %b",data_in,data_in,bcd);
		data_in = 98;
		repeat(2)@(posedge clk);		
		wait(done)
		$display("data_input = %b = %d, bcd = %b",data_in,data_in,bcd);
		*/
	end
	$display("Completed Simulation");
		
end

endmodule	
