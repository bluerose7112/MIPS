module ID_Ctrl (clk,rst,En,Clr,WriteReg_i,MemToReg_i,Branch_i,ReadMem_i,WriteMem_i,DstReg_i,ALUSrc_i,ALU_Op_i,WriteReg,MemToReg,Branch,ReadMem,WriteMem,DstReg,ALUSrc,ALU_Op);

	input clk, rst;
	input En, Clr;
	input WriteReg_i, MemToReg_i;
	input Branch_i, ReadMem_i, WriteMem_i;
	input DstReg_i, ALUSrc_i;
	input[2:0] ALU_Op_i;

	output WriteReg, MemToReg;
	output Branch, ReadMem, WriteMem;
	output DstReg, ALUSrc;
	output[2:0] ALU_Op;
		reg WriteReg, MemToReg;
		reg Branch, ReadMem, WriteMem;
		reg DstReg, ALUSrc;
		reg[2:0] ALU_Op;

	always @(posedge clk or negedge rst)
	begin
		if(!rst)
		begin
			{WriteReg,MemToReg} = 2'b00;
			{Branch,ReadMem,WriteMem} = 3'b00;
			{DstReg,ALUSrc,ALU_Op} = {2'b00,3'b000};
		end
		else
		begin
			if(Clr)
			begin
				{WriteReg,MemToReg} = 2'b00;
				{Branch,ReadMem,WriteMem} = 3'b00;
				{DstReg,ALUSrc,ALU_Op} = {2'b00,3'b000};
			end
			else if(En)
			begin
				{WriteReg,MemToReg} = {WriteReg_i,MemToReg_i};
				{Branch,ReadMem,WriteMem} = {Branch_i,ReadMem_i,WriteMem_i};
				{DstReg,ALUSrc,ALU_Op} = {DstReg_i,ALUSrc_i,ALU_Op_i};
			end
		end
	end

endmodule
