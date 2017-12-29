
`include "bit16_fa.v"

module bit32_fa
( input [31:0]a,
input [31:0]b,
input cin,
output [31:0]s,
output co);

wire c4, c5;

bit16_fa fa1(s[15:0], c_in, a[15:0], b[15:0], c6);
bit16_fa fa2(s[31:16], c6, a[31:16], b[31:16], co);

endmodule
