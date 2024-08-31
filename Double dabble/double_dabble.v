module double_dabble (input clk,
							 input enable,
							 input [7:0] data_in,
						    output reg [11:0] bcd,
							 output reg done); 
							  
parameter Idle = 3'b000;
parameter Shift = 3'b001;
parameter Add = 3'b010;
parameter Completed = 3'b011;

reg [19:0] temp_data;
reg [2:0] state = Idle;
reg [3:0] shift_counter = 0;
reg busy = 0;

always@(posedge clk) begin
	
	case(state) 
	
		Idle: begin
			done <= 0;
			if(enable) begin
				state <= Add;
				temp_data <= data_in;
				busy <= 1;
			end
		end
		
		Shift: begin
			if(shift_counter < 8) begin
				shift_counter <= shift_counter + 1;
				temp_data <= temp_data << 1;
				state <= Add;
			end else begin
				shift_counter <= 0;
				state <= Completed;
			end
		end
		
		Add: begin
			if(shift_counter < 8) begin
				if(temp_data[19-:4] > 4 )begin
					temp_data[19:16] = temp_data[19:16] + 3;
					
				end if(temp_data[15-:4] > 4) begin
					temp_data[19:12] = temp_data[19:12] + 3;
				end if(temp_data[11-:4] > 4) begin
					temp_data[19:8] = temp_data[19:8] + 3;
				end  
			end
				state <= Shift;			
		end
		
		Completed: begin
			busy <= 0;
			state <= Idle;
			bcd <= temp_data[19:8];
			done <= 1;
		end
	 endcase
end
	
endmodule 
		
		
		
 

