# IP User Guide

This IP implements a memory-mapped I2C Master.

Steps to use:
1. Configure CLKDIV
2. Set ADDR
3. Write TXDATA
4. Set CTRL = 1
5. Wait for STATUS.DONE

Outputs:
- SCL toggles
- SDA transmits data