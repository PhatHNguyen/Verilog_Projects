module UARTTransmitter(
	input clk,
			en,
			start,
	input [7:0] data_in,
	output reg busy,
				  done,
				  out
);
	
parameter Reset =        3'b000;
parameter Idle =         3'b001;
parameter Start_Bit  =   3'b010;
parameter Send_Bits =    3'b011;
parameter Stop_Bit =     3'b100; 
	
reg [2:0] current_state = Reset;
reg [2:0] bit_index = 0;
reg [7:0] temp_data = 0;

always@(negedge clk) begin
	if(~en) begin 
		current_state <= Reset;
	end 
end

always@(posedge clk) begin
	case(current_state)
	Reset: begin 
		busy <= 0;
		done <= 0;
		out <= 1;
		bit_index <= 0;
		if(en) begin
			current_state <= Idle;
		end
	end
	Idle: begin
		busy <= 0;
		done <= 0;
		out <= 1;
		if(start) begin
			current_state <= Start_Bit;
		end
	end
	Start_Bit: begin
		busy <= 1;
		done <= 0;
		out <= 0;
		temp_data <= data_in;
		current_state <= Send_Bits;
	end
	Send_Bits: begin
		busy <= 1;
		done <= 0;
		out <= temp_data[0];
		temp_data <= temp_data << 1;
		bit_index <= bit_index + 1;
		if(&bit_index) begin
			current_state <= Stop_Bit;
		end
	end
	Stop_Bit: begin
		busy <= 0;
		done <= 1;
		out <= 1;
		if(start) begin
			current_state <= Start_Bit;
		end else begin
			current_state <= Reset;
		end
	end
	default: begin
		current_state <= Reset;
	end
end
endmodule
