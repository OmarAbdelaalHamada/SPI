vlib work
vlog RAM.v SPI_Slave.v SPI_Wrapper.v SPI_Wrapper_tb.v
vsim -voptargs="+acc" work.SPI_Wrapper_tb
add wave *
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/SPI_slave_and_RAM/rx_valid \
sim:/SPI_Wrapper_tb/SPI_slave_and_RAM/tx_valid \
sim:/SPI_Wrapper_tb/SPI_slave_and_RAM/rx_data \
sim:/SPI_Wrapper_tb/SPI_slave_and_RAM/tx_data
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/SPI_slave_and_RAM/the_RAM/mem \
sim:/SPI_Wrapper_tb/SPI_slave_and_RAM/the_RAM/address
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/SPI_slave_and_RAM/SLAVE/cs \
sim:/SPI_Wrapper_tb/SPI_slave_and_RAM/SLAVE/ns \
sim:/SPI_Wrapper_tb/SPI_slave_and_RAM/SLAVE/counter_4_bits
add wave -position insertpoint  \
sim:/SPI_Wrapper_tb/SPI_slave_and_RAM/SLAVE/internal_signal
run -all
#quit -sim