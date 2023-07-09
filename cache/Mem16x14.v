`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:49:11 07/06/2013 
// Design Name: 
// Module Name:    Mem128x9 
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
module Mem16x14(clk, rst, in, addr_in, wen, out);

	input clk, rst, wen;
	input [3:0] addr_in;
	input [13:0] in;
	
	output[13:0] out;
	wire	[13:0] out;

	reg [13:0] mem [0:15];
	
	integer i;
	
	assign out = mem [addr_in];

	always @ (posedge clk or negedge rst)
	begin
		if(~rst)
			for(i=0; i<16; i=i+1)
				mem [i] <= 14'd0;
		else
			if(wen)
				mem [addr_in] <= in;
	end
	
endmodule
