open Hashtbl;;
open Lexing;;

let running = ref true;;

let lines : string array array ref = ref (Array.of_list ((Array.of_list ("" :: [])) :: []));;
let index = ref 0;;
let registers = Hashtbl.create 5;;

let labels = Hashtbl.create 5;;
let map_label (label: string) (line: int) = 
    if label <> "" then
        if Hashtbl.mem labels label then
            if Hashtbl.find labels label = line then
                ()
            else
                raise (Failure "wow wtf u doin' m8 dat label is defined")
        else
            Hashtbl.replace labels label line;;           
let rec find_label_aux (label: string) (index: int) = 
    if index < Array.length !lines then
        let l = Array.get !lines index in
            let (found_label: string) = Array.get l 0 in
            if label = found_label then
                index
            else
                find_label_aux label (index + 1)
    else
        raise (Failure "wow bitch get sum dem labels")
let find_label (label: string) =             
    if Hashtbl.mem labels label then
        Hashtbl.find labels label
    else
        find_label_aux label !index        

let lookup (register: string) = 
    if Hashtbl.mem registers register then
        Hashtbl.find registers register
    else
        raise (Failure ("The register " ^ register ^ " is unbound on instruction " ^ (string_of_int !index)))
    ;;

let value (register: string) =
    if Str.string_match (Str.regexp "[0-9]+") register 0 then
        int_of_string register
    else if Str.string_match (Str.regexp "[a-zA-Z]+[0-9]+") register 0 then
        lookup register
    else if Str.string_match (Str.regexp "\\([a-zA-Z]+\\)\\[\\([a-zA-Z]+[0-9]+\\)\\]") register 0 then  (* match for example r[r1] *)
        let outer = Str.matched_group 1 register in
            let inner = Str.matched_group 2 register in
                lookup (outer ^ (string_of_int (lookup inner))) 
    else
        raise (Failure ("The register " ^ register ^ " is unbound on instruction " ^ (string_of_int !index)))
        
