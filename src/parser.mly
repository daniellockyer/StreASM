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
%token <string> LABEL

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

label
	: LABEL {}
	| LABEL COLON {}
;

register: IDENTIFIER { getValue $1 };

value
	: register {  }
	| LITERAL { }
;

label_branches
	: LABEL {}
	| LABEL_NEXT {}
	| LABEL_END {}
;

instruction
	: INSTR_ADD register COMMA value COMMA value { }
	| INSTR_SUB register COMMA value COMMA value { }
	| INSTR_MUL register COMMA value COMMA value { }
	| INSTR_DIV register COMMA value COMMA value { }
	| INSTR_TSTN register COMMA label_branches COMMA label_branches { }
	| INSTR_TSTZ register COMMA label_branches COMMA label_branches { }
	| INSTR_TSTE register COMMA register COMMA label_branches COMMA label_branches { }
	| INSTR_TSTG register COMMA register COMMA label_branches COMMA label_branches { }
	| INSTR_TSTGE register COMMA register COMMA label_branches COMMA label_branches { }
	| INSTR_TSTL register COMMA register COMMA label_branches COMMA label_branches { }
	| INSTR_TSTLE register COMMA register COMMA  label_branches COMMA label_branches { }
	| INSTR_AND register COMMA value COMMA value { }
	| INSTR_OR register COMMA value COMMA value { }
	| INSTR_NOR register COMMA value COMMA value { }
	| INSTR_XOR register COMMA value COMMA value { }
	| INSTR_NAND register COMMA value COMMA value { }
	| INSTR_COM register COMMA register { }
	| INSTR_JMP label_branches { }
	| INSTR_CALL label { }
	| INSTR_RET {}
	| INSTR_MOV register COMMA value {}
	| INSTR_CLR register {}
	| INSTR_BS register COMMA LITERAL {}
	| INSTR_BC register	COMMA LITERAL {}
	| INSTR_BT register COMMA LITERAL COMMA label_branches COMMA label_branches {}
	| INSTR_DEF IDENTIFIER { }
	| INSTR_NXT IDENTIFIER COMMA IDENTIFIER {}
;
