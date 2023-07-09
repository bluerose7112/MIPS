module PCAddressAdder (In,Out);

	input[31:0] In;

	output[31:0] Out;
		wire[31:0] Out;

	assign Out = In + 32'd4;

endmodule
