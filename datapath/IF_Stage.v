module IF_Stage (clk,rst,En,Clr,PCSrc,JumpAddr,Instr_i,iAddr,RefAddr,Instr);

	input clk, rst;
	input En, Clr;
	input PCSrc;
	input[31:0] JumpAddr, Instr_i;

	output[31:0] iAddr;
	output[31:0] RefAddr, Instr;
		wire[31:0] iAddr;
		wire[31:0] RefAddr, Instr;

	wire[31:0] PC, RefAddr_a;

	//PC Register
	PC_Register PC_Register (
		.clk(clk),
		.rst(rst),
		.En(En),
		.Clr(Clr),
		.PC_i(RefAddr_a),
		.PC(PC)
	);

	//JumpAddr vs. RefAddr
	Mux32_2to1 AddressMux (
		.Sel(PCSrc),
		.In0(PC),
		.In1(JumpAddr),
		.Out(iAddr)
	);

	//Instruction Address Adder
	PCAddressAdder PCAddressAdder (
		.In(iAddr),
		.Out(RefAddr_a)
	);

	//IF Register
	IF_Register IF_Register (
		.clk(clk),
		.rst(rst),
		.En(En),
		.Clr(Clr),
		.RefAddr_i(RefAddr_a),
		.Instr_i(Instr_i),
		.RefAddr(RefAddr),
		.Instr(Instr)
	);

endmodule
