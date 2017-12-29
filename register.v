module register#(parameter N=32)
(input clk,
input [N-1:0] MemData,
output reg [N-1:0]MDROut);

always@(posedge clk)
begin

MDROut<=MemData;
end
endmodule
