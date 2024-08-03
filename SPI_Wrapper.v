module SPI_Wrapper(clk,rst_n,MISO,MOSI,SS_n);
parameter MEM_DEPTH = 256;
parameter ADDR_SIZE = 8;
input clk,rst_n,MOSI,SS_n;
output MISO;
wire rx_valid,tx_valid;
wire [(ADDR_SIZE + 2)-1:0]rx_data;
wire [ADDR_SIZE-1:0]tx_data;
RAM the_RAM(.clk(clk),.rst_n(rst_n),.din(rx_data),.rx_valid(rx_valid),.dout(tx_data),.tx_valid(tx_valid));
SPI_Slave SLAVE(.clk(clk),.rst_n(rst_n),.MISO(MISO),.MOSI(MOSI),.SS_n(SS_n),.rx_valid(rx_valid),.tx_valid(tx_valid),.rx_data(rx_data),.tx_data(tx_data));
endmodule