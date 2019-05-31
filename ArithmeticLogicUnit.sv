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
    input [`DATA_BITS - 1 : 0] data_A,
    input [`DATA_BITS - 1 : 0] data_B,
//    input status_in,
//    output [3:0] status_out,
    input [`DATA_BITS - 1 : 0] op_code,
     output [`DATA_BITS - 1 : 0] result
    );
    
    assign result = (op_code == `SUM) * (data_B + data_A) +
        (op_code == `SUB) * (data_B - data_A) + 
        (op_code == `MULT) * (data_B * data_A) + 
        (op_code == `DIV) * (data_B / data_A) +
        (op_code == `INC) * (data_A + 1) +
        (op_code == `DEC) * (data_A - 1) +
        (op_code == `AND) * (data_B & data_A) +
        (op_code == `OR) * (data_B | data_A) +
        (op_code == `XOR) * (data_B ^ data_A) +
        (op_code == `COMP) * (~data_A);
//    case (op_code)
//        `SUM: result <= data_B + data_A;
//        `MULT: result <= data_B * data_A;
//        `DIV: result <= data_B / data_A;
//        `SUB: result <= data_B - data_A;
//        `INC: result <= data_A + 1;
//        `DEC: result <= data_A - 1;   
//        `AND: result <= data_B & data_A;
//        `OR: result <= data_B | data_A;
//        `XOR: result <= data_B ^ data_A;
//        `COMP: result <= ~data_A;     
//    endcase
endmodule
