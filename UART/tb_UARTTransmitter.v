module s();

reg clk;
reg en;
reg start;
reg [7:0] data_in;

wire busy;
wire done;
wire out;

// Instantiate the UARTTransmitter module
UARTTransmitter uut (
     .clk(clk),
     .en(en),
     .start(start),
     .data_in(data_in),
     .busy(busy),
     .done(done),
     .out(out)
);

initial begin 
	clk <= 0;
	forever #5 clk <= ~clk;
end

initial begin 
SendMultipleData;
end 


task SendMultipleData;
   begin   
		en = 0;
		start = 0;
		data_in = 8'b0;
	repeat(2) @(posedge clk);
		en = 1;
	repeat(2) @(posedge clk);
		data_in = 8'b10101010;
		start = 1;
	repeat(2) @(posedge clk);
		start = 0;
	wait(done);
	repeat(5) @(posedge clk)
		data_in = 8'b10101010;
		start = 1;
	repeat(2) @(posedge clk);
		start = 0;
	wait(done);
   repeat(10) @(posedge clk);
	end
endtask

initial begin
   // Monitor signals for debugging
   $display("clk: %b, en: %b, start: %b, data_in: %b, busy: %b, done: %b, out: %b",
                 clk, en, start, data_in, busy, done, out);
end

endmodule
	 
	 

