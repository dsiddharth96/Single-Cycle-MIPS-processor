
module alu
(
input clk,
input [31:0]a,b,
input [5:0]alu_ctrl,
output reg [31:0]out,
output zero);

wire [31:0] sub_ab;
wire [31:0] add_ab;
wire oflow_add;
wire oflow_sub;
wire oflow;
wire slt;

assign zero = (0 == out);
assign sub_ab = 1 + (~b);
assign add_ab = a + b;
assign oflow_add = (a[31] == b[31] && add_ab[31] != a[31]) ? 1 : 0;
assign oflow_sub = (a[31] == b[31] && sub_ab[31] != a[31]) ? 1 : 0;
assign oflow = (alu_ctrl == 32'b100000) ? oflow_add : oflow_sub;  // set if less than, 2s compliment 32-bit numbers
assign slt = oflow_sub ? ~(a[31]) : a[31];


always @(*) begin

		case (alu_ctrl)
			6'b100000: out <= add_ab;		/* add */
			6'b100100: out <= a & b;		/* and */
			6'b100111: out <= ~(a | b);		/* nor */
			6'b100101: out <= a | b;		/* or */
			6'b100010: out <= a + sub_ab;		/* sub */
			6'b110100: out <= a ^ b;		/* xor */
                        6'b101010: out <= {{31{1'b0}}, slt};	/* slt */ 
			default: out <= 0;
endcase
end
endmodule
