

`include "bit4_fa.v"

module bit16_fa
( input [15:0]a,
input [15:0]b,
input cin,
output [15:0]s,
output co);

wire c4, c5;

bit4_fa fa1(s[3:0], c_in, a[3:0], b[3:0], c3);
bit4_fa fa2(s[7:3], c3, a[7:3], b[7:3], c4);
bit4_fa fa3(s[11:7], c4, a[11:7], b[11:7], c5);
bit4_fa fa4(s[15:11], c5, a[15:11], b[15:11], co);
endmodule
