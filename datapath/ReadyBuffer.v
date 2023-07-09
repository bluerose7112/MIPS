module ReadyBuffer (clk,rst,Ready);

	input clk, rst;

	output Ready;
		wire Ready;

	reg[1:0] buff;

	assign Ready = &buff;

	always @(posedge clk or negedge rst)
	begin
		if(!rst)
			buff <= 2'd0;
		else
			if(!(&buff))
				buff <= buff + 2'd1;
	end

endmodule
