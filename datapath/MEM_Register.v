module MEM_Register (clk,rst,En,Clr,rData_i,Result_i,wAddr_i,rData,Result,wAddr);

	input clk, rst;
	input En, Clr;
	input[31:0] rData_i, Result_i;
	input[4:0] wAddr_i;

	output[31:0] rData, Result;
	output[4:0] wAddr;
		reg[31:0] rData, Result;
		reg[4:0] wAddr;

	always @(posedge clk or negedge rst)
	begin
		if(!rst)
			{rData,Result,wAddr} <= {32'd0,32'd0,5'd0};
		else
			if(Clr)
				{rData,Result,wAddr} <= {32'd0,32'd0,5'd0};
			else if(En)
				{rData,Result,wAddr} <= {rData_i,Result_i,wAddr_i};
	end

endmodule
