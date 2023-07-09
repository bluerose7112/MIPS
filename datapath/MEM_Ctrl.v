module MEM_Ctrl (clk,rst,En,Clr,WriteReg_i,MemToReg_i,WriteReg,MemToReg);

	input clk, rst;
	input En, Clr;
	input WriteReg_i, MemToReg_i;

	output WriteReg, MemToReg;
		reg WriteReg, MemToReg;

	always @(posedge clk or negedge rst)
	begin
		if(!rst)
			{WriteReg,MemToReg} = 2'b00;
		else
			if(Clr)
				{WriteReg,MemToReg} = 2'b00;
			else if(En)
				{WriteReg,MemToReg} = {WriteReg_i,MemToReg_i};
	end

endmodule
