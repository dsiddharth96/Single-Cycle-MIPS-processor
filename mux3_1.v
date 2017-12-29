module mux3_1 (a,b,c,out,PCSrc);
input[31:0] a, b, c;
input [1:0] PCSrc;
output reg [31:0] out;

always @(a or b or c or PCSrc)
begin
     case(PCSrc)
     3'b01: out = a;
     3'b10: out = b;
     3'b11: out = c;
     default: out <= 0;
endcase
end
endmodule

