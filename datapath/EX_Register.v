module EX_Register (clk,rst,En,Clr,JumpAddr_i,Result_i,Zero_i,rData2_i,wAddr_i,JumpAddr,Result,Zero,rData2,wAddr);

	input clk, rst;
	input En, Clr;
	input[31:0] JumpAddr_i,Result_i;
	input Zero_i;
	input[31:0] rData2_i;
	input[4:0] wAddr_i;

	output[31:0] JumpAddr,Result;
	output Zero;
	output[31:0] rData2;
	output[4:0] wAddr;
		reg[31:0] JumpAddr,Result;
		reg Zero;
		reg[31:0] rData2;
		reg[4:0] wAddr;

	always @(posedge clk or negedge rst)
	begin
		if(!rst)
			{JumpAddr,Result,Zero,rData2,wAddr} <= {32'd0,32'd0,1'b0,32'd0,5'd0};
		else
			if(Clr)
				{JumpAddr,Result,Zero,rData2,wAddr} <= {32'd0,32'd0,1'b0,32'd0,5'd0};
			else if(En)
				{JumpAddr,Result,Zero,rData2,wAddr} <= {JumpAddr_i,Result_i,Zero_i,rData2_i,wAddr_i};
	end

endmodule
