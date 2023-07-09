module Mux32_3to1 (Sel,In0,In1,In2,Out);

	input[1:0] Sel;
	input[31:0] In0, In1, In2;

	output[31:0] Out;
		reg[31:0] Out;

	always @(Sel or In0 or In1 or In2)
	begin
		case(Sel)	// synopsys full_case
		2'b00: Out = In0;
		2'b01: Out = In1;
		2'b10: Out = In2;
		endcase
	end

endmodule
