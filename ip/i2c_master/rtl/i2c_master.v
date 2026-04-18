module i2c_master (
    input clk,
    input rst_n,

    input  [31:0] mem_addr,
    input  [31:0] mem_wdata,
    input         mem_wstrb,
    input         mem_rstrb,
    output reg [31:0] mem_rdata,

    output reg scl,
    inout  sda
);

reg [7:0] ctrl;
reg [15:0] clkdiv;
reg [6:0] addr;
reg [7:0] txdata;
reg [7:0] rxdata;
reg [2:0] status;

reg sda_out;
reg sda_oe;
assign sda = sda_oe ? sda_out : 1'bz;

wire [5:0] offset = mem_addr[7:2];

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        ctrl <= 0;
        clkdiv <= 100;
        addr <= 0;
        txdata <= 0;
    end else if (mem_wstrb) begin
        case(offset)
            0: ctrl   <= mem_wdata[7:0];
            1: clkdiv <= mem_wdata[15:0];
            2: addr   <= mem_wdata[6:0];
            3: txdata <= mem_wdata[7:0];
        endcase
    end
end

always @(*) begin
    case(offset)
        0: mem_rdata = {24'b0, ctrl};
        1: mem_rdata = {16'b0, clkdiv};
        2: mem_rdata = {25'b0, addr};
        3: mem_rdata = {24'b0, txdata};
        4: mem_rdata = {24'b0, rxdata};
        5: mem_rdata = {29'b0, status};
        default: mem_rdata = 32'b0;
    endcase
end

reg [15:0] count;
wire tick = (count == clkdiv);

always @(posedge clk or negedge rst_n) begin
    if (!rst_n)
        count <= 0;
    else if (tick)
        count <= 0;
    else
        count <= count + 1;
end

localparam IDLE=0, START=1, ADDR=2, DATA=3, STOP=4;
reg [2:0] state;
reg [3:0] bitcnt;
reg [7:0] shift;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= IDLE;
        scl <= 1;
        sda_oe <= 0;
        sda_out <= 1;
        status <= 0;
    end else if (tick) begin
        case(state)

        IDLE: begin
            scl <= 1;
            sda_oe <= 0;
            status[1] <= 0;
            if (ctrl[0]) begin
                status[0] <= 1;
                state <= START;
            end
        end

        START: begin
            sda_oe <= 1;
            sda_out <= 0;
            shift <= {addr,1'b0};
            bitcnt <= 7;
            state <= ADDR;
        end

        ADDR: begin
            scl <= 0;
            sda_out <= shift[bitcnt];
            scl <= 1;
            if (bitcnt == 0) begin
                shift <= txdata;
                bitcnt <= 7;
                state <= DATA;
            end else bitcnt <= bitcnt - 1;
        end

        DATA: begin
            scl <= 0;
            sda_out <= shift[bitcnt];
            scl <= 1;
            if (bitcnt == 0)
                state <= STOP;
            else bitcnt <= bitcnt - 1;
        end

        STOP: begin
            scl <= 1;
            sda_out <= 1;
            status[0] <= 0;
            status[1] <= 1;
            ctrl[0] <= 0;
            state <= IDLE;
        end

        endcase
    end
end

endmodule