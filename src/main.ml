open Streasm
open Lexer
open Parser
open Arg
open Printf
exception Error of exn * (int * int * string)

let parseProgram c = 
    let lexbuf = Lexing.from_channel c in
    	try 
        	parser_main lexer_main lexbuf 
    	with Parsing.Parse_error ->
    		begin
		        let curr = lexbuf.Lexing.lex_curr_p in
		        let line = curr.Lexing.pos_lnum in
		        let cnum = curr.Lexing.pos_cnum - curr.Lexing.pos_bol in
		        let tok = Lexing.lexeme lexbuf in
		        	begin
		        		print_string "Line: "; print_int line; print_newline();
		        		print_string "Column: "; print_int cnum; print_newline();
		        		print_string "Token: "; print_string tok; print_newline();
				        raise (Error (Parsing.Parse_error, (line,cnum,tok)))
		        	end
	      	end;;

let arg = ref stdin in
	let setProg p = arg := open_in p in
		parse [] setProg "./main PROGRAM_FILE";

let _ = parseProgram !arg in
	flush stdout;;
