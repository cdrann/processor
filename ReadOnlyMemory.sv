`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.05.2019 04:53:06
// Design Name: 
// Module Name: ReadOnlyMemory
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


module ROM(
    input [`ADDR_BITS - 1 : 0] addr_read,
    output [2 * `DATA_BITS - 1 : 0] data_read
    );
    
    //(* rom_style = "{distributed}" *)
    logic [2 *`DATA_BITS - 1 : 0] memory [0 : (2 **`ADDR_BITS) - 1];
    initial $readmemh("rom_image.mem", memory, 0, (2 **`ADDR_BITS) - 1);
    
    assign data_read = memory[addr_read];
endmodule