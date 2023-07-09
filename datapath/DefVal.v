//OpCode Definition
`define SPECIAL		6'b000000
`define BEQ				6'b000100
`define ADDI			6'b001000
`define LW				6'b100011
`define SW				6'b101011

//Function Code Definition
`define ADD				6'b100000
`define SUB				6'b100010
`define AND				6'b100100
`define OR				6'b100101
`define SLT				6'b101010

//ALU Operation
`define ALU_NOP		3'b000
`define ALU_FNCT		3'b001
`define ALU_ADD		3'b010
`define ALU_SUB		3'b011
`define ALU_AND		3'b100
`define ALU_OR			3'b101
`define ALU_SLT		3'b110

//Forwarding Select
`define EX_FWD			2'b01
`define MEM_FWD		2'b10
`define NO_FWD			2'b00