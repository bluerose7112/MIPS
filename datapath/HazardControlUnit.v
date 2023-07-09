module HazardControlUnit (Enable,LoadStall,SetBranch,nStall,Flush);

	input Enable, LoadStall, SetBranch;

	output[3:0] nStall, Flush;
		reg[3:0] nStall, Flush;

	always @(Enable or LoadStall or SetBranch)
	begin
		if(!Enable)
			{nStall,Flush} = {4'b0000,4'b0000};
		else if(LoadStall)
			{nStall,Flush} = {4'b0011,4'b0010};
		else if(SetBranch)
			{nStall,Flush} = {4'b1111,4'b0110};
		else
			{nStall,Flush} = {4'b1111,4'b0000};
	end

endmodule
