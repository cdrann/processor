`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 31.05.2019 13:24:43
// Design Name: 
// Module Name: CPU_tb
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

module CPU_tb();
    logic clock = 1'b1, reset = 1'b1;
    
    logic [7:0] cmd, cmd_addr, addr, port_in, port_out;
 //   logic [`DATA_BITS - 1:0] accumulator;
  //  logic [`DATA_BITS - 1:0] alu_result;
   //  logic [`DATA_BITS - 1:0] data_read;
   // logic [`DATA_BITS - 1:0] data_write;
    
    always begin
        #5;
        clock = ~clock;
    end
    
    CPU DUT(/*.accumulator(accumulator), */.clock(clock), .reset(reset), .port_out(port_out), .cmd_out(cmd), .addr_out(addr), .cmd_addr_out(cmd_addr), .port_in(port_in));

    initial begin
        #5;
        reset <= 1'b0;
        port_in <= 8'h0a;
        #3000;
        $finish;
    end
    
endmodule
