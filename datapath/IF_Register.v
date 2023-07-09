module IF_Register (clk,rst,En,Clr,RefAddr_i,Instr_i,RefAddr,Instr);

	input clk, rst;
	input En, Clr;
	input[31:0] RefAddr_i, Instr_i;

	output[31:0] RefAddr, Instr;
		reg[31:0] RefAddr, Instr;

	always @(posedge clk or negedge rst)
	begin
		if(!rst)
			{RefAddr,Instr} <= {32'd0,32'd0};
		else
			if(Clr)
				{RefAddr,Instr} <= {32'd0,32'd0};
			else if(En)
				{RefAddr,Instr} <= {RefAddr_i,Instr_i};
	end

endmodule
