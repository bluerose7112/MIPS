module MEM_Stage (clk,rst,En,Clr,rData_i,Result_i,wAddr_i,rData,Result,wAddr);

	input clk, rst;
	input En, Clr;
	input[31:0] rData_i, Result_i;
	input[4:0] wAddr_i;

	output[31:0] rData, Result;
	output[4:0] wAddr;
		wire[31:0] rData;
		wire[31:0] Result;
		wire[4:0] wAddr;

	//MEM Register
	MEM_Register MEM_Register (
		.clk(clk),
		.rst(rst),
		.En(En),
		.Clr(Clr),
		.rData_i(rData_i),
		.Result_i(Result_i),
		.wAddr_i(wAddr_i),
		.rData(rData),
		.Result(Result),
		.wAddr(wAddr)
	);

endmodule
