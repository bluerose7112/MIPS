module JumpAddressAdder (RefAddr,Offset,JumpAddr);

	input[31:0] RefAddr;
	input[29:0] Offset;

	output[31:0] JumpAddr;
		wire[31:0] JumpAddr;

	assign JumpAddr = RefAddr + {Offset,2'b00};

endmodule
