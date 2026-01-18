
Tools:

RISC-V compiler: riscv64-unknown-elf-gcc

RISC-V simulator: spike

Verilog simulation: iverilog &  gtkwave

Build system: gcc, g++, make, autoconf, automake, libtool

Parsing / helper tools: bison, flex, gawk

Python support programs: python3, pip

Libraries: libmpc-dev, libmpfr-dev, libgmp-dev, zlib1g-dev, Boost, X11 headers

Environment management:
clean PATH ensures host system tools don’t conflict with RISC-V cross-tools.

RISC-V binaries and simulators are installed under /opt/riscv.