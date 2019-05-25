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


module cpu(
    input clock,
    input reset,
    output logic [7:0] port_out,
    input [7:0] port_in,
    output [7:0] cmd_out,
    output [7:0] reg_pc_out,
    output [7:0] addr_out
    );
    
    logic [`ADDR_BITS - 1:0] addr; 
    logic [`ADDR_BITS - 1:0] addr_read, addr_write;
    logic [`DATA_BITS - 1:0] instruction_register;
    logic [`ADDR_BITS - 1:0] cmd_addr, aux_addr;
    logic [`DATA_BITS - 1:0] data_read, data_write;
    
    logic [`DATA_BITS - 1:0] accumulator;
    logic [`DATA_BITS - 1:0] reg_reg;
    
    ROM rom(.addr_read(cmd_addr), .data_read({instruction_register, addr}));
    RAM ram(.addr_read(addr_read), .addr_write(addr_write), .data_read(data_read), .data_write(data_write), .clock_write(clock));
    ALU alu(.data_A(data_read), .data_B(accumulator), .op_code(op_code), .result(reg_reg));
    assign cmd_out = instruction_register;
    
    assign reg_pc_out = cmd_addr;
    assign addr_out = addr;
    
    //What is STO
    //assign addr_write = instruction_register == STO ? addr : addr_write;
    //6assign data_write = instruction_register == STO ? accumulator : data_write;

    assign addr_read = instruction_register == `SUM || instruction_register == `SUB || instruction_register == `MULT || instruction_register == `DIV || instruction_register == accumulator || instruction_register == `OUT ? addr : addr_read;
    
    
    always@ (posedge clock) begin
        if (reset) begin
            accumulator <= 0;
            cmd_addr <= 0;
            port_out <= 0;
        end else begin
            accumulator <= reg_reg;
            if (instruction_register == `JUMP)
                cmd_addr = addr;
//What is TST            
//                       (instruction_register == TST ? (!accumulator ? cmd_addr + 2 : cmd_addr + 1) :
//                        cmd_addr + 1);
            
            
            port_out <= instruction_register == `OUT ? accumulator : port_out;
        end
    end

endmodule