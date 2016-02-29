type token =
  | LABEL_END
  | LABEL_NEXT
  | INSTR_DEF
  | INSTR_NXT
  | INSTR_JMP
  | INSTR_CALL
  | INSTR_RET
  | INSTR_MOV
  | INSTR_CLR
  | INSTR_BS
  | INSTR_BC
  | INSTR_BT
  | INSTR_AND
  | INSTR_OR
  | INSTR_NOR
  | INSTR_XOR
  | INSTR_NAND
  | INSTR_COM
  | INSTR_TSTN
  | INSTR_TSTZ
  | INSTR_TSTE
  | INSTR_TSTG
  | INSTR_TSTGE
  | INSTR_TSTL
  | INSTR_TSTLE
  | INSTR_ADD
  | INSTR_SUB
  | INSTR_MUL
  | INSTR_DIV
  | COMMA
  | COLON
  | EOF
  | LITERAL of (int)
  | IDENTIFIER of (string)
  | LABEL of (string)

val parser_main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> unit
