module UARTReceiver(
	input clk,
			en,
			data_in,
	output reg busy,
				  done,
	output reg [7:0] data_out
);

parameter Reset =        3'b000;
parameter Idle =         3'b001;
parameter Start_Bit  =   3'b010;
parameter Receive_Bits = 3'b011;
parameter Stop_Bit =     3'b100;

reg [2:0] current_state <= Reset;
reg [2:0] next_state;
reg [7:0] temp_data = 0;
reg [3:0] sample_count = 0;
/*
double register synchronization -
provides an extra clock cycle for any metastability
when transitioning from one clock domain to another 
*/
wire bit_sync
reg[1:0] double_reg = 2'b11;

always@(posedge clk) begin
	double_reg <= {doublereg[0], data_in};
end

assign bit_sync = double_reg[1]; 


/*
allow user to disable receiver 
*/
always@(negedge clk) begin
	if(~en) begin 
		current_state <= Reset;
	end else begin
		current_state <= next_state;
	end
end

/*
Finite state machine
*/
always@(posedge clk) begin
	case(current_state)
	Reset: begin 
		busy <= 0;
		done <= 0;
		bit_index <= 0;
		temp_data <= 0;
		data_out <= 0;
		if(en) begin
			next_state; <= Idle;
		end
	end
	
	Idle: begin
		busy <= 0;
		done <= 0;
		if(bit_sync = 0) begin
			next_state <= Start_Bit;
		end else begin
			next_state <= Idle;
		end
	end
	
	Start_Bit: begin
		busy <= 1;
		done <= 0;
		if(sample_count == 7) begin
			if(bit_sync == 0) begin
				next_state <= Receive_Bits;
			end
		end else begin
			sample_count <= sample_count + 1;
		end
	end
	
	Receive_Bits: begin 
		busy <= 1;
		done <= 0;
		if(sample_count == 7) begin
			temp_data <= {temp_data[7:1],bit_sync};
			bit_index <= bit_index + 1;
			if(bit_index == 7) begin
				next_state <= Stop_Bit;
			end 
		end else begin
			sample_count <= sample_count + 1;
		end
	end
	
	Stop_Bit: begin
		if(sample_count == 7) begin
			if(bit_sync == 1) begin
				busy <= 0;
				done <= 1;
				data_out <= temp_data;
				next_state <= Reset;
			end else begin 
				next_state <= Stop_Bit; 
			end
		end else begin 
			sample_count <= sample_count + 1;
		end 
	end
	
	default: begin
		next_state <= Reset;
	end
end
