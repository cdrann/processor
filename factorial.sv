module factorial (
input logic reset,
input logic clock
);

logic [1:0] com;
logic [3:0] counter_out;
logic memreg_set;
logic memreg_reset;
logic counter_set;
logic counter_reset;
logic memin;
logic next;
logic cur_state;
logic set;
logic [15:0] memout;
logic [15:0] res ;
logic writeen;
logic [3:0] memaddr;
m_controller mcontr (com,
counter_out,
clock,
reset,
memreg_set,
memreg_reset,
counter_set,
counter_reset,
memin,//writeen //
next,//ip_next,
set,//ip_set,
cur_state);
//m_controller mcontr (com,counter_out,clock,reset,memreg_set, memreg_reset, counter_set,counter_reset, memin, next,cur_state);
ALU alu  (clock,memreg_set,memreg_reset,counter_set,counter_reset, memout,counter_out,res);
//IP ip (clock, set,next, memaddr, com );
IP ip (.clock(clock), .set(set),.next(next), .memaddr(memaddr), .com(com) );
RAM ram(res,memin, memaddr, memout);

endmodule
