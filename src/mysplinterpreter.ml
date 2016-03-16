open Streasm
open Lexer
open Parser
open Arg
open Printf

let parseProgram c = 
    let lexbuf = Lexing.from_channel c in
    	try 
        	let parsed = parser_main lexer_main lexbuf in
        	    interpret parsed
    	with Parsing.Parse_error ->
            (print_endline "*** ERROR ***";
            print_endline "An error occurred whilst parsing the file.\n";
            print_endline ("Line: " ^ (string_of_int !instructionPointer));
            print_endline ("Token: \"" ^ (Lexing.lexeme lexbuf) ^ "\"\n");
            print_endline "Please check the syntax and formatting of the line stated above. (A common issue is not indenting the instructions.)");;

let arg = ref stdin in
	let setProg p = arg := open_in p in
		parse [] setProg "./main <program_file> < input";

let _ = parseProgram !arg in
	flush stdout;;
