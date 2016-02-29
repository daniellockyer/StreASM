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

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
	open Streasm
	open Printf
# 43 "parser.ml"
let yytransl_const = [|
  257 (* LABEL_END *);
  258 (* LABEL_NEXT *);
  259 (* INSTR_DEF *);
  260 (* INSTR_NXT *);
  261 (* INSTR_JMP *);
  262 (* INSTR_CALL *);
  263 (* INSTR_RET *);
  264 (* INSTR_MOV *);
  265 (* INSTR_CLR *);
  266 (* INSTR_BS *);
  267 (* INSTR_BC *);
  268 (* INSTR_BT *);
  269 (* INSTR_AND *);
  270 (* INSTR_OR *);
  271 (* INSTR_NOR *);
  272 (* INSTR_XOR *);
  273 (* INSTR_NAND *);
  274 (* INSTR_COM *);
  275 (* INSTR_TSTN *);
  276 (* INSTR_TSTZ *);
  277 (* INSTR_TSTE *);
  278 (* INSTR_TSTG *);
  279 (* INSTR_TSTGE *);
  280 (* INSTR_TSTL *);
  281 (* INSTR_TSTLE *);
  282 (* INSTR_ADD *);
  283 (* INSTR_SUB *);
  284 (* INSTR_MUL *);
  285 (* INSTR_DIV *);
  286 (* COMMA *);
  287 (* COLON *);
    0 (* EOF *);
    0|]

let yytransl_block = [|
  288 (* LITERAL *);
  289 (* IDENTIFIER *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\001\000\001\000\001\000\003\000\004\000\005\000\
\005\000\005\000\005\000\002\000\000\000"

let yylen = "\002\000\
\001\000\001\000\002\000\002\000\001\000\002\000\001\000\006\000\
\006\000\006\000\006\000\001\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\005\000\007\000\000\000\001\000\002\000\
\000\000\012\000\000\000\003\000\004\000\006\000\000\000\000\000\
\000\000\000\000\000\000\010\000\011\000\009\000\008\000"

let yydgoto = "\002\000\
\006\000\007\000\008\000\009\000\010\000"

let yysindex = "\009\000\
\001\000\000\000\234\254\000\000\000\000\232\254\000\000\000\000\
\238\254\000\000\240\254\000\000\000\000\000\000\227\254\243\254\
\244\254\229\254\231\254\000\000\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\019\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\014\000\015\000\253\255\000\000"

let yytablesize = 290
let yytable = "\011\000\
\004\000\003\000\016\000\005\000\020\000\005\000\022\000\005\000\
\005\000\001\000\005\000\017\000\014\000\015\000\021\000\023\000\
\018\000\019\000\013\000\012\000\013\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\003\000\000\000\000\000\000\000\000\000\000\000\
\000\000\005\000"

let yycheck = "\003\000\
\000\000\026\001\032\001\033\001\032\001\033\001\032\001\033\001\
\033\001\001\000\033\001\015\000\031\001\030\001\018\000\019\000\
\030\001\030\001\000\000\006\000\006\000\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\255\
\255\255\255\255\026\001\255\255\255\255\255\255\255\255\255\255\
\255\255\033\001"

let yynames_const = "\
  LABEL_END\000\
  LABEL_NEXT\000\
  INSTR_DEF\000\
  INSTR_NXT\000\
  INSTR_JMP\000\
  INSTR_CALL\000\
  INSTR_RET\000\
  INSTR_MOV\000\
  INSTR_CLR\000\
  INSTR_BS\000\
  INSTR_BC\000\
  INSTR_BT\000\
  INSTR_AND\000\
  INSTR_OR\000\
  INSTR_NOR\000\
  INSTR_XOR\000\
  INSTR_NAND\000\
  INSTR_COM\000\
  INSTR_TSTN\000\
  INSTR_TSTZ\000\
  INSTR_TSTE\000\
  INSTR_TSTG\000\
  INSTR_TSTGE\000\
  INSTR_TSTL\000\
  INSTR_TSTLE\000\
  INSTR_ADD\000\
  INSTR_SUB\000\
  INSTR_MUL\000\
  INSTR_DIV\000\
  COMMA\000\
  COLON\000\
  EOF\000\
  "

let yynames_block = "\
  LITERAL\000\
  IDENTIFIER\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'instruction) in
    Obj.repr(
# 21 "parser.mly"
                  ( )
# 239 "parser.ml"
               : unit))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'label) in
    Obj.repr(
# 22 "parser.mly"
            ( )
# 246 "parser.ml"
               : unit))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : unit) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'instruction) in
    Obj.repr(
# 23 "parser.mly"
                              ( )
# 254 "parser.ml"
               : unit))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : unit) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'label) in
    Obj.repr(
# 24 "parser.mly"
                        ( )
# 262 "parser.ml"
               : unit))
; (fun __caml_parser_env ->
    Obj.repr(
# 25 "parser.mly"
          ()
# 268 "parser.ml"
               : unit))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'register) in
    Obj.repr(
# 28 "parser.mly"
                      ()
# 275 "parser.ml"
               : 'label))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 31 "parser.mly"
            ()
# 282 "parser.ml"
               : 'register))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'register) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'register) in
    Obj.repr(
# 35 "parser.mly"
                                                    ( )
# 291 "parser.ml"
               : 'instruction_add))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'register) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 36 "parser.mly"
                                                      ( )
# 300 "parser.ml"
               : 'instruction_add))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : int) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 37 "parser.mly"
                                                  ( )
# 309 "parser.ml"
               : 'instruction_add))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : int) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'register) in
    Obj.repr(
# 38 "parser.mly"
                                                   ( )
# 318 "parser.ml"
               : 'instruction_add))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'instruction_add) in
    Obj.repr(
# 43 "parser.mly"
                   ( )
# 325 "parser.ml"
               : 'instruction))
(* Entry parser_main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let parser_main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : unit)
