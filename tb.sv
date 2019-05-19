`timescale 1ns / 1ps

module tb();
    
logic clock,reset;

factorial dut(.clock(clock),.reset(reset));
always begin
      clock = 1'b0;#5;
       clock = 1'b1;#5;
   end
   
initial begin

reset = 1'b1; #10;
reset = 1'b0; #500;

$finish;
end;
endmodule
