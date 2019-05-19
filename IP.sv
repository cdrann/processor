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
