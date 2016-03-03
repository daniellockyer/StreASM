%{
    open Streasm
    open Printf
    
    let instructions = ref [];;
    
    let make_line (label: string) (instr: string list) = (label :: instr)
    
    let add_line (label: string) (instr: string list) = instructions := (make_line label instr) :: !instructions;;
    
    let add_instr instr p1 p2 p3 p4 = instr :: p1 :: p2 ::p3 :: p4 :: [];; 
%}
%token INSTR_NXT 
%token INSTR_JMP INSTR_CALL INSTR_RET INSTR_MOV INSTR_CLR INSTR_BS INSTR_BC INSTR_BT 
%token INSTR_AND INSTR_OR INSTR_NOR INSTR_XOR INSTR_NAND INSTR_COM 
%token INSTR_TSTN INSTR_TSTZ INSTR_TSTE INSTR_TSTG INSTR_TSTGE INSTR_TSTL INSTR_TSTLE
%token INSTR_ADD INSTR_SUB INSTR_MUL INSTR_DIV
%token COMMA COLON
%token EOF EOL WHITES
%token <string> LITERAL
%token <string> IDENTIFIER
%token <string> LABEL LABEL_NEXT LABEL_END

%start parser_main
%type <string list array> parser_main
%%

parser_main
   : temp EOF { Array.of_list (List.rev !instructions) }
;

temp
    : temp line { }
    | line { }
;

line
    : eol label WHITES instruction      { add_line $2 $4 }
    | eol label EOL WHITES instruction  { add_line $2 $5 }
    | eol WHITES instruction            { add_line "" $3 }
    | eol                               { }
;

eol
    : EOL   { }
    |       { }
;

register: IDENTIFIER { $1 };

value
    : register { $1 }
    | LITERAL { $1 }
;

label_ref
    : LABEL { $1 }
    | LABEL_NEXT { $1 }
    | LABEL_END { $1 }
;

label
    : LABEL COLON { $1 }
    | LABEL { $1 }
;

instruction
    : INSTR_ADD register COMMA value COMMA value { add_instr "add" $2 $4 $6 ""; }
    | INSTR_SUB register COMMA value COMMA value { add_instr "sub" $2 $4 $6 ""; }
    | INSTR_MUL register COMMA value COMMA value { add_instr "mul" $2 $4 $6 ""; }
    | INSTR_DIV register COMMA value COMMA value { add_instr "mul" $2 $4 $6 ""; }
    | INSTR_TSTZ value COMMA label_ref COMMA label_ref { add_instr "tstz" $2 $4 $6 ""; }
    | INSTR_TSTE value COMMA value COMMA label_ref COMMA label_ref { add_instr "tste" $2 $4 $6 $8; }
    | INSTR_TSTG value COMMA value COMMA label_ref COMMA label_ref { add_instr "tstg" $2 $4 $6 $8; }
    | INSTR_TSTGE value COMMA value COMMA label_ref COMMA label_ref { add_instr "tstge" $2 $4 $6 $8; }
    | INSTR_TSTL value COMMA value COMMA label_ref COMMA label_ref { add_instr "tstl" $2 $4 $6 $8; }
    | INSTR_TSTLE value COMMA value COMMA  label_ref COMMA label_ref { add_instr "tstle" $2 $4 $6 $8; }
    | INSTR_AND register COMMA value COMMA value { add_instr "and" $2 $4 $6 ""; }
    | INSTR_OR register COMMA value COMMA value { add_instr "or" $2 $4 $6 ""; }
    | INSTR_NOR register COMMA value COMMA value { add_instr "nor" $2 $4 $6 ""; }
    | INSTR_XOR register COMMA value COMMA value { add_instr "xor" $2 $4 $6 ""; }
    | INSTR_NAND register COMMA value COMMA value { add_instr "nand" $2 $4 $6 ""; }
    | INSTR_COM register COMMA value { add_instr "com" $2 $4 "" ""; }
    | INSTR_JMP label { add_instr "jmp" $2 "" "" ""; }
    | INSTR_CALL label { add_instr "call" $2 "" "" ""; }
    | INSTR_RET { add_instr "ret" "" "" "" ""; }
    | INSTR_MOV register COMMA value { add_instr "mov" $2 $4 "" ""; }
    | INSTR_CLR register { add_instr "clr" $2 "" "" ""; }
    | INSTR_BS register COMMA LITERAL { add_instr "bs" $2 $4 "" ""; }
    | INSTR_BC register COMMA LITERAL { add_instr "bc" $2 $4 "" ""; }
    | INSTR_BT register COMMA LITERAL COMMA label_ref COMMA label_ref { add_instr "bt" $2 $4 $6 $8; }
    | INSTR_NXT IDENTIFIER COMMA IDENTIFIER { add_instr "nxt" $2 $4 "" ""; }
;
