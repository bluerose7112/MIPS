module StallDetection (ID_RsAddr,ID_RtAddr,ID_ALUSrc,EX_wAddr,EX_ReadMem,LoadStall);

	input[4:0] ID_RsAddr, ID_RtAddr;
	input ID_ALUSrc;
	input[4:0] EX_wAddr;
	input EX_ReadMem;

	output LoadStall;
		wire LoadStall;

	assign LoadStall = EX_ReadMem & ((ID_RsAddr==EX_wAddr) | ((~ID_ALUSrc)&(ID_RtAddr==EX_wAddr)));

endmodule
