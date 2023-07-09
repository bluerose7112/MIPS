module OutputBuffer (clk,rst,iData,oData);

	input clk, rst;
	input[31:0] iData;

	output[7:0] oData;
		reg[7:0] oData;

	reg[1:0] cnt;
	
	always @(posedge clk or negedge rst)
	begin
		if(!rst)
			cnt <= 2'd0;
		else
			cnt <= cnt + 2'b1;
	end

	always @(posedge clk or negedge rst)
	begin
		if(!rst)
			oData <= 8'd0;
		else
			case(cnt)
			2'b00: oData	<= iData[31:24];
			2'b01: oData	<= iData[23:16];
			2'b10: oData	<= iData[15:8];
			2'b11: oData	<= iData[7:0];
			endcase
	end

endmodule
