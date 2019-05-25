`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 24.05.2019 23:16:11
// Design Name: 
// Module Name: ArithmeticLogicUnit
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

    
 
module ALU (
    input [7:0] data_A,
    input [7:0] data_B,
//    input status_in,
//    output [3:0] status_out,
    input [7:0] op_code,
    output logic [7:0] result
    );
    
    
    case (op_code)
        `SUM: result <= data_A + data_B;
//        `MULT: result <= data_A + data_B;
//        `DIV: result <= data_A + data_B;
//        `SUB: result <= data_A - data_B;
//        `INC: result <= data_A + 1;
//        `DEC: result <= data_A - 1;        
    endcase
endmodule
