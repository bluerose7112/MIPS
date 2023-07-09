`include "DefVal.v"

module ALU (Control,Src1,Src2,Result,Zero);

	input[2:0] Control;
	input[31:0] Src1, Src2;

	output[31:0] Result;
		reg[31:0] Result;
	output Zero;
		wire Zero;

	assign Zero = ~|Result;

	always @(Control or Src1 or Src2)
	begin
		case(Control)
		`ALU_NOP:	Result = 32'd0;
		`ALU_ADD:	Result = Src1 + Src2;
		`ALU_SUB:	Result = Src1 - Src2;
		`ALU_AND:	Result = Src1 & Src2;
		`ALU_OR:		Result = Src1 | Src2;
		`ALU_SLT:	Result = Src1 < Src2;
		default:		Result = 32'd0;
		endcase
	end

endmodule
