module SPI_Wrapper_tb();
reg clk,rst_n,MOSI,SS_n;
wire MISO;
SPI_Wrapper SPI_slave_and_RAM(clk,rst_n,MISO,MOSI,SS_n);
initial begin
    clk = 1;
    forever begin
        #5 clk = ~clk ;
    end
end
initial begin 
    $readmemh("mem.dat",SPI_slave_and_RAM.the_RAM.mem);
    rst_n = 0; // reset all registers
    SS_n = 1; // for the system to start from IDLE  state 
    MOSI = 0; // The MOSI value doesn't matter
    #10 // expected current state = IDLE , next state = IDLE , all registers = 0 . you can see the waveform 
    rst_n = 1; // disable the reset signal 
    SS_n = 0; // activate the SPI slave
    #10 // expected current state = IDLE , next state = CHK_CMD , all registers = 0 . you can see the waveform 
    #10 // expected current state = CHK_CMD , next state = WRITE , all registers = 0 . you can see the waveform
    MOSI = 0; #10 // expected current state = WRITE , next state = WRITE , all registers = 0 . you can see the waveform 
    MOSI = 0; #10 //rx_data[9] = 0;
    MOSI = 0; #10 // expected rx_data[8] = 0; to write address , we will write 8'hff
    repeat(8) begin
        MOSI = 1; #10;
    end 
    MOSI = 0; #10 //rx_data[9] = 0;
    MOSI = 1; #10 //rx_data[8] = 1; writing data test we will write 8'h55
    repeat(4) begin 
        MOSI = 0; #10 
        MOSI = 1; #10;
    end
    #10;
    rst_n = 0; // reset all registers
    SS_n = 1; // for the system to start from IDLE  state 
    MOSI = 1; // The MOSI value doesn't matter
    #10 // expected current state = IDLE , next state = IDLE , all registers = 0 . you can see the waveform 
    rst_n = 1; // disable the reset signal 
    SS_n = 0; // activate the SPI slave
    #10 // expected current state = IDLE , next state = CHK_CMD , all registers = 0 . you can see the waveform 
    #10 // expected current state = CHK_CMD , next state = READ_ADD , all registers = 0 . you can see the waveform
    MOSI = 1; #10 // expected current state = READ_ADD , next state = READ_ADD , all registers = 0 . you can see the waveform 
    MOSI = 1; #10 //rx_data[9] = 1;
    MOSI = 0; #10 // expected rx_data[8] = 0; to READ address , we will READ 8'hff
    repeat(8) begin
        MOSI = 1; #10;
    end 
    #10;
    SS_n = 1; // for the system to start from IDLE  state 
    MOSI = 1; // The MOSI value doesn't matter
    #10 // expected current state = IDLE , next state = IDLE , all registers = 0 . you can see the waveform 
    rst_n = 1; // disable the reset signal 
    SS_n = 0; // activate the SPI slave
    #10 // expected current state = IDLE , next state = CHK_CMD , all registers = 0 . you can see the waveform 
    MOSI = 1; #10 // expected current state = CHK_CMD , next state = READ_DATA , all registers = 0 . you can see the waveform
    MOSI = 1; #10 // expected current state = READ_DATA , next state = READ_DATA , all registers = 0 . you can see the waveform 
    MOSI = 1; #10 //rx_data[9] = 1;
    MOSI = 1; #10 // expected rx_data[8] = 1; to READ data , the next 8 bits are dummy value so they will be random 
    repeat(8) begin
        MOSI = $random; #10;
    end 
    #100
    $stop;
end
endmodule