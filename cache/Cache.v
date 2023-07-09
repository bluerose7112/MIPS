`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:50:07 06/30/2013 
// Design Name: 
// Module Name:    Cache 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module Cache(
		/*input*/
		clk, rst, Enable, complete,
		read_in, write_in, 
		addr_in,
		read_data_0, store_data_0,
		read_data_1, store_data_1,
		/*output*/
		cache_hit,
		write_0, load_0,
		write_1, load_1,
		read, load, store,
		cnt, addr_out, 
		read_data, store_data
		);

	input clk, rst;
	input Enable;
	input read_in, write_in, complete;
	input [31:0] addr_in;
	input [31:0] read_data_0, store_data_0;
	input [31:0] read_data_1, store_data_1;
	
	output read, load, store, cache_hit;
	wire	 read, load, store, cache_hit;
	
	output write_0, write_1;
	wire 	 write_0, write_1;
	
	output load_0, load_1;
	wire 	 load_0, load_1;
	
	output [3:0] cnt;
	wire	 [3:0] cnt;
			
	output [31:0] read_data, store_data;
	wire	 [31:0] read_data, store_data;
	
	output [31:0] addr_out;
	reg 	 [31:0] addr_out;
	
	wire wb; 
	wire write; 
	wire hit, clr;
	wire valid_in, ref_in, dirty_in, ref_wen;
	wire ref_0, valid_0, dirty_0, match_0;
	wire ref_1, valid_1, dirty_1, match_1;
	wire [3:0] index;
	wire [13:0] tag_in, tag, tag_0, tag_1;
	
	reg sel;
	
	assign tag_in = addr_in [23:10];
	assign index = addr_in [9:6];
	assign match_0 = (tag_0 == tag_in) & valid_0;
	assign match_1 = (tag_1 == tag_in) & valid_1;
	
	assign flg_wen_0 = write_0|load_0;
	assign flg_wen_1 = write_1|load_1;
	assign hit = match_0|match_1;
	
	always @(match_0 or match_1 or dirty_0 or dirty_1 or ref_0)
		casex({hit, dirty_0, dirty_1})
			3'b1xx : sel = match_1;
			3'b000 : sel = ref_0;
			3'b010 : sel = 1'b0;
			3'b001 : sel = 1'b1;
		endcase
	
	always @(addr_in[23:6] or cnt or tag or index or load or store)
		case({load, store})
			2'b01 : addr_out = {8'd0, tag, index, cnt, 2'd0};
			default : addr_out = {8'd0, addr_in [23:6], cnt, 2'd0};// addr_ld or addr_st
		endcase
		
	assign wb = (sel)? dirty_1 : dirty_0;	
	assign tag = (sel)? tag_1 : tag_0;
	
	assign {write_0, write_1} = (sel)? {1'b0, write} : {write, 1'b0};
	assign {load_0, load_1} = (sel)? {1'b0, load} : {load, 1'b0};
	
	assign read_data = (sel)? read_data_1 : read_data_0; // 이때 결정해주니 read 신호 하나만 있으면되네
	assign store_data = (sel)? store_data_1 : store_data_0; //store도 마찬가지네*/
	
	CachePart Cache0 (
		.clk(clk), 
		.rst(rst), 
		.ref_wen(ref_wen), 
		.flg_wen(flg_wen_0), 
		.valid_in(valid_in), 
		.ref_in(~sel), 
		.dirty_in(dirty_in), 
		.tag_in(tag_in), 
		.valid(valid_0), 
		.ref(ref_0), 
		.dirty(dirty_0), 
		.tag(tag_0),
		.index(index)
		);

	CachePart Cache1 (
		.clk(clk), 
		.rst(rst), 
		.ref_wen(ref_wen), 
		.flg_wen(flg_wen_1), 
		.valid_in(valid_in), 
		.ref_in(sel), 
		.dirty_in(dirty_in), 
		.tag_in(tag_in), 
		.valid(valid_1), 
		.ref(ref_1), 
		.dirty(dirty_1), 
		.tag(tag_1),
		.index(index)
		);

	Counter Counter (
		.clk(clk), 
		.rst(rst), 
		.clr(clr), 
		.cnt(cnt)
		);

	FSM FSM (
		.clk(clk), 
		.rst(rst), 
		.hit(hit), 
		.wb(wb), 
		.Enable(Enable), 
		.read_in(read_in), 
		.write_in(write_in), 
		.cnt(cnt),
		.ref_wen(ref_wen), 
		.valid(valid_in), 
		.dirty(dirty_in), 
		.clr(clr), 
		.read(read), 
		.write(write),
		.load(load),
		.store(store),
		.cache_hit(cache_hit),
		.complete(complete)
		);



endmodule
