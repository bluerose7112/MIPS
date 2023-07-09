module Datapath (clk,rst,Enable,Instr,rData,dWriteMem,dReadMem,iAddr,dAddr,wData);

	input clk, rst;
	input Enable;
	input[31:0] Instr, rData;

	output dWriteMem, dReadMem;
	output[31:0] iAddr, dAddr, wData;
		wire dWriteMem, dReadMem;
		wire[31:0] iAddr, dAddr, wData;

	//IF_Stage
	wire[31:0] IF_RefAddr, IF_Instr;

	//ID_Stage
	wire[31:0] ID_RefAddr, ID_rData1, ID_rData2, ID_Offset;
	wire[4:0] ID_RsAddr, ID_RtAddr, ID_RdAddr;

	//EX Stage
	wire[31:0] EX_JumpAddr, EX_Result;
	wire Zero;
	wire[31:0] EX_rData2;
	wire[4:0] EX_wAddr;

	//MEM Stage
	wire[31:0] MEM_rData, MEM_Result;
	wire[4:0] MEM_wAddr;
	wire[31:0] MEM_wData;

	//Forwarding Unit
	wire[1:0] Fwd1, Fwd2;
	wire[31:0] FWD_rData1, FWD_rData2;

	//Jump Detection
	wire SetBranch;

	//Stall Detection
	wire LoadStall;

	//Hazard Control Unit
	wire[3:0] nStall, Flush;

	//Control Unit
	wire WriteReg, MemToReg;
	wire Branch, ReadMem, WriteMem;
	wire DstReg, ALUSrc;
	wire[2:0] ALU_Op;

	//ID Stage Control
	wire ID_WriteReg, ID_MemToReg;
	wire ID_Branch, ID_ReadMem, ID_WriteMem;
	wire ID_DstReg, ID_ALUSrc;
	wire[2:0] ID_ALU_Op;

	//EX Stage Control
	wire EX_WriteReg, EX_MemToReg;
	wire EX_Branch, EX_ReadMem, EX_WriteMem;

	//MEM Stage Control
	wire MEM_WriteReg, MEM_MemToReg;

	IF_Stage IF_Stage (
		.clk(clk),
		.rst(rst),
		.En(nStall[3]),
		.Clr(Flush[3]),
		.PCSrc(SetBranch),
		.JumpAddr(EX_JumpAddr),
		.Instr_i(Instr),
		.iAddr(iAddr),
		.RefAddr(IF_RefAddr),
		.Instr(IF_Instr)
	);

	ID_Stage ID_Stage (
		.clk(clk),
		.rst(rst),
		.En(nStall[2]),
		.Clr(Flush[2]),
		.RefAddr_i(IF_RefAddr),
		.Instr(IF_Instr[25:0]),
		.WriteReg(MEM_WriteReg),
		.wAddr(MEM_wAddr),
		.wData(MEM_wData),
		.RefAddr(ID_RefAddr),
		.rData1(ID_rData1),
		.rData2(ID_rData2),
		.Offset(ID_Offset),
		.RsAddr(ID_RsAddr),
		.RtAddr(ID_RtAddr),
		.RdAddr(ID_RdAddr)
	);

	EX_Stage EX_Stage (
		.clk(clk),
		.rst(rst),
		.En(nStall[1]),
		.Clr(Flush[1]),
		.RefAddr(ID_RefAddr),
		.rData1(FWD_rData1),
		.rData2_i(FWD_rData2),
		.Offset(ID_Offset),
		.RtAddr(ID_RtAddr),
		.RdAddr(ID_RdAddr),
		.DstReg(ID_DstReg),
		.ALUSrc(ID_ALUSrc),
		.ALU_Op(ID_ALU_Op),
		.JumpAddr(EX_JumpAddr),
		.Result(EX_Result),
		.Zero(Zero),
		.rData2(EX_rData2),
		.wAddr(EX_wAddr)
	);

	assign dAddr = EX_Result;
	assign wData = EX_rData2;

	MEM_Stage MEM_Stage (
		.clk(clk),
		.rst(rst),
		.En(nStall[0]),
		.Clr(Flush[0]),
		.rData_i(rData),
		.Result_i(EX_Result),
		.wAddr_i(EX_wAddr),
		.rData(MEM_rData),
		.Result(MEM_Result),
		.wAddr(MEM_wAddr)
	);

	Mux32_2to1 Mux32_2to1 (
		.Sel(MEM_MemToReg),
		.In0(MEM_Result),
		.In1(MEM_rData),
		.Out(MEM_wData)
	);

	Mux32_3to1 FwdMux1 (
		.Sel(Fwd1),
		.In0(ID_rData1),
		.In1(EX_Result),
		.In2(MEM_wData),
		.Out(FWD_rData1)
	);

	 Mux32_3to1 FwdMux2 (
		.Sel(Fwd2),
		.In0(ID_rData2),
		.In1(EX_Result),
		.In2(MEM_wData),
		.Out(FWD_rData2)
	);

	ForwardingUnit ForwardingUnit (
		.ID_RsAddr(ID_RsAddr),
		.ID_RtAddr(ID_RtAddr),
		.EX_wAddr(EX_wAddr),
		.MEM_wAddr(MEM_wAddr),
		.EX_WriteReg(EX_WriteReg),
		.MEM_WriteReg(MEM_WriteReg),
		.Fwd1(Fwd1),
		.Fwd2(Fwd2)
	);

	//Bracn Detection
	assign SetBranch = EX_Branch & Zero;

	StallDetection StallDetection (
		.ID_RsAddr(ID_RsAddr),
		.ID_RtAddr(ID_RtAddr),
		.ID_ALUSrc(ID_ALUSrc),
		.EX_wAddr(EX_wAddr),
		.EX_ReadMem(EX_ReadMem),
		.LoadStall(LoadStall)
	);

	HazardControlUnit HazardControlUnit (
		.Enable(Enable),
		.LoadStall(LoadStall),
		.SetBranch(SetBranch),
		.nStall(nStall),
		.Flush(Flush)
	);

	ControlUnit ControlUnit (
		.Op(IF_Instr[31:26]),
		.WriteReg(WriteReg),
		.MemToReg(MemToReg),
		.Branch(Branch),
		.ReadMem(ReadMem),
		.WriteMem(WriteMem),
		.DstReg(DstReg),
		.ALUSrc(ALUSrc),
		.ALU_Op(ALU_Op)
	);

	ID_Ctrl ID_Ctrl (
		.clk(clk),
		.rst(rst),
		.En(nStall[2]),
		.Clr(Flush[2]),
		.WriteReg_i(WriteReg),
		.MemToReg_i(MemToReg),
		.Branch_i(Branch),
		.ReadMem_i(ReadMem),
		.WriteMem_i(WriteMem),
		.DstReg_i(DstReg),
		.ALUSrc_i(ALUSrc),
		.ALU_Op_i(ALU_Op),
		.WriteReg(ID_WriteReg),
		.MemToReg(ID_MemToReg),
		.Branch(ID_Branch),
		.ReadMem(ID_ReadMem),
		.WriteMem(ID_WriteMem),
		.DstReg(ID_DstReg),
		.ALUSrc(ID_ALUSrc),
		.ALU_Op(ID_ALU_Op)
	);

	EX_Ctrl EX_Ctrl (
		.clk(clk),
		.rst(rst),
		.En(nStall[1]),
		.Clr(Flush[1]),
		.WriteReg_i(ID_WriteReg),
		.MemToReg_i(ID_MemToReg),
		.Branch_i(ID_Branch),
		.ReadMem_i(ID_ReadMem),
		.WriteMem_i(ID_WriteMem),
		.WriteReg(EX_WriteReg),
		.MemToReg(EX_MemToReg),
		.Branch(EX_Branch),
		.ReadMem(EX_ReadMem),
		.WriteMem(EX_WriteMem)
	);

	assign dReadMem = EX_ReadMem;
	assign dWriteMem = EX_WriteMem;

	MEM_Ctrl MEM_Ctrl (
		.clk(clk),
		.rst(rst),
		.En(nStall[0]),
		.Clr(Flush[0]),
		.WriteReg_i(EX_WriteReg),
		.MemToReg_i(EX_MemToReg),
		.WriteReg(MEM_WriteReg),
		.MemToReg(MEM_MemToReg)
	);

endmodule
