`timescale 1ns /1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.09.2025 22:47:05
// Design Name: 
// Module Name: top_picorv32_system
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_picorv32_system (
    input logic clk,
    input logic resetn   // active-low
);

    // picoRV32 bus signals
    logic mem_valid, mem_instr, mem_ready;
    logic [31:0] mem_addr;
    logic [31:0] mem_wdata;
    logic [3:0]  mem_wstrb;
    logic [31:0] mem_rdata;

    // controller <-> DDR
    logic cpu_wr_req, cpu_rd_req;
    logic [9:0] cpu_addr;
    logic [31:0] cpu_data_in, cpu_data_out;
    logic cpu_data_valid;

    logic ddr_wr_req, ddr_rd_req;
    logic [9:0] ddr_addr;
    logic [31:0] ddr_wr_data, ddr_rd_data;
    logic ddr_rd_valid;

    // ------------------------------------------------------------------
    // Pico core instance (you must add the open-source picorv32.v file to project)
    // The core must have these standard ports:
    //   clk, resetn, mem_valid, mem_instr, mem_ready, mem_addr, mem_wdata, mem_wstrb, mem_rdata
    // ------------------------------------------------------------------
    // If you have picorv32.v with different names, adapt here.
    picorv32 cpu_core (
        .clk(clk),
        .resetn(resetn),
        .mem_valid(mem_valid),
        .mem_instr(mem_instr),
        .mem_ready(mem_ready),
        .mem_addr(mem_addr),
        .mem_wdata(mem_wdata),
        .mem_wstrb(mem_wstrb),
        .mem_rdata(mem_rdata)
    );

    // adapter
    picorv32_mem_adapter #(.ADDR_WIDTH(10), .DATA_WIDTH(32)) adapter (
        .clk(clk), .resetn(resetn),
        .mem_valid(mem_valid), .mem_instr(mem_instr), .mem_ready(mem_ready),
        .mem_addr(mem_addr), .mem_wdata(mem_wdata), .mem_wstrb(mem_wstrb), .mem_rdata(mem_rdata),
        .cpu_wr_req(cpu_wr_req), .cpu_rd_req(cpu_rd_req), .cpu_addr(cpu_addr),
        .cpu_data_in(cpu_data_in), .cpu_data_out(cpu_data_out), .cpu_data_valid(cpu_data_valid)
    );

    // controller
    mem_controller #(.ADDR_WIDTH(10), .DATA_WIDTH(32)) controller (
        .clk(clk), .reset(~resetn),   // controller uses active-high reset
        .cpu_wr_req(cpu_wr_req), .cpu_rd_req(cpu_rd_req),
        .cpu_addr(cpu_addr), .cpu_data_in(cpu_data_in),
        .cpu_data_out(cpu_data_out), .cpu_data_valid(cpu_data_valid),
        .ddr_wr_req(ddr_wr_req), .ddr_rd_req(ddr_rd_req),
        .ddr_addr(ddr_addr), .ddr_wr_data(ddr_wr_data),
        .ddr_rd_data(ddr_rd_data), .ddr_rd_valid(ddr_rd_valid)
    );

    // DDR model
    ddr_model #(.DATA_WIDTH(32), .DEPTH(1024)) ddr_inst (
        .clk(clk), .reset(~resetn),
        .rd_req(ddr_rd_req), .wr_req(ddr_wr_req),
        .addr(ddr_addr), .wr_data(ddr_wr_data),
        .rd_data(ddr_rd_data), .rd_valid(ddr_rd_valid)
    );

endmodule
   