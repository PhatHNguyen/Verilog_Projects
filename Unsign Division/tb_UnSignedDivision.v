module tb_UnSignedDivision();

reg clk;
reg reset;
reg start;
reg [31:0] number_A;
reg [31:0] number_B;

wire [31:0] quotient;
wire [31:0] remainder;
wire error;
wire ready;

UnSignedDivision UUT (
    .clk(clk),
    .reset(reset),
    .start(start),
    .number_A(number_A),
    .number_B(number_B),
    .quotient(quotient),
    .remainder(remainder),
    .error(error),
    .ready(ready)
);

initial begin 
    clk <= 0;
    forever #5 clk <= ~clk;
end

initial begin 
    dividSmallNumbers;
    dividlargeNumbers;
    dividByZero;
end

task dividSmallNumbers;
  begin
    start = 0;
    reset = 1;
    repeat(1) @(posedge clk);
    reset = 0;
    number_A = 6;
    number_B = 2;
    repeat(1) @(posedge clk);
    start = 1;
    wait(ready);
    repeat(1) @(posedge clk);
    start = 0;
    reset = 1;
    repeat(1) @(posedge clk);
    reset = 0;
    number_A = 10;
    number_B = 3;
    repeat(1) @(posedge clk);
    start = 1;
    wait(ready);
    repeat(1) @(posedge clk);
  end
endtask 

task dividlargeNumbers;
  begin
    start = 0;
    reset = 1;
    repeat(1) @(posedge clk);
    reset = 0;
    number_A = 1250;
    number_B = 50;
    repeat(1) @(posedge clk);
    start = 1;
    wait(ready);
    repeat(1) @(posedge clk);
    start = 0;
    reset = 1;
    repeat(1) @(posedge clk);
    reset = 0;
    number_A = 864;
    number_B = 24;
    repeat(1) @(posedge clk);
    start = 1;
    wait(ready);
    repeat(1) @(posedge clk);
  end
endtask 

task dividByZero;
  begin
    start = 0;
    reset = 1;
    repeat(1) @(posedge clk);
    reset = 0;
    number_A = 1250;
    number_B = 0;
    repeat(1) @(posedge clk);
    start = 1;
    wait(error);
    repeat(1) @(posedge clk);  
   end
endtask 
 

endmodule

