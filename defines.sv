`ifndef DEFINE_SV
`define DEFINE_SV
  `define ADDR_BITS 8
  `define DATA_BITS 8
  
  `define OUT 8'h00 //output acc
  `define JUMP 8'h03 //goto cmnd line
  `define LDA 8'h04  //load from ram to acc
  `define ADD 8'h05 //acc + ram
  `define STO 8'h06 // load from acc to ram
  `define INC 8'h07 //acc++
  `define DEC 8'h08 //acc--
  `define SUB 8'h0a //acc - ram
  `define MULT 8'h0b //acc * ram
  `define DIV 8'h0c //acc / ram
  `define AND 8'h0d //acc & ram
  `define OR 8'h0e //acc | ram
  `define XOR 8'h0f //acc ^ ram
  
`endif