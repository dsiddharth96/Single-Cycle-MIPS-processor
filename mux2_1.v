module mux1#(parameter W = 32)
(input control,
input [W-1:0] in1, in2,
output reg [W-1:0]out);

always@(*)
begin
	out <= 32'h00000000;
	if (control)
	out <= in1;
	else
	out <= in2;
end
endmodule
