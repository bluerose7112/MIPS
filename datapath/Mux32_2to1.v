module Mux32_2to1 (Sel,In0,In1,Out);

	input Sel;
	input[31:0] In0, In1;

	output[31:0] Out;
		reg[31:0] Out;

	always @(Sel or In0 or In1)
	begin
		if(Sel)	// synopsys infer_mux
			Out = In1;
		else
			Out = In0;
	end

endmodule
