module RegisterFile (clk,rst,WriteReg,rAddr1,rAddr2,wAddr,wData,rData1,rData2);

	input clk, rst;
	input WriteReg;
	input[4:0] rAddr1, rAddr2, wAddr;
	input[31:0] wData;

	output[31:0] rData1, rData2;
		wire[31:0] rData1, rData2;

	integer i;

	reg[31:0] Register[1:31];

	assign rData1 = (rAddr1==5'd0)?(32'd0):(Register[rAddr1]);
	assign rData2 = (rAddr2==5'd0)?(32'd0):(Register[rAddr2]);

	always @(negedge clk or negedge rst)
	begin
		if(!rst)
			for(i=1; i<32; i=i+1)
				Register[i] <= 32'd0;
		else
			if(WriteReg)
				Register[wAddr] <= wData;
	end

endmodule
