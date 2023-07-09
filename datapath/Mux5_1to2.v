module Mux5_1to2 (Sel,In0,In1,Out);

	input Sel;
	input[4:0] In0, In1;

	output[4:0] Out;
		wire[4:0] Out;

	assign Out = (Sel)?(In1):(In0);

endmodule
