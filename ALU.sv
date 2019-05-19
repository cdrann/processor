`timescale 1ns / 1ps

module ALU(
input logic clock, //
input logic memreg_set, // znach s *
input logic memreg_reset, // 1
input logic counter_set, // -1
input logic counter_reset, // dannue s mem
input logic [0:3] memout, //
output logic [0:3] counter_out,
output logic [0:15] res
);

logic [0:6] memreg;
logic [0:6] counter;
//assign counter_out = counter;
assign res = counter*memreg;
always @(posedge clock)
begin
if(memreg_set)
    memreg<=res;
else if(memreg_reset)
    memreg<= 4'b0001;
if (counter_set)
    counter <= counter - 1'b1;
else if (counter_reset)
    counter <= memout;
end
assign counter_out = counter;

endmodule
