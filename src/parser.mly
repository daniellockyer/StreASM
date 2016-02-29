%{
	open Streasm
	open Printf
%}
%token LABEL_END LABEL_NEXT
%token INSTR_DEF INSTR_NXT 
%token INSTR_JMP INSTR_CALL INSTR_RET INSTR_MOV INSTR_CLR INSTR_BS INSTR_BC INSTR_BT 
%token INSTR_AND INSTR_OR INSTR_NOR INSTR_XOR INSTR_NAND INSTR_COM 
%token INSTR_TSTN INSTR_TSTZ INSTR_TSTE INSTR_TSTG INSTR_TSTGE INSTR_TSTL INSTR_TSTLE
%token INSTR_ADD INSTR_SUB INSTR_MUL INSTR_DIV
%token COMMA COLON
%token EOF
%token <int> LITERAL
%token <string> IDENTIFIER

%start parser_main
%type <unit> parser_main
%%

parser_main
   	: instruction { }
   	| label { }
   	| parser_main instruction { }
   	| parser_main label { }
   	| EOF {}
;

label: register COLON {};

register:
	IDENTIFIER {}
;

value
	: register { (* TODO: getValue *)}
	| LITERAL {}
;

instruction
	: INSTR_ADD register COMMA value COMMA value { }
	| INSTR_ADD register COMMA value COMMA value { }
/*	| instruction_sub
	| instruction_mul
	| instruction_div
	| instruction_tstn
	| instruction_tstz
	| instruction_tste
	| instruction_tstg
	| instruction_tstge
	| instruction_tstl
	| instruction_tstle
	| instruction_and
	| instruction_or
	| instruction_nor
	| instruction_xor
	| instruction_nano
	| instruction_com
	| instruction_jmp
	| instruction_call
	| instruction_ret
	| instruction_mov
	| instruction_clr
	| instruction_bs
	| instruction_bc
	| instruction_bt
	| instruction_def
	| instruction_nxt*/
;