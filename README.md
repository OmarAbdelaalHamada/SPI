# SPI Project README

## Project Overview

This project implements a Serial Peripheral Interface (SPI) using Verilog. The design is divided into three main modules:
1. **RAM**: Handles data storage and retrieval.
2. **SPI_slave**: Manages SPI communication.
3. **SPI_wrapper**: The top-level module that integrates RAM and SPI_slave.

Additionally, a testbench (`SPI_Wrapper_tb.v`) and a do file (`run.do`) are provided to simulate and verify the design. The design is then opened in Vivado to follow the FPGA flow until generating the bitstream file. Three encoding systems are used in this project: sequential, gray, and one hot encoding.

## Directory Structure

```
SPI_Project/
│
├── src/
│   ├── RAM.v
│   ├── SPI_Slave.v
│   ├── SPI_Wrapper.v
│
├── tb/
│   ├── SPI_Wrapper_tb.v
│   ├── run.do
│
├── vivado/
│   ├── SPI.xpr
│   ├── constraints.xdc
│   ├── synthesis/
│   ├── implementation/
│   ├── bitstream/
│
└── README.md
```

## Module Descriptions

### RAM.v
The RAM module is responsible for data storage and retrieval. It interfaces with the SPI_slave to store incoming data and provide data for outgoing transmissions.

### SPI_Slave.v
The SPI_slave module manages the SPI communication protocol. It receives data from the master device, processes it, and communicates with the RAM module as necessary.

### SPI_Wrapper.v
The SPI_wrapper is the top-level module that integrates the RAM and SPI_slave modules. It serves as the main entry point for the design.

## Simulation

To simulate the design and ensure its correctness, a testbench (`SPI_Wrapper_tb.v`) and a do file (`run.do`) are provided.

### Running the Simulation

1. Open your simulation tool:ModelSim.
2. Load the `run.do` file.
3. Run the simulation to verify the design.

The testbench covers various test cases to ensure the correct functionality of the SPI communication, data storage, and retrieval.

## FPGA Flow

The design is implemented in Vivado. Follow these steps to generate the bitstream file:

1. Open `SPI.xpr` in Vivado.
2. Set up the constraints using `constraints.xdc`.
3. Run synthesis.
4. Run implementation.
5. Generate the bitstream file.

### Encoding Systems

The project uses three different encoding systems:

1. **Sequential Encoding**: A straightforward binary encoding system.
2. **Gray Encoding**: A binary numeral system where two successive values differ in only one bit.
3. **One Hot Encoding**: Each bit of the encoded value represents a separate state.

## Conclusion

This project provides a comprehensive implementation of an SPI using Verilog, including simulation and FPGA implementation steps. By following the instructions provided, you can simulate, verify, and implement the design on an FPGA.
