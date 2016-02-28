{
    open Parser
    open Arg

    let line_num = ref 1
    exception Syntax_error of string
    let syntax_error msg = raise (Syntax_error (msg ^ " on line " ^ (string_of_int !line_num)))
}

let digit = ['0'-'9']
let digits = digit*
let alpha = ['a'-'z' 'A'-'Z']
let iden = alpha (alpha | digit)*

rule lexer_main = parse
    | "\n"  	{ incr line_num; lexer_main lexbuf }
    | [' ' '\r' '\t'] { lexer_main lexbuf }
    | digits as d { LITERAL (int_of_string d) }
    | iden as lxm { IDENTIFIER (lxm) }
    | ","       { COMMA }
    | ":"       { COLON }
    | "ADD"		{ INSTR_ADD }
    | "SUB"		{ INSTR_SUB }
    | "MUL"		{ INSTR_MUL }
    | "DIV"		{ INSTR_DIV }
    | "TSTN"	{ INSTR_TSTN }
    | "TSTZ"	{ INSTR_TSTZ }
    | "TSTE"	{ INSTR_TSTE }
    | "TSTG"	{ INSTR_TSTG }
    | "TSTGE"	{ INSTR_TSTGE }
    | "TSTL"	{ INSTR_TSTL }
    | "TSTLE"	{ INSTR_TSTLE }
    | "AND"		{ INSTR_AND }
    | "OR"		{ INSTR_OR }
    | "NOR"		{ INSTR_NOR }
    | "XOR"		{ INSTR_XOR }
    | "NAND"	{ INSTR_NAND }
    | "COM"		{ INSTR_COM }
    | "JMP"		{ INSTR_JMP }
    | "CALL"	{ INSTR_CALL }
    | "RET"		{ INSTR_RET }
    | "MOV"		{ INSTR_MOV }
    | "CLR"		{ INSTR_CLR }
    | "BS"		{ INSTR_BS }
    | "BC"		{ INSTR_BC }
    | "BT"		{ INSTR_BT }
    | "DEF"		{ INSTR_DEF }
    | "NXT"		{ INSTR_NXT }
    | "@END"	{ LABEL_END }
    | "@NEXT"	{ LABEL_NEXT }
    | _         { syntax_error "Couldn't identify the token" }
    | eof      	{ EOF }