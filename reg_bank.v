module reg_bank#(parameter W = 32)
	(
	input clk,
	input [4:0] IROut1,
	input [4:0] IROut2,
	input [4:0] write_reg_in,
	input RegWrite,
	input [W-1:0] write_data_in,
	output reg [W-1:0] RD1,
	output reg [W-1:0] RD2	
	);

reg [W-1:0] reg_bank [W-1:0];
	
// reads
always @(*)
	begin
		RD1 = reg_bank[IROut1];
		RD2 = reg_bank[IROut2];
	end
// writes; handles $zero register
always @(posedge clk)
	begin
		if(RegWrite)
		begin
		if(write_reg_in != 0)
			begin
			reg_bank[write_reg_in] <= write_data_in;
			end
		end
	end
endmodule
