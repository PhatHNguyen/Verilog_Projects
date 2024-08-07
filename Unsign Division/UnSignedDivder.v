/*
Author:    Phat Nguyen
Date:      7/1/24
File Contents:
This module performs unsigned divsion between two numbers using the following alogrithmn
https://www.javatpoint.com/restoring-division-algorithm-for-unsigned-integer
*/
module UnSignedDivider(
	input clk,
		  reset,
		  start,
	input [31:0] number_A,
	input [31:0] number_B,
	output [31:0] quotient,
	output [31:0] remainder,
	output error,
		   ready
)

reg working;
reg [4:0] stages;
reg [31:0] result;
reg [31:0] divsor;
reg [31:0] current_remainder;

// check for overflow 
wire [31:0] sub = {curent_remainder[30:0],result[31]} - divsor;

always @(posdege clk,posedge reset) begin
	if(reset) begin
		result <= 0;
		stages <= 0;
		divisor <= 0;
		current_remainder <= 0;
	end else if(start) begin
		if(active) begin
			// If overflow does not occur, update curent_remainder and update result with a 1
			if(sub[31] == 0) begin
				curent_remainder <= sub;
				result <= {result[30:0], 1};
			end else if(sub[31] == 1) begin
			// If overflow does occur, restore the current_remainder to its previous value and update result with a 0
				current_remainder <= {curent_remainder[30:0],result[31]};
				result <= {result[30:0], 0};
			end
			if(stages == 31) begin
				active <= 0;
			end else begin
				active <= active + 1;
			end
		end else begin
			stages <= 0;
			result <= number_A;
			divisor <= number_B;
			curent_remainder <= 0;
			active <= 1;
		end 
	end
end

endmodule
