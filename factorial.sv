`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.05.2019 03:47:31
// Design Name: 
// Module Name: factorial
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




module IP(
input logic clock, //taktirovanie
input logic set,  //
input logic next,//enable,
output logic [3:0] memaddr, //
output logic [1:0] com //komanda
);
logic [3:0] ip = 4'b0000;

always @(posedge clock)
begin
    if (set)
        ip <= memaddr;
     else if (next)
        ip <= ip+1;
       // ip <= ip +1'b1;
end    

    
parameter ROM_WIDTH = 6;

   logic [5:0] romout;
   //<reg_or_wire> [3:0] <ipa>;
    
 assign com =  romout[1:0];
 assign memaddr = romout[5:2]; //adres if vdrug komanda "if"
   always_comb
         case (ip)
            4'b0000: romout = 6'b000000;
            4'b0001: romout = 6'b000000;
            4'b0010: romout = 6'b000001;
            4'b0011: romout = 6'b001010;
            4'b0100: romout = 6'b000011;
            4'b0101: romout = 6'b000011;
            4'b0110: romout = 6'b000000;
            4'b0111: romout = 6'b000000;
            4'b1000: romout = 6'b000000;
            4'b1001: romout = 6'b000000;
            4'b1010: romout = 6'b000000;
            4'b1011: romout = 6'b000000;
            4'b1100: romout = 6'b000000;
            4'b1101: romout = 6'b000000;
            4'b1110: romout = 6'b000000;
            4'b1111: romout = 6'b000000;
         endcase
    


endmodule

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


module m_controller(
input logic [0:1] com,//4 komandy predusmpstreno - 4 bita na nih
input logic [0:3] counter_out, //bity is vtorogo registra s registra counter
input logic clock,
input logic reset, //noga kotor dergaem chtob obnovit
output logic memreg_set,//noga v registr memreg zapisyvaem 
output logic memreg_reset,//zadat nach znach na registre (1)
output logic counter_set,//zapis v registr counter umenshennoe na 1 chislo
output logic counter_reset,//zadat nach znach (s pamati)
output logic memin,//writeen //
output logic next,//ip_next,
output logic set,//ip_set, 
output logic [7:0] cur_state//
);

   parameter state1 = 8'b00000001;
   parameter state2 = 8'b00000010;
   parameter state3 = 8'b00000100;
   parameter state4 = 8'b00001000; //5 komanda nihuya ne delaet - processor konec zhizn cycla
   parameter state5 = 8'b00010000;
 

    reg [7:0] state;// = state1; massiv sostoyaniy registr sostoyaniy

   always @(posedge clock)
      if (reset)
         state <= state1;
      else
         case (state)//spstoyan machiny
            state1 : begin next  = 1; state <= state2; end //perehod k sled sost, po noge na IP prihodit signal - 
            state2 : begin next  = 0; state <= state3; end
            state3 : begin
               if (com == 2'b00) //komanda initializatcii
                    begin
                        counter_reset<=1; //obnovit vse
                        memreg_reset <=1;//kazhdaya komanda vypoln za 4 sost
                        state <= state4;
                    end
               else if (com == 2'b01) begin //schitat sled factorial
                     counter_set<=1;
                     memreg_set <=1;
                     state <= state4;
                    end
               else if (com == 2'b10) begin //vetvlenie - if(counter_out==1) -> perehod k sled comande
               if (counter_out == 1)
                    state <= state1;
                   // state<=state5;
                else begin
                    set <=1;
                    state<=state4;
                end
               end
               if(com == 2'b11) begin //komanda - nozhka - zapomnit
               memin<=1;
               state<=state4;
               end;
                 // <state> <= <next_state>;
              // else
                 // <state> <= <next_state>;
            end
            state4 : begin
              if (com == 2'b00) 
                     begin
                          counter_reset<=0;
                          memreg_reset <=0;
                          state <= state1;
                      end
                else if (com == 2'b01) begin
                      counter_set<=0;
                      memreg_set <=0;
                      state <= state1;
                end
                else if (com == 2'b10) begin
                    set<=0;
                    state<=state3;
                end
                 if(com == 2'b11) begin
                              memin<=0;
                              state<=state5;
                 end;
              // else if (<condition>)
              //    <state> <= <next_state>;
             //  else
              //    <state> <= <next_state>;
            end
            state5 : begin
              
            end
           
         endcase

   assign cur_state = state;
   //assign output2 = <logic_equation_based_on_states_and_inputs>;
   // Add other output equations as necessary
endmodule



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
