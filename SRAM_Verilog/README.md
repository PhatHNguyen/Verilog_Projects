#Overview of SRAM:

The SRAM_Control module is an 8-byte SRAM, designed to manage read and write operations efficiently.
It features input ports for clock, reset, write enable, read enable, 8-bit data input, and a 3-bit address,
along with an 8-bit data output. On the rising edge of the clock, if the reset signal is high, the memory is cleared. If the write signal is high,
data input is stored at the specified address. If the read signal is high, the data from the specified address is the output. As a result, the 
SRAM_Control module writes/reads data from its memory. 
