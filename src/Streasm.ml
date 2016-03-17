open Hashtbl;;

let running = ref true;;
let return_stack : int list ref = ref [];;
let lines : string array array ref = ref (Array.of_list ((Array.of_list ("" :: [])) :: []));;
let index = ref 0;;
let renamings = Hashtbl.create 16;;
let registers = Hashtbl.create 32;;
let labels = Hashtbl.create 32;;
let regex_lit = "\\(-?[0-9]+\\)";;
let regex_char = "\\([a-zA-Z]\\)";;
let regex_str = "\\([a-zA-Z]+\\)";;
let regex_reg = regex_char ^ regex_lit;;
let regex_nreg = regex_char ^ "\\[\\([a-zA-Z]-?[0-9]+\\)\\]\\|" ^ regex_char ^ "\\[\\([a-zA-Z]+\\)\\]";;

exception Interpreter_error;;
let throw_error_aux error msg = (print_endline ("[ " ^ (Printexc.to_string error) ^ " - line "  ^ (string_of_int !index) ^ " ] " ^ msg); raise error;);;
let throw_error msg = throw_error_aux Interpreter_error msg;;

let map_label (label: string) (line: int) = 
    if label <> "" then
        if Hashtbl.mem labels label then
            if Hashtbl.find labels label = line then ()
            else throw_error ("Label " ^ label ^ " defined multiple times")
        else Hashtbl.replace labels label line

let rec find_label_aux (label: string) (index: int) =
    if index < Array.length !lines then
        let l = Array.get !lines index in
            let (found_label: string) = Array.get l 0 in
                if label = found_label then index
                else find_label_aux label (index + 1)
    else throw_error ("Label " ^ label ^ " not defined")

let find_label (label: string) =             
    if Hashtbl.mem labels label then Hashtbl.find labels label 
    else find_label_aux label !index
    
let get_name_binding (name: string) =
    if Hashtbl.mem renamings name then Hashtbl.find renamings name
    else throw_error ("The naming " ^ name ^ " is undefined at instruction " ^ (string_of_int !index))

let rec lookup (register: string) =
    if Str.string_match (Str.regexp regex_reg) register 0 then
        if Hashtbl.mem registers register then Hashtbl.find registers register
        else throw_error ("The register " ^ register ^ " is unbound on instruction " ^ (string_of_int !index))
    else if Str.string_match (Str.regexp regex_str) register 0 then
        lookup (get_name_binding register)
    else throw_error ("Unexpected error: Asked to lookup " ^ register)

let rec value (register: string) =
    if Str.string_match (Str.regexp regex_lit) register 0 then
        int_of_string register
    else if Str.string_match (Str.regexp regex_reg) register 0 then
        lookup register
    else if Str.string_match (Str.regexp regex_nreg) register 0 then  (* match for example r[r1] or r[nicename] *)
        let outer = Str.matched_group 1 register in
            let inner = Str.matched_group 2 register in
                if Str.string_match (Str.regexp regex_str) inner 0 then
                    lookup (outer ^ (string_of_int (lookup (get_name_binding inner))))
                else lookup (outer ^ (string_of_int (lookup inner)))
    else if Str.string_match (Str.regexp regex_str) register 0 then (* match a naming defined with DEF *)
        value (get_name_binding register)
    else throw_error ("The register " ^ register ^ " is unbound on instruction " ^ (string_of_int !index))

