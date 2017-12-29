module inst_memory
(input clk,
input IRWrite,
input [31:0] MemData,
output [31:0] data_out);

parameter MemFile = "";  // File to read
parameter MemWidth = 128;  //Memory Entries

reg [31:0] mem [0:127];  //32x128
reg [31:0] out;
	
assign data_out = {out[7:0],out[15:8],out[23:16],out[31:24]}; //separated bytes

initial 
begin
	$readmemh(MemFile, mem, 0, MemWidth - 1);
end
always @(posedge clk) 
begin
	if (IRWrite) 
	begin
	out <= mem[MemData[31:0]];
	end
end

endmodule
