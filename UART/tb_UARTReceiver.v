module tb_UARTReceiver();

reg clk;
reg en;
reg data_in;

reg data = 8'b10101010;

wire busy;
wire done;
wire error;
wire [7:0] data_out;

UARTReceiver uut (
     .clk(clk),
     .en(en),
     .data_in(data_in),
     .busy(busy),
     .done(done),
	  .error(error),
     .data_out(data_out)
);

//clk generation
initial begin 
	clk <= 0;
	forever #5 clk <= ~clk;
end

initial begin
	ReceiveData;
end


task ReceiveData;
	integer i;
   begin   
		en = 0;
		data_in = 1;
	repeat(2) @(posedge clk);
		en = 1;
		data_in = 0;
	repeat(16) @(posedge clk);
		for(i == 0, i < 8,i = i + 1) begin
			data_in <= data[i];
			repeat(16) @(posedge clk)
		end 
	data_in <= 1;
	repeat(16) @(posedge clk)
	wait(done);
	end
endtask

endmodule
