open Hashtbl;;

let registers = Hashtbl.create 5;;

let instr_add (destination: string) (val1: int) (val2: int) = Hashtbl.add registers destination (val1 + val2);;
let instr_sub (destination: string) (val1: int) (val2: int) = Hashtbl.add registers destination (val1 - val2);;

let instr_mov (register: string) (value: int) = Hashtbl.add registers register value;;
let instr_clr (register: string) = Hashtbl.add registers register 0;;

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
