module InputBuffer (clk,rst,iData,oData);

	input clk, rst;
	input[7:0] iData;

	output[31:0] oData;
		reg[31:0] oData;

	reg[1:0] cnt;
	reg[31:8] buff;

	always @(negedge clk or negedge rst)
	begin
		if(!rst)
			cnt <= 2'd0;
		else
			cnt <= cnt + 2'b1;
	end

	always @(negedge clk or negedge rst)
	begin
		if(!rst)
			oData <= 32'd0;
		else
			case(cnt)
			2'b00: buff[31:24]	<= iData;
			2'b01: buff[23:16]	<= iData;
			2'b10: buff[15:8]		<= iData;
			2'b11: oData			<= {buff,iData};
			endcase
	end

endmodule
