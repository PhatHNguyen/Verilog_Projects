
The FIFO (First In First Out) moudles implements a 32-bit wide, 8-depth FIFO buffer. The buffer uses internal counters to manage read and write operations,
and a 256-bit memory array to store up to 8 data elements. On reset, the buffer is cleared, and its status flags are updated. When enabled, the buffer supports read and write operations,
updating the counters and status flags accordingly.
