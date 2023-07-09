module ID_Stage (clk,rst,En,Clr,RefAddr_i,Instr,WriteReg,wAddr,wData,RefAddr,rData1,rData2,Offset,RsAddr,RtAddr,RdAddr);

	input clk, rst;
	input En, Clr;
	input[31:0] RefAddr_i;
	input[25:0] Instr;
	input WriteReg;
	input[4:0] wAddr;
	input[31:0] wData;

	output[31:0] RefAddr;
	output[31:0] rData1, rData2;
	output[31:0] Offset;
	output[4:0] RsAddr, RtAddr, RdAddr;
		wire[31:0] RefAddr;
		wire[31:0] rData1, rData2;
		wire[31:0] Offset;
		wire[4:0] RsAddr, RtAddr, RdAddr;

	wire[31:0] rData1_a, rData2_a;
	wire[31:0] Offset_a;

	//Registers
	RegisterFile RegisterFile (
		.clk(clk),
		.rst(rst),
		.WriteReg(WriteReg),
		.rAddr1(Instr[25:21]),
		.rAddr2(Instr[20:16]),
		.wAddr(wAddr),
		.wData(wData),
		.rData1(rData1_a),
		.rData2(rData2_a)
	);

	//Sign Extension
	SignExtension SignExtension (
		.In(Instr[15:0]),
		.Out(Offset_a)
	);

	//ID Register
	ID_Register ID_Register (
		.clk(clk),
		.rst(rst),
		.En(En),
		.Clr(Clr),
		.RefAddr_i(RefAddr_i),
		.rData1_i(rData1_a),
		.rData2_i(rData2_a),
		.Offset_i(Offset_a),
		.RsAddr_i(Instr[25:21]),
		.RtAddr_i(Instr[20:16]),
		.RdAddr_i(Instr[15:11]),
		.RefAddr(RefAddr),
		.rData1(rData1),
		.rData2(rData2),
		.Offset(Offset),
		.RsAddr(RsAddr),
		.RtAddr(RtAddr),
		.RdAddr(RdAddr)
	);

endmodule
