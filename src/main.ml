open Streasm
open Lexer
open Parser
open Arg
open Printf
exception Error of exn * (int * string)

let parseProgram c = 
    let lexbuf = Lexing.from_channel c in
    	try 
        	let parsed = parser_main lexer_main lexbuf in
        	    interpret parsed
    	with Parsing.Parse_error ->
    		begin
		        let line = !instructionPointer in
		        let tok = Lexing.lexeme lexbuf in
		        	begin
		        		print_string "Line: "; print_int line; print_newline();
		        		print_string ("Token: <" ^ tok ^ ">\n"); print_newline();
				        raise (Error (Parsing.Parse_error, (line,tok)))
		        	end
	      	end;;

let arg = ref stdin in
	let setProg p = arg := open_in p in
		parse [] setProg "./main <program_file>";

let _ = parseProgram !arg in
	flush stdout;;
