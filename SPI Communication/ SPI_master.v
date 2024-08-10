module SPI_master #(
    parameter DATALENGTH = 16,
    parameter DELAY = 0,
    parameter mode = 0
)(
    input reset,
    input clk,
    input start,
    input miso,
    input [DATALENGTH - 1:0] data_in,
    output reg [DATALENGTH - 1:0] data_out,
    output reg cs_n,
    output reg sclk,
    output reg mosi, 
    output reg busy
);

// State definitions
localparam IDLE        = 3'b000,
           CSN_LOW     = 3'b001, 
           CSN_HIGH    = 3'b010,
           CLK_HIGH    = 3'b011,
           CLK_LOW     = 3'b100,
           CLK_LOW_END = 3'b101;

reg [2:0] state;
reg [3:0] bit_count;
reg [DATALENGTH-1:0] shift_reg;
reg [DELAY-1:0] delay_counter;

always @(posedge clk or posedge reset) begin 
    if (reset) begin
        state <= IDLE;
        bit_count <= 0;
        shift_reg <= 0;
        delay_counter <= 0;
        cs_n <= 1;
        sclk <= 0;
        mosi <= 0;
        busy <= 0;
    end else begin
        case(state)
            IDLE: begin
                cs_n <= 1;
                sclk <= 0;
                mosi <= 0;
                busy <= 0;
                bit_count <= 0;
                delay_counter <= DELAY;
                if (start) begin
                    state <= CSN_LOW;
                    shift_reg <= data_in;
                end
            end
            CSN_LOW: begin
                busy <= 1;
                cs_n <= 0;
                mosi <= shift_reg[DATALENGTH-1];
                bit_count <= DATALENGTH - 1;
                state <= CLK_HIGH; 
            end
            CLK_HIGH: begin
                sclk <= 1;
                shift_reg <= {shift_reg[DATALENGTH-2:0], miso};
                state <= CLK_LOW;
            end
            CLK_LOW: begin
                sclk <= 0;
                mosi <= shift_reg[DATALENGTH-1];
                if (bit_count == 0) begin
                    state <= CLK_LOW_END;
                end else begin
                    state <= CLK_HIGH;
                    bit_count <= bit_count - 1;
                end
            end
            CLK_LOW_END: begin
                if (delay_counter == 0) begin
                    state <= CSN_HIGH;
                end else begin
                    delay_counter <= delay_counter - 1;
                end
            end
            CSN_HIGH: begin
                cs_n <= 1; 
                data_out <= shift_reg;
                if (~start) begin
                    state <= IDLE;
                end 
            end
        endcase
    end
end 

endmodule