let clean_regname (register: string) =
    if Str.string_match (Str.regexp regex_reg) register 0 then
        let ident = Str.matched_group 1 register in
        let number = Str.matched_group 2 register in
        (* we want to remove many 0's, eg convert 00001 -> 1 *)
        (ident ^ (string_of_int (int_of_string number)))
    else if Str.string_match (Str.regexp regex_nreg) register 0 then
        let ident = Str.matched_group 1 register in
        let number = Str.matched_group 2 register in
        (ident ^ (string_of_int (lookup number)))
    else
        throw_error ("Expected a register, received '" ^ register ^ "'")
        
let bind_value (register: string) (value: int) = 
    if ((Str.string_match (Str.regexp regex_reg) register 0) || (Str.string_match (Str.regexp regex_nreg) register 0)) then
        Hashtbl.replace registers (clean_regname register) value
    else if Str.string_match (Str.regexp regex_str) register 0 then
        Hashtbl.replace registers (get_name_binding register) value
    else
        throw_error ("Expected a register, received '" ^ register ^ "'")

let rename (new_name: string) (register: string) =
    if Str.string_match (Str.regexp regex_reg) register 0 then
        Hashtbl.replace renamings new_name (clean_regname register)
    else
        throw_error ("Expected a register, received '" ^ register ^ "'")

let instr_jmp (label: string) = 
    if label = "@END" then running := false
    else if label = "@NEXT" then ()
    else index := find_label label

let condjump (b: bool) (label1: string) (label2: string) =
    if b then instr_jmp label1
    else instr_jmp label2

let instr_bs (register: string) (pos: int) (v: int) = 
    if v = 1 then bind_value register ((value register) lor (1 lsl pos))
    else bind_value register ((value register) land (lnot (1 lsl v)))

let instr_ret () = match !return_stack with
    [] -> running := false
    | head::rest -> (index := head; return_stack := rest)
    
let get_string (ident: string) =
    try let line = read_line() in
        let split = Str.split (Str.regexp " ") line in
            (bind_value (ident ^ "0") (List.length split);
                List.iteri (fun i elem -> bind_value (ident ^ (string_of_int (i + 1))) (int_of_string elem)) split)
    with End_of_file -> bind_value (ident ^ "0") 0;;

let rec make_string (ident: string) (target: int) (found: int) (position: int) =
    if position < 1024 then
        if target = 0 || target <> found then
            let register = (ident ^ (string_of_int position)) in
                if Hashtbl.mem registers register then
                    (print_int (lookup register); print_string " ";
                    Hashtbl.remove registers register;
                    make_string ident target (found + 1) (position + 1))
                else make_string ident target found (position + 1)
        else ()      
    else if target <> 0 then
        throw_error ("Did not find " ^ (string_of_int target) ^ " values within 1024 indexes of " ^ ident)
    else ()
    
let instr_nxt (iden1: string) (iden2: string) = 
    if iden2 = "stdin" then
        if Str.string_match (Str.regexp regex_char) iden1 0 then
            get_string iden1
        else
            throw_error ("\"" ^ iden1 ^ "\" unexpected for pairing with stdin")
    else if iden1 = "stdout" then
        if Str.string_match (Str.regexp regex_char) iden2 0 then
            (if Hashtbl.mem registers (iden2 ^ "0") then
                (make_string iden2 (lookup (iden2 ^ "0")) 0 1; Hashtbl.remove registers (iden2 ^ "0"))
            else
                make_string iden2 0 0 1;
            print_newline())
        else throw_error ("\"" ^ iden2 ^ "\" unexpected for pairing with stdout")
    else throw_error "stdin must be used as the second parameter for NXT, or stdout used as the first"

let interpret (input: string array array) =
    (lines := input;
    while !index < Array.length !lines && !running do
        let l = Array.get !lines !index in
        let label = Array.get l 0 in
        let instruction = Array.get l 1 in
        let p1 = Array.get l 2 in
        let p2 = Array.get l 3 in
        let p3 = Array.get l 4 in
        let p4 = Array.get l 5 in
        (map_label label !index; incr index;
        (*print_string ("<" ^ (string_of_int !index) ^ "> <" ^ label ^ "> <" ^ instruction ^ "> " ^ p1 ^ " " ^ p2 ^ " " ^ p3 ^ " " ^ p4 ^ "\n");*)
        try
            match instruction with
              "ADD" ->      bind_value p1 ((value p2) + (value p3))
            | "SUB" ->      bind_value p1 ((value p2) - (value p3))
            | "MUL" ->      bind_value p1 ((value p2) * (value p3))
            | "DIV" ->      bind_value p1 ((value p2) / (value p3))
            | "AND" ->      bind_value p1 ((value p2) land (value p3))
            | "OR" ->       bind_value p1 ((value p2) lor (value p3))
            | "NOR" ->      bind_value p1 (lnot ((value p2) lor (value p3)))
            | "XOR" ->      bind_value p1 ((value p2) lxor (value p3))
            | "NAND" ->     bind_value p1 (lnot ((value p2) land (value p3)))
            | "COM" ->      bind_value p1 (lnot (value p2))
            | "MOV" ->      bind_value p1 (value p2)
            | "CLR" ->      bind_value p1 0
            | "INCR" ->     bind_value p1 ((value p1) + 1)
            | "DECR" ->     bind_value p1 ((value p1) - 1)
            | "TSTZ" ->     condjump ((value p1) = 0) p2 p3
            | "TSTE" ->     condjump ((value p1) = (value p2)) p3 p4
            | "TSTG" ->     condjump ((value p1) > (value p2)) p3 p4
            | "TSTGE" ->    condjump ((value p1) >= (value p2)) p3 p4
            | "TSTL" ->     condjump ((value p1) < (value p2)) p3 p4
            | "TSTLE" ->    condjump ((value p1) <= (value p2)) p3 p4
            | "TSTB" ->     condjump (((value p1) land (1 lsl (value p2))) > 0) p3 p4
            | "JMP" ->      instr_jmp p1
            | "CALL" ->     (return_stack := (!index :: !return_stack); instr_jmp p1)
            | "RET" ->      instr_ret ()
            | "BS" ->       instr_bs p1 (value p2) (value p3)
            | "NXT" ->      instr_nxt p1 p2
            | "DEF" ->      rename p1 p2
            | _ ->          throw_error ("Unknown Instruction: \"" ^ instruction ^ "\"")
        with _ as e -> throw_error_aux e "An error occurred when parsing the file");
    done);;