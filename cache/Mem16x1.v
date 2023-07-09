`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:14:02 07/06/2013 
// Design Name: 
// Module Name:    Mem128x1 
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
module Mem16x1(clk, rst, in, addr_in, wen, out);

	input clk, rst, wen;
	input [3:0] addr_in; //index
	input in;
	
	output out;
	wire	 out;
	
	reg mem [0:15];
	
	integer i;
	
	assign out = mem [addr_in];

	always @(posedge clk or negedge rst)
	begin
		if(~rst)
			for(i=0; i<16; i=i+1)
				mem [i] <= 1'b0;
		else
			if(wen)
				mem [addr_in] <= in;
	end

endmodule
