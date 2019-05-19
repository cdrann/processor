`timescale 1ns / 1ps

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
