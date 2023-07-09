module EX_Ctrl (clk,rst,En,Clr,WriteReg_i,MemToReg_i,Branch_i,ReadMem_i,WriteMem_i,WriteReg,MemToReg,Branch,ReadMem,WriteMem);

	input clk, rst;
	input En, Clr;
	input WriteReg_i, MemToReg_i;
	input Branch_i, ReadMem_i, WriteMem_i;

	output WriteReg, MemToReg;
	output Branch, ReadMem, WriteMem;
		reg WriteReg, MemToReg;
		reg Branch, ReadMem, WriteMem;

	always @(posedge clk or negedge rst)
	begin
		if(!rst)
		begin
			{WriteReg,MemToReg} = 2'b00;
			{Branch,ReadMem,WriteMem} = 3'b00;
		end
		else
		begin
			if(Clr)
			begin
				{WriteReg,MemToReg} = 2'b00;
				{Branch,ReadMem,WriteMem} = 3'b00;
			end
			else if(En)
			begin
				{WriteReg,MemToReg} = {WriteReg_i,MemToReg_i};
				{Branch,ReadMem,WriteMem} = {Branch_i,ReadMem_i,WriteMem_i};
			end
		end
	end

endmodule
