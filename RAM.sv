`timescale 1ns / 1ps

module RAM (
input logic [15:0] memin,
input logic writeen,
input logic [3:0] memaddr,
output logic [15:0] memout
);


parameter RAM_WIDTH = 16;
   parameter RAM_ADDR_BITS = 4;

   (* ram_style="distributed" *)
   
   reg [15:0] ram [15:0]={
   16'h0000,16'h0000,16'h0000,16'h0000,
   16'h0000,16'h0000,16'h0000,16'h0000,
   16'h0000,16'h0000,16'h0000,16'h0000,
   16'h0000,16'h0000,16'h0000,16'h0005
   };
   
   //<reg_or_wire> [RAM_WIDTH-1:0] <input_data>;
     
   //always @(posedge clock) &&&&&&&
   always_comb
      if (writeen)
         ram[memaddr] <= memin;

   assign memout = ram[memaddr];
   
endmodule
