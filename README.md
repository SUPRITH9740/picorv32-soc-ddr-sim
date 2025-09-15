# picorv32-soc-ddr-sim


# PicoRV32-SoC with DDR Simulation

This repository contains a custom System-on-Chip (SoC) design based on the open-source [PicoRV32 RISC-V CPU](https://github.com/cliffordwolf/picorv32).  
The project integrates a lightweight CPU core with a DDR memory model, memory controller, FIFO buffers, and an adapter — all built and verified in SystemVerilog using Xilinx Vivado.

## Features

* Integration of *PicoRV32 CPU* with custom memory subsystem  
* Memory Adapter to interface PicoRV32 bus with the controller  
* FIFO Buffers for clean data transfer  
* DDR Memory Model for realistic testing  
* Comprehensive SystemVerilog Testbenches
* Preload programs using program.mem file for simulation
* Verified on Vivado Simulator (XSim)  


##  Project Structure
📂 Project Root
│
├── 📁 src/                     # All RTL design modules
│   ├── picorv32.v              # PicoRV32 RISC-V CPU core
│   ├── picorv32_mem_adapter.sv # Adapter for PicoRV32 memory interface
│   ├── mem_controller.sv       # Memory controller
│   ├── ddr_model.sv            # DDR memory model
│   ├── fifo.sv                 # FIFO buffer
│   └── top_picorv32_system.sv  # Top-level system integration
│
├──  sim/                     # Simulation-related files
│   ├── tb_top_picorv32_system.sv # Testbench for top-level system
│   ├── program.mem             # Memory preload file
│   └── waveform.vcd            # Simulation waveform output
│
└──  README.md                # Project documentation

## How to Run
1. Open project in Vivado 2021.2 or later  
2. Add src/ files to Design Sources  
3. Add sim/ files to Simulation Sources  
4. Run simulation (xsim)  
5. Observe outputs in TCL console and waveform viewer  



##  Future Work

- Add AXI/AHB interface for advanced memory systems  
- Extend instruction/program test cases  
- FPGA implementation for on-board testing  


##  Author

Developed by Suprith M U  
Final year Engineering Student | VLSI & Digital Design Enthusiast  



##  Why This Project?
This project demonstrates the ability to integrate open-source IPs, design custom RTL blocks, and perform verification in a realistic SoC environment ,showcasing both hardware design and system level understanding.

