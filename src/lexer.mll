{
    open Lexing
    open Parser
    exception Syntax_error of string
    
    let instructionPointer = ref 1;;
    let syntax_error lexbuf = raise (Syntax_error ("Couldn't identify the token on line " ^ (string_of_int !instructionPointer) ^ " with token \"" ^ (Lexing.lexeme lexbuf) ^ "\""));;
}

let literal = '-'? ['0'-'9']+
let alpha = ['a'-'z' 'A'-'Z']
let register = alpha literal | alpha '[' alpha literal ']'
let comment = ";"([^'\n']+)

rule lexer_main = parse
    | ['\n' '\r']       { incr instructionPointer; EOL }
    | [' ']             { lexer_main lexbuf }
    | ['\t']            { TAB }
    | ['0' '1'] as b    { BINARY (Char.escaped b) }
    | literal as d      { LITERAL (d) }
    | register as r     { REGISTER (r) }
    | comment           { lexer_main lexbuf }
    | alpha as a        { IDENTIFIER (Char.escaped a) } 
    | ","               { COMMA }
    | ":"               { COLON }
    | "ADD"		        { INSTR_ADD }
    | "SUB"		        { INSTR_SUB }
    | "MUL"		        { INSTR_MUL }
    | "DIV"		        { INSTR_DIV }
    | "TSTZ"	        { INSTR_TSTZ }
    | "TSTE"	        { INSTR_TSTE }
    | "TSTG"	        { INSTR_TSTG }
    | "TSTGE"	        { INSTR_TSTGE }
    | "TSTL"	        { INSTR_TSTL }
    | "TSTLE"	        { INSTR_TSTLE }
    | "AND"		        { INSTR_AND }
    | "OR"		        { INSTR_OR }
    | "NOR"		        { INSTR_NOR }
    | "XOR"		        { INSTR_XOR }
    | "NAND"	        { INSTR_NAND }
    | "COM"		        { INSTR_COM }
    | "JMP"             { INSTR_JMP }
    | "CALL"	        { INSTR_CALL }
    | "RET"		        { INSTR_RET }
    | "MOV"		        { INSTR_MOV }
    | "CLR"		        { INSTR_CLR }
    | "BS"		        { INSTR_BS }
    | "BT"		        { INSTR_BT }
    | "NXT"		        { INSTR_NXT }
    | "INCR"            { INSTR_INCR }
    | "DECR"            { INSTR_DECR }
    | "stdin" as i      { STDIN (i) }
    | "stdout" as o     { STDOUT (o) }
    | "@END" as a       { LABEL_END(a) }
    | "@NEXT" as a      { LABEL_NEXT(a) }
    | alpha+ as a       { LABEL (a) }
    | _                 { syntax_error lexbuf }
    | eof      	        { EOF }
