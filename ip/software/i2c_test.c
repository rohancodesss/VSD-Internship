#define I2C_BASE 0x20000000

#define CTRL   (*(volatile unsigned int*)(I2C_BASE + 0x00))
#define CLKDIV (*(volatile unsigned int*)(I2C_BASE + 0x04))
#define ADDR   (*(volatile unsigned int*)(I2C_BASE + 0x08))
#define TXDATA (*(volatile unsigned int*)(I2C_BASE + 0x0C))
#define STATUS (*(volatile unsigned int*)(I2C_BASE + 0x14))

int main() {

    // Set I2C clock speed (simple divider)
    CLKDIV = 100;

    // Set slave address (7-bit)
    ADDR = 0x50;

    // Data to send
    TXDATA = 0xA5;

    // Start transaction
    CTRL = 1;

    // Wait until BUSY = 0
    while (STATUS & 0x1);

    // Optional: check DONE flag
    if (STATUS & 0x2) {
        // success
    }

    // Optional: check NACK
    if (STATUS & 0x4) {
        // error
    }

    return 0;
}