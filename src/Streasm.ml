open Hashtbl;;

let running = ref true;;
let return_stack : int list ref = ref [];;
let lines : string array array ref = ref (Array.of_list ((Array.of_list ("" :: [])) :: []));;
let index = ref 0;;
let registers = Hashtbl.create 32;;
let labels = Hashtbl.create 32;;

let map_label (label: string) (line: int) = 
    if label <> "" then
        if Hashtbl.mem labels label then
            if Hashtbl.find labels label = line then ()
            else raise (Failure ("Label " ^ label ^ " defined multiple times"))
        else
            Hashtbl.replace labels label line

let rec find_label_aux (label: string) (index: int) =
    if index < Array.length !lines then
        let l = Array.get !lines index in
            let (found_label: string) = Array.get l 0 in
                if label = found_label then index
                else find_label_aux label (index + 1)
    else raise (Failure ("Label " ^ label ^ " not defined."))

let find_label (label: string) =             
    if Hashtbl.mem labels label then Hashtbl.find labels label 
    else find_label_aux label !index        

let lookup (register: string) = 
    if Hashtbl.mem registers register then Hashtbl.find registers register
    else raise (Failure ("The register " ^ register ^ " is unbound on instruction " ^ (string_of_int !index)))

let value (register: string) =
    if Str.string_match (Str.regexp "[-]?[0-9]+") register 0 then
        int_of_string register
    else if Str.string_match (Str.regexp "[a-zA-Z]+[-]?[0-9]+") register 0 then
        lookup register
    else if Str.string_match (Str.regexp "\\([a-zA-Z]+\\)\\[\\([a-zA-Z]+[-]?[0-9]+\\)\\]") register 0 then  (* match for example r[r1] *)
        let outer = Str.matched_group 1 register in
            let inner = Str.matched_group 2 register in
                lookup (outer ^ (string_of_int (lookup inner))) 
    else raise (Failure ("The register " ^ register ^ " is unbound on instruction " ^ (string_of_int !index)))
        
let bind_value (register: string) (value: int) = 
    if Str.string_match (Str.regexp "\\([a-zA-Z]+\\)\\([-]?[0-9]+\\)") register 0 then
        let ident = Str.matched_group 1 register in
        let number = Str.matched_group 2 register in
        (* we want to remove many 0's, eg convert 00001 -> 1 *)
        Hashtbl.replace registers (ident ^ (string_of_int (int_of_string number))) value
    else if Str.string_match (Str.regexp "\\([a-zA-Z]+\\)\\[\\([a-zA-Z]+[-]?[0-9]+\\)\\]") register 0 then
        let ident = Str.matched_group 1 register in
        let number = Str.matched_group 2 register in
        Hashtbl.replace registers (ident ^ (string_of_int (lookup number))) value
    else
        raise (Failure ("Expected a register, recieved " ^ register))

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
    with End_of_file -> running:=false;;

let rec make_string (ident: string) (count: int) (total: int) (position: int) =
    if (count = 0 || count > total) && position < 1024 then
        let register = (ident ^ (string_of_int position)) in
            if Hashtbl.mem registers register then
                (print_int (lookup register); print_string " ";
                Hashtbl.remove registers register;
                make_string ident count (total+1) (position+1))
            else make_string ident count total (position+1)
    else if count <> 0 then
        raise (Failure ("Did not find " ^ (string_of_int count) ^ " values within 1024 indexes of " ^ ident))
    else ()
        
let instr_nxt (iden1: string) (iden2: string) = 
    if iden2 = "stdin" then
        if Str.string_match (Str.regexp "[a-zA-Z]+") iden1 0 then
            get_string iden1
        else
            raise (Failure ("\"" ^ iden1 ^ "\" unexpected for pairing with stdin."))
    else if iden1 = "stdout" then
        if Str.string_match (Str.regexp "[a-zA-Z]+") iden2 0 then
            (if Hashtbl.mem registers iden2 then
                make_string iden2 (lookup (iden2 ^ "0")) 0 1
            else
                make_string iden2 0 0 1;
            print_newline())
        else raise (Failure ("\"" ^ iden2 ^ "\" unexpected for pairing with stdout."))
    else raise (Failure "stdin must be used as the second parameter for NXT, or stdout used as the first.")

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
        | _ ->          raise ( Failure ("Unknown Instruction: " ^ instruction))) 
    done);;