{
    open Arg
    open Lexing
    open Hashtbl
    open Parser
    exception Syntax_error of string
    
    let instructionPointer = ref 1;;

    let syntax_error msg lexbuf = raise (Syntax_error (msg ^ " on line " ^ (string_of_int !instructionPointer) ^ " with token \"" ^ (Lexing.lexeme lexbuf) ^ "\""));;

    let update_loc lexbuf =
        begin
            print_string "Updating location to "; print_int !instructionPointer; print_newline();
          (* lexbuf.Lexing.lex_curr_pos <- !instructionPointer; 
            lexbuf.Lexing.lex_curr_p <-
                { lexbuf.Lexing.lex_curr_p with 
                    pos_lnum = !instructionPointer; 
                };*)
        end;;
}

let digit = ['0'-'9']
let digits = digit+
let alpha = ['a'-'z' 'A'-'Z']
let iden = alpha digits | alpha '[' alpha digits ']'
let alphastring = alpha+
let comment = ";"([^'\n']+)

rule lexer_main = parse
    | ['\n' '\r'] { incr instructionPointer; update_loc lexbuf; lexer_main lexbuf; }
    | [' ' '\t'] { lexer_main lexbuf }
    | digits as d { LITERAL (int_of_string d) }
    | iden as lxm { IDENTIFIER (lxm) }
    | comment   { lexer_main lexbuf }
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
    | "JMP"     { Streasm.set_lexbuf lexbuf; INSTR_JMP }
    | "CALL"	{ INSTR_CALL }
    | "RET"		{ INSTR_RET }
    | "MOV"		{ INSTR_MOV }
    | "CLR"		{ INSTR_CLR }
    | "BS"		{ INSTR_BS }
    | "BC"		{ INSTR_BC }
    | "BT"		{ INSTR_BT }
    | "DEF"		{ INSTR_DEF }
    | "NXT"		{ INSTR_NXT }
    | "@END" as a { LABEL_END(a) }
    | "@NEXT" as a { LABEL_NEXT(a) }
    | alphastring as a { LABEL (a) }
    | _         { syntax_error "Couldn't identify the token" lexbuf }
    | eof      	{ print_endline "EOF"; EOF }
