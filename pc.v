module pc#(parameter W = 32)
(
input clock,
input PCWrite,
input [W-1:0] in,
output reg [W-1:0] out
);

always @(posedge clock)
	begin
	if(PCWrite)
		begin
		out <= in;
		end
	end
endmodule
