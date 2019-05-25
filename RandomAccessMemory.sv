`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.05.2019 04:51:53
// Design Name: 
// Module Name: RandomAccessMemory
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
`include "defines.sv"

module RAM(
    input [`ADDR_BITS - 1 : 0] addr_write,
    input [`ADDR_BITS - 1 : 0] addr_read,
    input [`DATA_BITS - 1 : 0] data_write,
    output [`DATA_BITS - 1 : 0] data_read,
    input clock_write
    );
    
    logic [2 * `ADDR_BITS - 1 : 0] mem [0 : (2**`ADDR_BITS) - 1];
    
    assign data_read = mem[addr_read];
    
    always @ (posedge clock_write) 
        mem[addr_write] <= data_write;
    
endmodule
