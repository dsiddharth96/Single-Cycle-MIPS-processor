`include "reg_bank.v"
`include "inst_memory.v"
`include "pc.v"
`include "control.v"
`include "alu.v"
`include "alu_control.v"
`include "data_memory.v"
`include "left_shift2.v"
`include "sign_extend.v"
`include "mux2_1.v"
`include "mux3_1.v"
`include "mux4_1.v"
`include "register.v"
`include "alu_out.v"
module cpu(
input clk);
/*(cycle, pc, inst, ALUOut, MemOut, clk,
RegDst, ALUOp, ALUSrc, branch, MemRead,
MemWrite, RegWrite, MemtoReg, zero, alu, control, data_memory, inst_memory, reg_bank,
left_shift2, sign_extend, mux2_1, mux3_1, mux4_1, register, alu_control);
// io
input clk,
output[31:0] cycle, pc, inst, ALUOut, MemOut,
output regdst, ALUSrc, branch, MemRead, MemWrite, RegWrite, MemtoReg,
output[1:0] ALUOp,
output zero);*/

// debugging
reg[31:0] cycle=32'd0;

always @ (posedge clk) begin
 cycle = cycle + 1;
 end
// control variables
wire [1:0] ALUOp, ALUSrcB, PCSource;
wire PCWriteCond, PCWrite, lorD, MemRead, MemWrite, MemtoReg, IRWrite,
ALUSrcA, RegWrite, RegDst;

// data path wires
 wire[31:0] pcmuxout, MemData, IROut, MDROut, MDRMux, SignExtendOut,
SES4Out, RD1, RD2, ARegOut, BRegOut, AMuxOut, BMuxOut, ALUResult,
ALURegOut, nextpc, pcshift2out, IROut1, IROut2;
 reg[31:0] pc=128;
 wire [4:0] instructionmuxout;

 //update PC
 wire PCWriteEnable;
 wire tempPCvar;
 //pcMux
 assign pcmuxout = lorD ? ALURegOut : pc;

 //memory

data_memory DataMemory1(wdata,addr,MemRd ,MemWt,clk,MemData);

//Instruction register
 inst_memory IR1(data_out, clk,IRWrite,MemData );

 //Memory Data Register
 register MDR1(clk,MemData, MDROut );
 
 //Controller
 control Control1(clk,op5, op4, op3, op2, op1, op0,
s3,s2,s1,s0,
ns3,ns2,ns1,ns0,
PCWrite, PCWriteCond, IorD, MemRead, MemWrite,IRWrite, MemtoReg,
oALUSrcA, RegWrite, RegDst,
ALUOp, ALUSrcB, PCSource);
//instruction decoding
 assign instructionmuxout = RegDst ? IROut[15:11] : IROut[20:16];
 assign MDRMux = MemtoReg ? MDROut : ALURegOut;
 //Registers
 reg_bank
register(clk,IROut1[25:21],IROut2[20:16],instmuxout,RegWrite,MDRMux,RD1,RD2);
 register A(clk,RD1, ARegOut);
 register B(clk,RD2, BRegOut);

 // sign extend and shift 2;
 sign_extend SE1(IROut[15:0], SignExtendOut);
 assign SES4Out = SignExtendOut*4;

 //muxes for ALU input
 assign AMuxOut= ALUSrcA ? ARegOut : pc;
 mux4_1 Bmux(ALUSrcB, BRegOut, 32'd4, SignExtendOut, SES4Out, BMuxOut);
 //ALU controller and ALU
 //wire [3:0] Operation;
 alu_control ALUControl1(IROut[5:0],ALUOp[1:0], aluctrl);
 alu alu1(clk,ALUResult, AMuxOut, BMuxOut, alu_ctrl,zero);
 alu_out aluout1(clk,ALURegOut, ALUOut);

 //jump 
 wire [31:0] jumpaddress;
 wire [27:0] jumpaddresstemp;
 assign jumpaddresstemp = IROut[25:0] *4;
 assign jumpaddress= {pc[31:28],jumpaddresstemp[27:0]};
 mux4_1 mux41(PCSource, ALUResult, ALURegOut, jumpaddress,
jumpaddress, nextpc);

 //updating pc
assign tempPCvar=zero&PCWriteCond;
assign PCWriteEnable=tempPCvar|PCWrite;
always@ (posedge clk) begin
 if(PCWriteEnable==1'b1)begin
pc <= nextpc;
end
end
endmodule 
