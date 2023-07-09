module EX_Stage (clk,rst,En,Clr,RefAddr,rData1,rData2_i,Offset,RtAddr,RdAddr,DstReg,ALUSrc,ALU_Op,JumpAddr,Result,Zero,rData2,wAddr);

	input clk, rst;
	input En, Clr;
	input[31:0] RefAddr;
	input[31:0] rData1, rData2_i;
	input[31:0] Offset;
	input[4:0] RtAddr, RdAddr;
	input DstReg, ALUSrc;
	input[2:0] ALU_Op;

	output[31:0] JumpAddr;
	output[31:0] Result;
	output Zero;
	output[31:0] rData2;
	output[4:0] wAddr;
		wire[31:0] JumpAddr;
		wire[31:0] Result;
		wire Zero;
		wire[31:0] rData2;
		wire[4:0] wAddr;

	wire[31:0] Src2;
	wire[2:0] Control;
	wire[31:0] JumpAddr_a;
	wire[31:0] Result_a;
	wire Zero_a;
	wire[4:0] wAddr_a;

	//Jump Address Adder
	JumpAddressAdder JumpAddressAdder (
		.RefAddr(RefAddr),
		.Offset(Offset[29:0]),
		.JumpAddr(JumpAddr_a)
	);

	//ALU Source2 Mux
	Mux32_2to1 SrcMux (
		.Sel(ALUSrc),
		.In0(rData2_i),
		.In1(Offset),
		.Out(Src2)
	);

	//ALU
	ALU ALU (
		.Control(Control),
		.Src1(rData1),
		.Src2(Src2),
		.Result(Result_a),
		.Zero(Zero_a)
	);

	//ALU Control
	ALUControl ALUControl (
		.ALU_Op(ALU_Op),
		.Function(Offset[5:0]),
		.Control(Control)
	);

	//Destination Register Mux
	Mux5_1to2 Mux5_1to2 (
		.Sel(DstReg),
		.In0(RtAddr),
		.In1(RdAddr),
		.Out(wAddr_a)
	);

	//EX Register
	EX_Register EX_Register (
		.clk(clk),
		.rst(rst),
		.En(En),
		.Clr(Clr),
		.JumpAddr_i(JumpAddr_a),
		.Result_i(Result_a),
		.Zero_i(Zero_a),
		.rData2_i(rData2_i),
		.wAddr_i(wAddr_a),
		.JumpAddr(JumpAddr),
		.Result(Result),
		.Zero(Zero),
		.rData2(rData2),
		.wAddr(wAddr)
	);

endmodule
