module SPI_Slave(clk,rst_n,MISO,MOSI,SS_n,rx_valid,tx_valid,rx_data,tx_data);
parameter MEM_DEPTH = 256;
parameter ADDR_SIZE = 8;
input clk,rst_n,MOSI,SS_n,tx_valid;
input [ADDR_SIZE-1:0]tx_data;
output reg rx_valid;
output reg MISO;
reg internal_signal;
output reg [(ADDR_SIZE + 2)-1:0]rx_data;
reg [2:0] cs,ns;
reg [3:0]counter_4_bits;
integer i = 0 ;
/*
cases :
000 : IDLE
001 : CHK_CMD
010 : WRITE
011 : READ_ADD
100 : READ_DATA
*/
//next state :
always @(*) begin
   case (cs)
    3'h0 : begin 
        if(SS_n) begin 
            ns = 3'h0;
        end
        else begin 
            ns = 3'h1;
        end
    end
    3'h1 : begin 
        if(SS_n) begin 
            ns = 3'h0;
        end
        else begin 
            if(~MOSI) begin 
                ns = 3'h2;
            end
            else begin 
                if(~internal_signal) begin 
                    ns = 3'h3;
                end
                else begin 
                    ns = 3'h4;
                end
            end
        end
    end
    3'h2 : begin 
        if(SS_n) begin 
            ns = 3'h0;
        end
        else begin 
            ns = 3'h2;
        end
    end
    3'h3 : begin 
        if(SS_n) begin 
            ns = 3'h0;
        end
        else begin 
            ns = 3'h3;
        end
    end
    3'h4 : begin 
        if(SS_n) begin 
            ns = 3'h0;
        end
        else begin 
            ns = 3'h4;
        end
    end
   endcase
end
//current state :
always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin 
        cs <= 0;
    end
    else begin 
        cs <= ns;
    end
end
//output : 
always @(posedge clk or negedge rst_n) begin
    if(~rst_n) begin 
        internal_signal <= 0;
        rx_valid <= 0;
        counter_4_bits <= 0;
        rx_data <= 0;
        MISO <= 0;
    end
    else begin       
        internal_signal <= (rx_data[8]);
        if(cs == 0) begin 
          counter_4_bits <= 4'h0;
        end
        else if(cs == 1) begin 
            
        end
        else if(cs == 2) begin 
            rx_data[(ADDR_SIZE + 2)-1-counter_4_bits] <= MOSI;
            counter_4_bits <= counter_4_bits + 1'b1;
            if(counter_4_bits == 4'h9) begin 
                counter_4_bits <= 4'h0;
                rx_valid <= 1;
            end
            else begin 
                rx_valid <= 0;
            end
        end
        else if(cs == 3) begin 
            rx_data[(ADDR_SIZE + 2)-1-counter_4_bits] <= MOSI;
            counter_4_bits <= counter_4_bits + 1'b1;
            if(counter_4_bits == 4'h9) begin 
                rx_valid <= 1;
                counter_4_bits <= 4'h0;
            end
            else begin 
                rx_valid <= 0;
            end
        end
        else if(cs == 4) begin 
            rx_data[(ADDR_SIZE + 2)-1-counter_4_bits] <= MOSI;
            counter_4_bits <= counter_4_bits + 1'b1;
            if(counter_4_bits == 4'h9) begin 
                rx_valid <= 1;
                counter_4_bits <= 4'h0;
            end
            else begin 
                rx_valid <= 0;
            end
            if(tx_valid & rx_valid) begin 
                for (i = 0 ; i < ADDR_SIZE ;i = i + 1) begin 
                    MISO <= tx_data[ADDR_SIZE-1-i];
                end
            end
        end
    end
end
endmodule