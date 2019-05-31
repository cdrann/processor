`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.05.2019 12:02:20
// Design Name: 
// Module Name: ALU_tb
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

module ALU_tb();
    logic [`DATA_BITS - 1 : 0] data_A;
    logic [`DATA_BITS - 1 : 0] data_B;
    logic [`DATA_BITS - 1 : 0] op_code;
    logic [`DATA_BITS - 1 : 0] result;

    ALU DUT(.data_A(data_A), .data_B(data_B), .op_code(op_code), .result(result));

    initial begin
        data_A <= 8'h01;
        data_B <= 8'h02;
        op_code <= 8'h03;
        repeat (10) begin
            op_code++; #10;
        end 
        $finish;
    end;
endmodule
