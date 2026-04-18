# Integration Guide

The I2C IP is integrated into SoC using memory-mapped interface.

Address decode:
isI2C = isIO & mem_wordaddr[3]

Connected signals:
- mem_addr
- mem_wdata
- mem_wstrb
- mem_rstrb
- mem_rdata