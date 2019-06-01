`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.05.2019 03:42:40
// Design Name: 
// Module Name: CentralProcessingUnit
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

`timescale 1ns / 1ps


module CPU(
    input clock,
    input reset,
    output logic [7:0] port_out,
    input [7:0] port_in,
    output [7:0] cmd_out,
    output [7:0] cmd_addr_out,
    output [7:0] addr_out,
//    output logic [`DATA_BITS - 1:0] data_write,
//    output logic [`DATA_BITS - 1:0] data_read,
    output logic [`DATA_BITS - 1:0] accumulator
//    output logic [`DATA_BITS - 1:0] alu_result, 
//    output logic [`ADDR_BITS - 1 : 0][`ADDR_BITS - 1 : 0] memory
    );
    
    logic [`ADDR_BITS - 1:0] addr; 
    logic [`ADDR_BITS - 1:0] addr_read, addr_write;
    logic [`DATA_BITS - 1:0] instruction_register;
    logic [`ADDR_BITS - 1:0] cmd_addr, aux_addr;
    logic [`DATA_BITS - 1:0] data_read, data_write;
    
    //logic [`DATA_BITS - 1:0] accumulator;
    logic [`DATA_BITS - 1:0] alu_result;
    
    ROM rom(.addr_read(cmd_addr), .data_read({instruction_register, addr}));
    RAM ram(.addr_read(addr_read), .addr_write(addr_write), .data_read(data_read), .data_write(data_write), .clock(clock));
    ALU alu(.data_A(data_read), .data_B(accumulator), .op_code(instruction_register), .result(alu_result));
    assign cmd_out = instruction_register;
    
    assign cmd_addr_out = cmd_addr;
    assign addr_out = addr;
    
    assign addr_write = (instruction_register == `STO) ? addr : addr_write;
    assign data_write = (instruction_register == `STO) ? accumulator : data_write;

    assign addr_read = addr;
//    instruction_register == `SUM || 
//                     instruction_register == `SUB || 
//                     instruction_register == `MULT || 
//                     instruction_register == `DIV ||  
//                     instruction_register == `LDA || 
//                     instruction_register == `AND || 
//                     instruction_register == `OR || 
//                     instruction_register == `XOR ? 
//                     addr : addr_read;
   
    
    always@ (posedge clock) begin       
        if (reset) begin
            accumulator <= 0;
            cmd_addr <= 0;
            port_out <= 0;
        end else begin
            accumulator <= (instruction_register == `LDA) ? data_read : 
            (instruction_register == `SET) ? addr :
            alu_result;
            port_out <= (instruction_register == `OUT) ? accumulator : port_out;
            cmd_addr <= ((instruction_register == `JMP) || ((instruction_register == `JNZ) && (accumulator != 0))) ? addr : (cmd_addr + 1);          
        end
    end

endmodule