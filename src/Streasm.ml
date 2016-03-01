open Hashtbl;;
open Lexing;;

let lex = Lexing.from_string "";;

let set_lexbuf (lexer: lexbuf) =
    begin
        print_endline "aaaaaaa";
        ref lex := lexer;
    end;;

let registers = Hashtbl.create 5;;

let lookup (register: string) = 
    if Hashtbl.mem registers register
    then
        Hashtbl.find registers register
    else
        0    (* 0 for now but would be nice to return some kind of null maybe?*)
    ;;

let getValue (register: string) =
    if Str.string_match (Str.regexp "[a-zA-Z]+[0-9]+") register 0 
    then
        lookup register
    else 
        if Str.string_match (Str.regexp "\\([a-zA-Z]+\\)\\[\\([a-zA-Z]+[0-9]+\\)\\]") register 0 (* match for example r[r1] *)
        then
            let outer = Str.matched_group 1 register in
                let inner = Str.matched_group 2 register in
                    lookup (outer ^ (string_of_int (lookup inner))) 
        else
            0        (* return zero on fail for now: Would be nice to fail*)

let rec find_label (location: string) (returned: string) = 
    if returned = location
    then
        print_string "reached label?"   (*What do?*)
    else
        Lexing.new_line lex;
        find_label location (Lexing.lexeme lex);;

let instr_add (destination: string) (val1: int) (val2: int) = Hashtbl.add registers destination (val1 + val2);;
let instr_sub (destination: string) (val1: int) (val2: int) = Hashtbl.add registers destination (val1 - val2);;
let instr_mul (destination: string) (val1: int) (val2: int) = Hashtbl.add registers destination (val1 * val2);;
let instr_div (destination: string) (val1: int) (val2: int) = Hashtbl.add registers destination (val1 / val2);;

let instr_and (destination: string) (val1: int) (val2: int) = Hashtbl.add registers destination (val1 land val2);;
let instr_nand (destination: string) (val1: int) (val2: int) = Hashtbl.add registers destination (lnot (val1 land val2));;
let instr_or (destination: string) (val1: int) (val2: int) = Hashtbl.add registers destination (val1 lor val2);;
let instr_xor (destination: string) (val1: int) (val2: int) = Hashtbl.add registers destination (val1 lxor val2);;
let instr_nor (destination: string) (val1: int) (val2: int) = Hashtbl.add registers destination (lnot (val1 lor val2));;
let instr_com (destination: string) (value: int) = Hashtbl.add registers destination (lnot value);;

let instr_jmp (location: string) = 
    begin print_string "hello"; Lexing.flush_input lex; find_label location (Lexing.lexeme lex); end;;

let instr_mov (register: string) (value: int) = Hashtbl.add registers register value;;
let instr_clr (register: string) = Hashtbl.add registers register 0;;
let instr_bs (register: string) (value: int) = Hashtbl.add registers register ((getValue register) lor (1 lsl value));;
let instr_bc (register: string) (value: int) = Hashtbl.add registers register ((getValue register) land (lnot (1 lsl value)));;
