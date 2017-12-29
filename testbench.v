module testbench;

reg clock=0;
wire[31:0] cycle, pc, inst, alu_out, mem_out;
wire regdst, alusrc, branch, memread, memwrite, regwrite, memtoreg;
wire[1:0] aluop;
wire zero;
 cpu cpu1(cycle, pc, inst, alu_out, mem_out, clock,
 regdst, aluop, alusrc, branch, memread,
 memwrite, regwrite, memtoreg, zero);

always begin
#20 clock<=~clock;
end

initial begin
#2500 $stop;
end

initial begin
 $monitor(":At Time: %d; Clk : %b; ",
 $time, clock);
 end

endmodule
