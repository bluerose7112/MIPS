`include "DefVal.v"

module ForwardingUnit (ID_RsAddr,ID_RtAddr,EX_wAddr,MEM_wAddr,EX_WriteReg,MEM_WriteReg,Fwd1,Fwd2);

	input[4:0] ID_RsAddr, ID_RtAddr;
	input[4:0] EX_wAddr, MEM_wAddr;
	input EX_WriteReg, MEM_WriteReg;

	output[1:0] Fwd1, Fwd2;
		reg[1:0] Fwd1, Fwd2;

	//Detect Forwarding RsAddr
	always @(ID_RsAddr or EX_wAddr or MEM_wAddr or EX_WriteReg or MEM_WriteReg)
	begin
		if(EX_WriteReg & (|EX_wAddr) & (EX_wAddr==ID_RsAddr))
			Fwd1 = `EX_FWD;
		else if(MEM_WriteReg & (|MEM_wAddr) & (MEM_wAddr==ID_RsAddr))
			Fwd1 = `MEM_FWD;
		else
			Fwd1 = `NO_FWD;
	end

	//Detect Forwarding RtAddr
	always @(ID_RtAddr or EX_wAddr or MEM_wAddr or EX_WriteReg or MEM_WriteReg)
	begin
		if(EX_WriteReg & (|EX_wAddr) & (EX_wAddr==ID_RtAddr))
			Fwd2 = `EX_FWD;
		else if(MEM_WriteReg & (|MEM_wAddr) & (MEM_wAddr==ID_RtAddr))
			Fwd2 = `MEM_FWD;
		else
			Fwd2 = `NO_FWD;
	end

endmodule
