module mux4_1#(parameter W = 32)
(input[1:0] control,
input[W-1:0] in1,in2,in3,in0,
output reg[W-1:0]out);

always@(*)
begin
out <= 32'h00000000;
case(control)
	2'b00: out = in0;
	2'b01: out = in1;
	2'b10: out = in2;
	2'b11: out = in3;
endcase
end
endmodule
 