let bind_value (register: string) (value: int) = 
    if Str.string_match (Str.regexp "\\([a-zA-Z]+\\)\\([0-9]+\\)") register 0 then
        let ident = Str.matched_group 1 register in
        let number = Str.matched_group 2 register in
        (* we want to remove many 0's, eg convert 00001 -> 1 *)
        Hashtbl.replace registers (ident ^ (string_of_int (int_of_string number))) value
    else if Str.string_match (Str.regexp "\\([a-zA-Z]+\\)\\[\\([a-zA-Z]+[0-9]+\\)\\]") register 0 then
        let ident = Str.matched_group 1 register in
        let number = Str.matched_group 2 register in
        Hashtbl.replace registers (ident ^ (string_of_int (lookup number))) value
    else
        raise (Failure ("The register " ^ register ^ " looks kinda odd to me? idk there's just something about it I don't like?"))
        

let instr_add (destination: string) (val1: int) (val2: int) = bind_value destination (val1 + val2);;
let instr_sub (destination: string) (val1: int) (val2: int) = bind_value destination (val1 - val2);;
let instr_mul (destination: string) (val1: int) (val2: int) = bind_value destination (val1 * val2);;
let instr_div (destination: string) (val1: int) (val2: int) = bind_value destination (val1 / val2);;
let instr_jmp (label: string) = 
    if label = "@END" then
        running := false
    else if label = "@NEXT" then
        ()
    else 
        index := find_label label
let condjump (b: bool) (label1: string) (label2: string) =
    if b then
        instr_jmp label1
    else
        instr_jmp label2
let instr_tstz (v: int) (label1: string) (label2: string) = condjump (v=0) label1 label2;;
let instr_tste (v1: int) (v2: int) (label1: string) (label2: string) = condjump (v1=v2) label1 label2;;
let instr_tstg (v1: int) (v2: int) (label1: string) (label2: string) = condjump (v1>v2) label1 label2;;
let instr_tstge (v1: int) (v2: int) (label1: string) (label2: string) = condjump (v1>=v2) label1 label2;;
let instr_tstl (v1: int) (v2: int) (label1: string) (label2: string) = condjump (v1<v2) label1 label2;;
let instr_tstle (v1: int) (v2: int) (label1: string) (label2: string) = condjump (v1<=v2) label1 label2;;
let instr_and (destination: string) (val1: int) (val2: int) = bind_value destination (val1 land val2);;
let instr_nand (destination: string) (val1: int) (val2: int) = bind_value destination (lnot (val1 land val2));;
let instr_or (destination: string) (val1: int) (val2: int) = bind_value destination (val1 lor val2);;
let instr_xor (destination: string) (val1: int) (val2: int) = bind_value destination (val1 lxor val2);;
let instr_nor (destination: string) (val1: int) (val2: int) = bind_value destination (lnot (val1 lor val2));;
let instr_com (destination: string) (value: int) = bind_value destination (lnot value);;
let instr_mov (register: string) (value: int) = bind_value register value;;
let instr_clr (register: string) = bind_value register 0;;
let instr_bs (register: string) (v: int) = bind_value register ((value register) lor (1 lsl v));;
let instr_bc (register: string) (v: int) = bind_value register ((value register) land (lnot (1 lsl v)));;
let instr_bt (reg_val: int) (bit: int) (label1: string) (label2: string) = condjump ((reg_val land (1 lsl bit)) > 0) label1 label2;;

let get_string (ident: string) = 
    (print_string "\n> ";
    let line = read_line() in
        let split = Str.split (Str.regexp " ") line in
            (bind_value (ident ^ "0") (List.length split);
            List.iteri (fun i elem ->
                bind_value (ident ^ (string_of_int (i + 1))) (int_of_string elem)
            ) split));;

let rec make_string (ident: string) (count: int) (total: int) (position: int) =
    if (count = 0 || count > total) && position < 1024 then
        let register = (ident ^ (string_of_int position)) in
            if Hashtbl.mem registers register then
                (print_int (lookup register); print_string " ";
                Hashtbl.remove registers register;
                make_string ident count (total+1) (position+1))
            else
                make_string ident count total (position+1)
    else if count <> 0 then
        raise (Failure "wow we searched 1024 things and didn't find your shit fuck off and sort your life out")
    else
        ()
        
let instr_nxt (iden1: string) (iden2: string) = 
    if iden2 = "stdin" then
        if Str.string_match (Str.regexp "[a-zA-Z]+") iden1 0 then
            get_string iden1
        else
            raise (Failure "wtf col1 looks weird!!!!!!!")
    else if iden1 = "stdout" then
        if Str.string_match (Str.regexp "[a-zA-Z]+") iden2 0 then
            if Hashtbl.mem registers iden2 then
                make_string iden2 (lookup (iden2 ^ "0")) 0 1
            else
                make_string iden2 0 0 1
        else
            raise (Failure "wtf col2 looks weird!!!!!!!") 
    else 
        raise (Failure "jeez ya gotta use stdin for col2 or stdout for col1!")

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
        (map_label label !index;
        incr index;
     (*   print_string ("<" ^ label ^ "> <" ^ instruction ^ ">" ^ p1 ^ " " ^ p2 ^ " " ^ p3 ^ " " ^ p4 ^ "\n");*)
        match instruction with
          "ADD" -> instr_add p1 (value p2) (value p3)
        | "SUB" -> instr_sub p1 (value p2) (value p3)
        | "MUL" -> instr_mul p1 (value p2) (value p3)
        | "DIV" -> instr_div p1 (value p2) (value p3)
        | "TSTZ" -> instr_tstz (value p1) p2 p3
        | "TSTE" -> instr_tste (value p1) (value p2) p3 p4
        | "TSTG" -> instr_tstg (value p1) (value p2) p3 p4
        | "TSTGE" -> instr_tstge (value p1) (value p2) p3 p4
        | "TSTL" -> instr_tstl (value p1) (value p2) p3 p4
        | "TSTLE" -> instr_tstle (value p1) (value p2) p3 p4
        | "AND" -> instr_and p1 (value p2) (value p3)
        | "OR" -> instr_or p1 (value p2) (value p3)
        | "NOR" -> instr_nor p1 (value p2) (value p3)
        | "XOR" -> instr_xor p1 (value p2) (value p3)
        | "NAND" -> instr_nand p1 (value p2) (value p3)
        | "COM" -> instr_com p1 (value p2)
        | "JMP" -> instr_jmp p1
        (*| "CALL" -> instr_call p1
        | "RET" -> instr_ret*)
        | "MOV" -> instr_mov p1 (value p2)
        | "CLR" -> instr_clr p1
        | "BS" -> instr_bs p1 (value p2) 
        | "BC" -> instr_bc p1 (value p2)
        | "BT" -> instr_bt (value p1) (value p2) p3 p4
        | "NXT" -> instr_nxt p1 p2
        | _ -> raise ( Failure "wow wtf" ) 
        ) 
    done);;
