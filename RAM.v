module RAM(clk , rst_n , din , rx_valid , dout , tx_valid);
parameter MEM_DEPTH = 256;
parameter ADDR_SIZE = 8;
input [(ADDR_SIZE + 2)-1:0]din;
input clk , rst_n , rx_valid;
output reg [ADDR_SIZE-1:0]dout;
output reg tx_valid;
reg [ADDR_SIZE-1:0] mem [MEM_DEPTH-1:0];
reg [ADDR_SIZE-1:0]address;
always @(posedge clk) begin
    if(~rst_n) begin 
        dout <= 0;
        tx_valid <= 0;
        address <= 0;
    end
    else begin 
            case (din[9:8])
                2'b00: begin  if(rx_valid) begin 
                    address <= din[ADDR_SIZE-1:0];
                end
                end
                2'b01: begin if(rx_valid) begin 
                    mem[address] <= din[ADDR_SIZE-1:0];
                end
                end
                2'b10: begin if(rx_valid) begin 
                    address <= din[ADDR_SIZE-1:0];
                end
                end
                2'b11: begin 
                    dout <= mem[address];
                    tx_valid = (din[9:8] == 2'b11);
                end
            endcase
    end
end
endmodule