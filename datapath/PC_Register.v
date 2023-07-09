module PC_Register (clk,rst,En,Clr,PC_i,PC);

	input clk, rst;
	input En, Clr;
	input[31:0] PC_i;

	output[31:0] PC;
		reg[31:0] PC;

	always @(posedge clk or negedge rst)
	begin
		if(!rst)
			PC <= 32'd0;
		else
			if(Clr)
				PC <= 32'd0;
			else if(En)
				PC <= PC_i;
	end

endmodule
