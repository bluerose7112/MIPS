`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:43:00 07/06/2013 
// Design Name: 
// Module Name:    DataCache 
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
module CachePart(
		/* input */
		clk, rst, ref_wen, flg_wen, index,
		valid_in, ref_in, dirty_in, tag_in,
		/* output */
		valid, ref, dirty, tag
    );

	input clk, rst, ref_wen, flg_wen;
	input valid_in, ref_in, dirty_in;
	input [3:0] index;
	input [13:0] tag_in;
	
	output ref, valid, dirty;
	wire	 ref, valid, dirty;
	
	output [13:0] tag;
	wire 	 [13:0] tag;
		
	
	//rst를 어찌쓸것인가
	Mem16x1 Reference (
		 .clk(clk), 
		 .rst(rst), 
		 .in(ref_in), 
		 .addr_in(index), 
		 .wen(ref_wen), 
		 .out(ref)
		 );

	Mem16x1 Valid (
		 .clk(clk), 
		 .rst(rst), 
		 .in(valid_in), 
		 .addr_in(index), 
		 .wen(flg_wen), 
		 .out(valid)
		 );

	Mem16x1 Dirty (
		 .clk(clk), 
		 .rst(rst), 
		 .in(dirty_in), 
		 .addr_in(index), 
		 .wen(flg_wen), 
		 .out(dirty)
		 );

	Mem16x14 Tag (
		 .clk(clk), 
		 .rst(rst), 
		 .wen(flg_wen), //write or load
		 .addr_in(index), 
		 .in(tag_in), 
		 .out(tag)
		 );


endmodule

