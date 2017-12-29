module control
(input clk,
input op5, op4, op3, op2, op1, op0,
input s3,s2,s1,s0,
output reg ns3,ns2,ns1,ns0,
output reg PCWrite, PCWriteCond, IorD, MemRead, MemWrite,IRWrite, MemtoReg,
output reg ALUSrcA, RegWrite, RegDst,
output reg[1:0] ALUOp, ALUSrcB, PCSource);

always@(posedge clk)
begin
assign PCWrite = (~s3&~s2&~s1&~s0) | (s3&~s2&~s1&s0) ;
assign PCWriteCond = (s3&~s2&~s1&~s0);
assign IorD = (~s3&~s2&s1&s0) | (~s3&s2&~s1&s0) ;
assign MemRead = (~s3&~s2&~s1&~s0) | (~s3&~s2&s1&s0) ;
assign MemWrite = (~s3&s2&~s1&s0) ;
assign IRWrite = (~s3&~s2&~s1&~s0);
assign MemtoReg = (~s3&s2&~s1&~s0);
PCSource[1]<= (s3&~s2&~s1&s0);
PCSource[0] <= (s3&~s2&~s1&~s0);
ALUOp[1] <= (~s3&s2&s1&~s0);
ALUOp[0] <= (s3&~s2&~s1&~s0);
ALUSrcB[1] <= (~s3&~s2&~s1&s0) | (~s3&~s2&s1&~s0) ;
ALUSrcB[0] <= (~s3&~s2&~s1&s0) | (~s3&~s2&~s1&s0) ;
assign ALUSrcA = (~s3&~s2&s1&s0) | (s3&~s2&~s1&s0) | (s3&~s2&~s1&~s0) ;
assign RegWrite = (~s3&s2&~s1&~s0) | (~s3&s2&s1&s0); 
assign RegDst = (~s3&s2&s1&s0);

assign ns3 = (~op5&~op4&~op3&~op2&op1&~op0&~s3&~s2&~s1&s0) | (~op5&~op4&~op3&op2&~op1&~op0&~s3&~s2&~s1&s0) ;
assign ns2 = (~op5&~op4&~op3&~op2&~op1&~op0&~s3&~s2&~s1&s0) | (op5&~op4&op3&op2&op1&op0&~s3&~s2&s1&~s0) | (~s3&~s2&s1&s0) | (~s3&s2&s1&~s0); 
assign ns1 = (~op5&~op4&~op3&~op2&~op1&~op0&~s3&~s2&~s1&s0) | (op5&~op4&~op3&~op2&op1&op0&~s3&~s2&~s1&s0) |(op5&~op4&op3&~op2&op1&op0&~s3&~s2&~s1&s0) | (op5&~op4&~op3&~op2&op1&op0&~s3&~s2&s1&~s0) | (~s3&s2&s1&~s0);
assign ns0 = (~s3&~s2&~s1&~s0) | (op5&~op4&~op3&~op2&op1&op0&~s3&~s2&s1&~s0) |(op5&~op4&op3&~op2&op1&op0&~s3&~s2&s1&~s0) | (~s3&s2&s1&~s0) | (~op5&~op4&~op3&~op2&op1&~op0&~s3&~s2&~s1&s0) ;

end
endmodule
