module Cache_(
		/* input */
		clkA, clkB, clk, rst, Enable, complete, read_in, write_in, addr_in, write_data, load_data,
		/* output */
		load, store, cache_hit, read_data, store_data, addr_out
    );
	
	input clkA, clkB;
	input clk, rst;
	input Enable;
	input complete;//from MainMemory
	input read_in, write_in;//from MIPS
	input [31:0] addr_in;
	input [31:0] write_data, load_data;
	
	output load, store, cache_hit; // to control MM
	wire	 load, store, cache_hit;
	
	output [31:0] addr_out;
	wire 	 [31:0] addr_out;
	
	output [31:0] read_data, store_data;
	wire 	 [31:0] read_data, store_data;
	
	
	
	//여기는 메인 메모리가 없다
	
	
	wire read;
	wire write_0, load_0;
	wire write_1, load_1;
	wire [3:0] cnt;
	wire [31:0] read_data_0, store_data_0;
	wire [31:0] read_data_1, store_data_1;

	Cache Cache (
		.clk(clk), 
		.rst(rst), 
		.Enable(Enable), 
		.complete(complete), //이놈은 메인 메모리에서 와야해
		.read_in(read_in), 
		.write_in(write_in), 
		.addr_in(addr_in), 
		.read_data_0(read_data_0), 
		.store_data_0(store_data_0), 
		.read_data_1(read_data_1), 
		.store_data_1(store_data_1), 
		.cnt(cnt), 
		.write_0(write_0), 
		.load_0(load_0), 
		.write_1(write_1), 
		.load_1(load_1), 
		.read(read), 
		.load(load), 
		.store(store), 
		.addr_out(addr_out),// 메인 메모리 떄문에 
		.read_data(read_data), 
		.store_data(store_data),
		.cache_hit(cache_hit)
		);

	dpsram256x32 Mem0 (
		.QA(read_data_0), 
		.CLKA(clkA), 
		.CENA(1'b0), // enable
		.WENA(~write_0), 
		.AA(addr_in[9:2]), 
		.DA(write_data), 
		.OENA(~read), 
		.QB(store_data_0), 
		.CLKB(clkB), 
		.CENB(1'b0), 
		.WENB(~load_0),
		.AB({addr_in[9:6], cnt}), 
		.DB(load_data),
		.OENB(~store)
	);

	dpsram256x32 Mem1 (
		.QA(read_data_1), 
		.CLKA(clkA), 
		.CENA(1'b0), 
		.WENA(write_1), 
		.AA(addr_in[9:2]), 
		.DA(write_data), 
		.OENA(~read), 
		.QB(store_data_1), 
		.CLKB(clkB), 
		.CENB(1'b0), 
		.WENB(~load_1), 
		.AB({addr_in[9:6], cnt}), 
		.DB(load_data), 
		.OENB(~store)
	);
		
	//여기는 메인 메모리가 없다

endmodule
