{
    open Arg
    open Lexing
    open Hashtbl
    open Parser
    exception Syntax_error of string
    
    let instructionPointer = ref 1;;
    let syntax_error msg lexbuf = raise (Syntax_error (msg ^ " on line " ^ (string_of_int !instructionPointer) ^ " with token \"" ^ (Lexing.lexeme lexbuf) ^ "\""));;
}

let digit = ['0'-'9']
let digits = digit+
let alpha = ['a'-'z' 'A'-'Z']
let register = alpha digits | alpha '[' alpha digits ']'
let alphastr = alpha+
let comment = ";"([^'\n']+)
let newline = ['\n' '\r']
let label = [^' ' '\t'] newline alphastr | [^' ' '\t'] alphastr ":"

rule lexer_main = parse
    | newline { incr instructionPointer; EOL }
    | [' ']     { lexer_main lexbuf }
    | ['\t']    { TAB }
    | digits as d { LITERAL (d) }
    | register as r { REGISTER (r) }
    | comment   { lexer_main lexbuf }
    | label as l { LABEL (l) }
    | ","       { COMMA }
    | ":"       { COLON }
    | "ADD"		{ INSTR_ADD }
    | "SUB"		{ INSTR_SUB }
    | "MUL"		{ INSTR_MUL }
    | "DIV"		{ INSTR_DIV }
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
    | "JMP"     { INSTR_JMP }
    | "CALL"	{ INSTR_CALL }
    | "RET"		{ INSTR_RET }
    | "MOV"		{ INSTR_MOV }
    | "CLR"		{ INSTR_CLR }
    | "BS"		{ INSTR_BS }
    | "BC"		{ INSTR_BC }
    | "BT"		{ INSTR_BT }
    | "NXT"		{ INSTR_NXT }
    | "stdin" as i  { STDIN (i) }
    | "stdout" as o { STDOUT (o) }
    | "@END" as a { LABEL_END(a) }
    | "@NEXT" as a { LABEL_NEXT(a) }
    | alphastr as a { IDENTIFIER (a) }
    | _         { syntax_error "Couldn't identify the token" lexbuf }
    | eof      	{ EOF }
