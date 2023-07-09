`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:01:06 07/05/2013 
// Design Name: 
// Module Name:    Counter 
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
module Counter(clk, rst, clr, cnt);

	input clk, rst;
	input clr;

	output [3:0] cnt;
		reg [3:0] cnt;

	always @(posedge clk or negedge rst)
	begin
		if(!rst)
			cnt <= 4'd0;
		else
			if(clr)
				cnt <= 4'd0;
			else
				cnt <= cnt + 4'd1;
	end

endmodule
