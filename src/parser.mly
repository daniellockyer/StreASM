%{
    open Streasm
    open Printf
%}
%token INSTR_DEF INSTR_NXT 
%token INSTR_JMP INSTR_CALL INSTR_RET INSTR_MOV INSTR_CLR INSTR_BS INSTR_BC INSTR_BT 
%token INSTR_AND INSTR_OR INSTR_NOR INSTR_XOR INSTR_NAND INSTR_COM 
%token INSTR_TSTN INSTR_TSTZ INSTR_TSTE INSTR_TSTG INSTR_TSTGE INSTR_TSTL INSTR_TSTLE
%token INSTR_ADD INSTR_SUB INSTR_MUL INSTR_DIV
%token COMMA COLON
%token EOF
%token <int> LITERAL
%token <string> IDENTIFIER
%token <string> LABEL LABEL_NEXT LABEL_END

%start parser_main
%type <unit> parser_main
%%

parser_main
   : parser_main line {}
   | line {}
   | EOF {}
;

line
    : label instruction {}
    | instruction {}
;

register: IDENTIFIER { $1 };

register_value: IDENTIFIER { getValue $1 };

value
    : register_value { $1 }
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
    : INSTR_ADD register COMMA value COMMA value { instr_add $2 $4 $6; print_string (string_of_int (getValue $2)); print_newline(); }
    | INSTR_SUB register COMMA value COMMA value { instr_sub $2 $4 $6; print_string (string_of_int (getValue $2)); print_newline(); }
    | INSTR_MUL register COMMA value COMMA value { instr_mul $2 $4 $6; print_string (string_of_int (getValue $2)); print_newline(); }
    | INSTR_DIV register COMMA value COMMA value { instr_div $2 $4 $6; print_string (string_of_int (getValue $2)); print_newline(); }
    | INSTR_TSTN register COMMA label_ref COMMA label_ref { }
    | INSTR_TSTZ register COMMA label_ref COMMA label_ref { }
    | INSTR_TSTE register COMMA register COMMA label_ref COMMA label_ref { }
    | INSTR_TSTG register COMMA register COMMA label_ref COMMA label_ref { }
    | INSTR_TSTGE register COMMA register COMMA label_ref COMMA label_ref { }
    | INSTR_TSTL register COMMA register COMMA label_ref COMMA label_ref { }
    | INSTR_TSTLE register COMMA register COMMA  label_ref COMMA label_ref { }
    | INSTR_AND register COMMA value COMMA value { instr_and $2 $4 $6; print_string (string_of_int (getValue $2)); print_newline(); }
    | INSTR_OR register COMMA value COMMA value { instr_or $2 $4 $6; print_string (string_of_int (getValue $2)); print_newline(); }
    | INSTR_NOR register COMMA value COMMA value { instr_nor $2 $4 $6; print_string (string_of_int (getValue $2)); print_newline(); }
    | INSTR_XOR register COMMA value COMMA value { instr_xor $2 $4 $6; print_string (string_of_int (getValue $2)); print_newline(); }
    | INSTR_NAND register COMMA value COMMA value { instr_nand $2 $4 $6; print_string (string_of_int (getValue $2)); print_newline(); }
    | INSTR_COM register COMMA value { instr_com $2 $4; print_string (string_of_int (getValue $2)); print_newline(); }
    | INSTR_JMP label { instr_jmp $2; }
    | INSTR_CALL label { }
    | INSTR_RET {}
    | INSTR_MOV register COMMA value { instr_mov $2 $4; print_string (string_of_int (getValue $2)); print_newline(); }
    | INSTR_CLR register { instr_clr $2; print_string (string_of_int (getValue $2)); print_newline(); }
    | INSTR_BS register COMMA LITERAL { instr_bs $2 $4; print_string (string_of_int (getValue $2)); print_newline(); }
    | INSTR_BC register COMMA LITERAL { instr_bc $2 $4; print_string (string_of_int (getValue $2)); print_newline(); }
    | INSTR_BT register COMMA LITERAL COMMA label_ref COMMA label_ref {}
    | INSTR_DEF IDENTIFIER { }
    | INSTR_NXT IDENTIFIER COMMA IDENTIFIER {}
;
