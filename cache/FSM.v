`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date:    18:30:57 07/05/2013
// Design Name:
// Module Name:    FSM
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
`define RD_WR	2'b00
`define LOAD	2'b01
`define STORE	2'b10
`define WAIT	2'b11

module FSM(
		/* input */
		clk, rst, Enable, hit, wb, complete, read_in, write_in, cnt,
		/* output */
		ref_wen, valid, dirty, clr, read, write, load, store, cache_hit
	);

	input clk, rst;
	input Enable;
	input hit, wb, complete;
	input read_in, write_in;
	input [3:0] cnt;
	
	output ref_wen, valid, dirty, clr, read, write, load, store;
	reg 	 ref_wen, valid, dirty, clr, read, write, load, store;

	output cache_hit;
	reg	 cache_hit;

	reg [1:0] state, next_state;

	always @(posedge clk or negedge rst)
	begin
		if(!rst)
			state <= `RD_WR;
		else
			if(Enable)
				state <= next_state;
	end
	
	always @(state or hit or wb or cnt or complete)
		case(state)
			`RD_WR : next_state = (hit)? `RD_WR : ((wb)? `STORE : `LOAD);
			`STORE : next_state = (cnt == 15)? `WAIT : `STORE;
			`WAIT  : next_state = (complete)? `LOAD : `WAIT;
			`LOAD  : next_state = (cnt == 15)? `RD_WR : `LOAD;
		endcase

	always @(state or hit or read_in or write_in)
		case(state)
			`RD_WR : {ref_wen, valid, dirty, clr, read, write, load, store, cache_hit} = (hit)? {4'b1111, read_in, write_in, 3'b001} : 9'b011100000;
			`STORE : {ref_wen, valid, dirty, clr, read, write, load, store, cache_hit} = 9'b011000010;
			`WAIT  : {ref_wen, valid, dirty, clr, read, write, load, store, cache_hit} = 9'b011100000;
			`LOAD  : {ref_wen, valid, dirty, clr, read, write, load, store, cache_hit} = 9'b010000100;
		endcase
endmodule
