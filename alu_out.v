module alu_out
(input clk,
input [31:0] ALURegOut,
output reg [31:0] ALUOut);

always@(posedge clk)
begin

ALUOut<=ALURegOut;
end
endmodule
