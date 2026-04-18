# Example Usage

Example sequence:

CLKDIV = 100;
ADDR   = 0x50;
TXDATA = 0xA5;
CTRL   = 1;

while (STATUS & 0x1);

Result:
I2C transaction completes successfully.