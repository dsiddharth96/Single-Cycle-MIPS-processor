module alu_control(
input wire [5:0] IROut,
input wire [1:0] aluop,
output reg [3:0] aluctrl);

reg [3:0] _funct;

always @(*) begin
	case(IROut[5:0])
		6'b100000: _funct = 4'b0010;	/* add */
		6'b100010: _funct = 4'b0110;	/* sub */
		6'b100101: _funct = 4'b0001;	/* or */
		6'b100110: _funct = 4'b1000;	/* xor */
		6'b100111: _funct = 4'b1001;	/* nor */
		6'b101010:_funct = 4'b0111;	/* slt */
		default: _funct = 4'b0000;
	endcase
end
always @(*) begin
	case(aluop)
		2'b00: aluctrl = 4'b0010;	/*add:LW*/
		2'b01: aluctrl = 4'b0110;	/*sub:BEQ*/
		2'b10: aluctrl = _funct;        /*R-type*/
		2'b00: aluctrl = 4'b0010;	/* add:SW*/
		default: aluctrl = 0;
	endcase
end
endmodule
