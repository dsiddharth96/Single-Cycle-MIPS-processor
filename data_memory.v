module data_memory
(input wire [31:0] wdata,
input wire [6:0] addr,
input wire MemRd,MemWt,
input wire clk,
output wire [31:0] MemData);

reg [31:0] mem[0:127];

always @(posedge clk) begin
if (MemWt) begin
mem[addr] = wdata;
end
end

assign MemData = MemWt ? wdata : mem[addr][31:0];
endmodule
