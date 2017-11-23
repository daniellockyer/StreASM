%{
    let instructions = ref [];;
    let add_line (label: string) (instr: string list) = instructions := Array.of_list (label :: instr) :: !instructions;;
    let add_instr instr p1 p2 p3 p4 = instr :: p1 :: p2 ::p3 :: p4 :: [];;
%}
%token INSTR_NXT INSTR_MOV INSTR_BS INSTR_INCR INSTR_DECR
%token INSTR_ADD INSTR_SUB INSTR_MUL INSTR_DIV
%token INSTR_AND INSTR_OR INSTR_NOR INSTR_XOR INSTR_NAND INSTR_COM
%token INSTR_CLR INSTR_JMP INSTR_CALL INSTR_RET
%token INSTR_TSTZ INSTR_TSTE INSTR_TSTG INSTR_TSTGE INSTR_TSTL INSTR_TSTLE INSTR_TSTB
%token COMMA COLON EOF EOL TAB DEF
%token <string> STDIN STDOUT
%token <string> IDENTIFIER REGISTER STRING LABEL_NEXT LABEL_END
%token <string> BINARY LITERAL

%start parser_main
%type <string array array> parser_main
%%

parser_main
    : lines { Array.of_list (List.rev !instructions) }
;

lines
    : lines line EOF {}
    | lines line EOL {}
    | line EOF {}
    | line EOL {}
    | lines EOL {}
    | EOL {}
;

line
    : label tab eol TAB instruction tab { add_line $1 $5 }
    | label tab eol TAB instruction { add_line $1 $5 }
    | label eol tab instruction { add_line $1 $4 }
    | label eol tab instruction tab { add_line $1 $4 }
    | TAB instruction tab { add_line "" $2 }
    | TAB instruction { add_line "" $2 }
    | define tab { add_line "" $1 }
    | define { add_line "" $1 }
    | tab {}
;

eol
    : EOL eol   { }
    | EOL       { }
;

tab
    : tab TAB   { }
    | TAB       { }
;

register
    : REGISTER { $1 }
    | STRING   { $1 }
;

value
    : register { $1 }
    | literal { $1 }
;

literal
    : LITERAL { $1 }
    | BINARY { $1 }
;

label_ref
    : STRING { $1 }
    | LABEL_NEXT { $1 }
    | LABEL_END { $1 }
;

label: STRING COLON { $1 };

ident1
    : IDENTIFIER { $1 }
    | STDOUT     { $1 }
;

ident2
    : IDENTIFIER { $1 }
    | STDIN     { $1 }
;

define
    : DEF STRING register { add_instr "DEF" $2 $3 "" "" }
;

instruction
    : INSTR_NXT ident1 COMMA ident2 { add_instr "NXT" $2 $4 "" "" }
    | INSTR_MOV register COMMA value { add_instr "MOV" $2 $4 "" "" }
    | INSTR_BS register COMMA LITERAL COMMA BINARY { add_instr "BS" $2 $4 $6 "" }
    | INSTR_INCR register { add_instr "INCR" $2 "" "" "" }
    | INSTR_DECR register { add_instr "DECR" $2 "" "" "" }
    | INSTR_ADD register COMMA value COMMA value { add_instr "ADD" $2 $4 $6 "" }
    | INSTR_SUB register COMMA value COMMA value { add_instr "SUB" $2 $4 $6 "" }
    | INSTR_MUL register COMMA value COMMA value { add_instr "MUL" $2 $4 $6 "" }
    | INSTR_DIV register COMMA value COMMA value { add_instr "DIV" $2 $4 $6 "" }
    | INSTR_AND register COMMA value COMMA value { add_instr "AND" $2 $4 $6 "" }
    | INSTR_OR register COMMA value COMMA value { add_instr "OR" $2 $4 $6 "" }
    | INSTR_NOR register COMMA value COMMA value { add_instr "NOR" $2 $4 $6 "" }
    | INSTR_XOR register COMMA value COMMA value { add_instr "XOR" $2 $4 $6 "" }
    | INSTR_NAND register COMMA value COMMA value { add_instr "NAND" $2 $4 $6 "" }
    | INSTR_COM register COMMA value { add_instr "COM" $2 $4 "" "" }
    | INSTR_CLR register { add_instr "CLR" $2 "" "" "" }
    | INSTR_JMP label_ref { add_instr "JMP" $2 "" "" "" }
    | INSTR_CALL STRING { add_instr "CALL" $2 "" "" "" }
    | INSTR_RET { add_instr "RET" "" "" "" "" }
    | INSTR_TSTZ value COMMA label_ref COMMA label_ref { add_instr "TSTZ" $2 $4 $6 "" }
    | INSTR_TSTE value COMMA value COMMA label_ref COMMA label_ref { add_instr "TSTE" $2 $4 $6 $8 }
    | INSTR_TSTG value COMMA value COMMA label_ref COMMA label_ref { add_instr "TSTG" $2 $4 $6 $8 }
    | INSTR_TSTGE value COMMA value COMMA label_ref COMMA label_ref { add_instr "TSTGE" $2 $4 $6 $8 }
    | INSTR_TSTL value COMMA value COMMA label_ref COMMA label_ref { add_instr "TSTL" $2 $4 $6 $8 }
    | INSTR_TSTLE value COMMA value COMMA  label_ref COMMA label_ref { add_instr "TSTLE" $2 $4 $6 $8 }
    | INSTR_TSTB register COMMA literal COMMA label_ref COMMA label_ref { add_instr "TSTB" $2 $4 $6 $8 }
;
