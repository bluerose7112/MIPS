module CachedMIPS(
		/* input *///miss 났을때 들어오는 놈들
		clkA, clkB, clk, rst, Enable, iReady, dReady, Instr, rData,
		/* output */
		iWriteMem, iReadMem, dWriteMem, dReadMem, iAddr, dAddr, wData
    );
	
	input clkA, clkB;
	input clk, rst;
	input Enable;
	input iReady, dReady;
	input[31:0] Instr, rData;
	
	output iWriteMem, iReadMem;
	output dWriteMem, dReadMem;
	output[31:0] iAddr, dAddr, wData;
		wire iWriteMem, iReadMem;
		wire dWriteMem, dReadMem;
		wire[31:0] iAddr, dAddr, wData;
	
	wire d_read, d_write;
	wire i_hit, d_hit;
	wire [31:0] i_addr, d_addr;
	wire [31:0] read_instr, read_data, write_data;
	
	Cache_ InstrCache ( //instruction은 read load 밖에 안하지
		.clkA(clkA), 
		.clkB(clkB), 
		.clk(clk), 
		.rst(rst), 
		.Enable(Enable), 
		.complete(iReady), 
		.read_in(1'b1), //주소가 이상한 놈이 들어오지는 않겠지
		.write_in(1'b0), 
		.addr_in(i_addr), 
		.write_data(32'd0), 
		.load_data(Instr), 
		.load(iReadMem), //miss 나면 메모리로 쏴주기
		.store(iWriteMem), 
		.cache_hit(i_hit), 
		.read_data(read_instr), 
		.store_data(), 
		.addr_out(iAddr) //miss 났을때 load 해와야 하니까
	);

	Cache_ DataCache (
		.clkA(clkA), 
		.clkB(clkB), 
		.clk(clk), 
		.rst(rst), 
		.Enable(Enable), 
		.complete(dReady), 
		.read_in(d_read), 
		.write_in(d_write), 
		.addr_in(d_addr), 
		.write_data(write_data), 
		.load_data(rData), 
		.load(dReadMem), 
		.store(dWriteMem), 
		.cache_hit(d_hit), 
		.read_data(read_data), 
		.store_data(wData), 
		.addr_out(dAddr)
	);

	Datapath Datapath (
		.clk(clk),
		.rst(rst),
		.Enable(Enable&i_hit&d_hit),
		.Instr(read_instr), 
		.rData(read_data), 
		.dWriteMem(d_write), 
		.dReadMem(d_read), 
		.iAddr(i_addr), 
		.dAddr(d_addr), 
		.wData(write_data)
	);

endmodule
