Q1: Where is the RISC-V program located?

A: The program's located in samples/

Q2: How is the program compiled and loaded into memory?
A: basically, you are compiling the human readable C code into something that something the CPU can understand also known as binary.

loading means putting that code (binary) into the CPU memory so it can execute (the CPU needs to RENEMBER what to execute.)

Spike and the proxy kernel are basically making the CPU think that it has real hardware to execute on.

 Q3: How does the RISC-V core access memory and memory-mapped I/O? 

A: the memory is where the CPU reads & writes data. memory mapped I/O is the special memory locations connected to hardware for input and output, for example

Q4:Where would a new FPGA IP block logically integrate?

A: the FPGA IP is a hardware module. It would be on the Memory I/O bus just like other hardware so the CPU can read/write to it
 
