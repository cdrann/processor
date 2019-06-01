`ifndef DEFINE_SV
`define DEFINE_SV
  `define ADDR_BITS 8
  `define DATA_BITS 8
  
  `define OUT 8'h00 
  `define SET 8'h01
  `define MOVE 8'h02
  `define JUMP 8'h03
  `define LDA 8'h04 
  `define ADD 8'h05
  `define STO 8'h06
  `define INC 8'h07
  `define DEC 8'h08
  `define SUM 8'h09
  `define SUB 8'h0a
  `define MULT 8'h0b
  `define DIV 8'h0c
  `define AND 8'h0d
  `define OR 8'h0e
  `define XOR 8'h0f
  
`endif