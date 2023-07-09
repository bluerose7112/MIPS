`include "DefVal.v"

module ControlUnit (Op,WriteReg,MemToReg,Branch,ReadMem,WriteMem,DstReg,ALUSrc,ALU_Op);

	input[5:0] Op;

	output WriteReg, MemToReg;
	output Branch, ReadMem, WriteMem;
	output DstReg, ALUSrc;
	output[2:0] ALU_Op;
		reg WriteReg, MemToReg;
		reg Branch, ReadMem, WriteMem;
		reg DstReg, ALUSrc;
		reg[2:0] ALU_Op;

	always @(Op)
	begin
		case(Op)
		`SPECIAL:	{WriteReg,MemToReg,Branch,ReadMem,WriteMem,DstReg,ALUSrc,ALU_Op} = {7'b1000010,`ALU_FNCT};
		`BEQ:			{WriteReg,MemToReg,Branch,ReadMem,WriteMem,DstReg,ALUSrc,ALU_Op} = {7'b0010010,`ALU_SUB};
		`ADDI:		{WriteReg,MemToReg,Branch,ReadMem,WriteMem,DstReg,ALUSrc,ALU_Op} = {7'b1000001,`ALU_ADD};
		`LW:			{WriteReg,MemToReg,Branch,ReadMem,WriteMem,DstReg,ALUSrc,ALU_Op} = {7'b1101001,`ALU_ADD};
		`SW:			{WriteReg,MemToReg,Branch,ReadMem,WriteMem,DstReg,ALUSrc,ALU_Op} = {7'b0000101,`ALU_ADD};
		default: 	{WriteReg,MemToReg,Branch,ReadMem,WriteMem,DstReg,ALUSrc,ALU_Op} = {7'b0000000,`ALU_NOP};
		endcase
	end

endmodule
