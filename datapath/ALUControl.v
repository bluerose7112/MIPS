`include "DefVal.v"

module ALUControl (ALU_Op,Function,Control);

	input[2:0] ALU_Op;
	input[5:0] Function;

	output[2:0] Control;
		reg[2:0] Control;

	always @(ALU_Op or Function)
	begin
		if(ALU_Op == `ALU_FNCT)
		begin
			case(Function)
			`ADD:		Control = `ALU_ADD;
			`SUB:		Control = `ALU_SUB;
			`AND:		Control = `ALU_AND;
			`OR:		Control = `ALU_OR;
			`SLT:		Control = `ALU_SLT;
			default: Control = `ALU_NOP;
			endcase
		end
		else
			Control = ALU_Op;
	end

endmodule
