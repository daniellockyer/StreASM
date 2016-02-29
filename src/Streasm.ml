open Hashtbl;;

let getValue register = 
		if Str.string_match (Str.regexp "\\([a-zA-Z]+\\)\\([0-9]+\\)") register 0 
		then
			begin
				print_string (Str.matched_group 1 register); print_newline() ;
				print_string (Str.matched_group 2 register); print_newline() ;
			end
		else
			print_string "No match";;

let registers = Hashtbl.create 5;;
let instr_mov (destination: string) (value: int) = Hashtbl.add registers destination value;;
