`timescale 1ns/1ps

module tb_i2c_master;

reg clk = 0;
always #5 clk = ~clk;

reg rst_n = 0;
reg [31:0] mem_addr;
reg [31:0] mem_wdata;
reg mem_wstrb;
reg mem_rstrb;
wire [31:0] mem_rdata;
wire scl;
wire sda;

i2c_master dut(
    .clk(clk),
    .rst_n(rst_n),
    .mem_addr(mem_addr),
    .mem_wdata(mem_wdata),
    .mem_wstrb(mem_wstrb),
    .mem_rstrb(mem_rstrb),
    .mem_rdata(mem_rdata),
    .scl(scl),
    .sda(sda)
);

initial begin
    $dumpfile("i2c_master.vcd");
    $dumpvars(0, tb_i2c_master);

    #20 rst_n = 1;

    mem_addr = 0;
    mem_wdata = 32'h1;
    mem_wstrb = 1;
    #10 mem_wstrb = 0;

    #2000;
    $finish;
end

endmodule