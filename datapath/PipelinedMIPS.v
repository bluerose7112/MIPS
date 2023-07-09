module PipelinedMIPS (iBclk,oBclk,clkA,clkB,clk,rst,Enable,iReady,dReady,Instr,rData,Ready,iWriteMem,iReadMem,dWriteMem,dReadMem,iAddr,dAddr,wData);

	input iBclk, oBclk;
	input clkA, clkB;
	input clk, rst;
	input Enable;
	input iReady, dReady;
	input[7:0] Instr, rData;

	output Ready;
	output iWriteMem, iReadMem;
	output dWriteMem, dReadMem;
	output[7:0] iAddr, dAddr, wData;
		wire Ready;
		wire iWriteMem, iReadMem;
		wire dWriteMem, dReadMem;
		wire[7:0] iAddr, dAddr, wData;

	wire[31:0] bInstr, brData;
	wire[31:0] biAddr, bdAddr, bwData;

	ReadyBuffer ReadyBuffer (
		.clk(clk),
		.rst(rst),
		.Ready(Ready)
	);

	InputBuffer InstrBuffer (
		.clk(iBclk),
		.rst(rst),
		.iData(Instr),
		.oData(bInstr)
	);

	InputBuffer rDataBuffer (
		.clk(iBclk),
		.rst(rst),
		.iData(rData),
		.oData(brData)
	);

	OutputBuffer iAddrBuffer (
		.clk(oBclk),
		.rst(rst),
		.iData(biAddr),
		.oData(iAddr)
	);

	OutputBuffer dAddrBuffer (
		.clk(oBclk),
		.rst(rst),
		.iData(bdAddr),
		.oData(dAddr)
	);

	OutputBuffer wDataBuffer (
		.clk(oBclk),
		.rst(rst),
		.iData(bwData),
		.oData(wData)
	);

	CachedMIPS CachedMIPS (
		.clkA(clkA), 
		.clkB(clkB), 
		.clk(clk), 
		.rst(rst), 
		.Enable(Ready&Enable), 
		.iReady(iReady), 
		.dReady(dReady), 
		.Instr(bInstr), 
		.rData(brData), 
		.iWriteMem(iWriteMem), 
		.iReadMem(iReadMem), 
		.dWriteMem(dWriteMem), 
		.dReadMem(dReadMem), 
		.iAddr(biAddr), 
		.dAddr(bdAddr), 
		.wData(bwData)
	);

endmodule
