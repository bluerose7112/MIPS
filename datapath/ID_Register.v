module ID_Register (clk,rst,En,Clr,RefAddr_i,rData1_i,rData2_i,Offset_i,RsAddr_i,RtAddr_i,RdAddr_i,RefAddr,rData1,rData2,Offset,RsAddr,RtAddr,RdAddr);

	input clk, rst;
	input En,Clr;
	input[31:0] RefAddr_i;
	input[31:0] rData1_i, rData2_i;
	input[31:0] Offset_i;
	input[4:0] RsAddr_i, RtAddr_i, RdAddr_i;

	output[31:0] RefAddr;
	output[31:0] rData1, rData2;
	output[31:0] Offset;
	output[4:0] RsAddr, RtAddr, RdAddr;
		reg[31:0] RefAddr;
		reg[31:0] rData1, rData2;
		reg[31:0] Offset;
		reg[4:0] RsAddr, RtAddr, RdAddr;

	always @(posedge clk or negedge rst)
	begin
		if(!rst)
			{RefAddr,rData1,rData2,Offset,RsAddr,RtAddr,RdAddr} <= {32'd0,32'd0,32'd0,32'd0,5'd0,5'd0,5'd0};
		else
			if(Clr)
				{RefAddr,rData1,rData2,Offset,RsAddr,RtAddr,RdAddr} <= {32'd0,32'd0,32'd0,32'd0,5'd0,5'd0,5'd0};
			else if(En)
				{RefAddr,rData1,rData2,Offset,RsAddr,RtAddr,RdAddr} <= {RefAddr_i,rData1_i,rData2_i,Offset_i,RsAddr_i,RtAddr_i,RdAddr_i};
	end

endmodule
