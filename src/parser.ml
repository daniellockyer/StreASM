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

open Parsing;;
let _ = parse_error;;
# 2 "parser.mly"
	open Streasm
	open Printf
# 44 "parser.ml"
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
  290 (* LABEL *);
    0|]

let yylhs = "\255\255\
\001\000\001\000\001\000\001\000\001\000\003\000\003\000\004\000\
\005\000\005\000\006\000\006\000\006\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\002\000\002\000\002\000\002\000\002\000\002\000\002\000\002\000\
\000\000"

let yylen = "\002\000\
\001\000\001\000\002\000\002\000\001\000\001\000\002\000\001\000\
\001\000\001\000\001\000\001\000\001\000\006\000\006\000\006\000\
\006\000\006\000\006\000\008\000\008\000\008\000\008\000\008\000\
\006\000\006\000\006\000\006\000\006\000\004\000\002\000\002\000\
\001\000\004\000\002\000\004\000\004\000\008\000\002\000\004\000\
\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\033\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\005\000\000\000\000\000\
\001\000\002\000\039\000\000\000\013\000\012\000\011\000\031\000\
\032\000\008\000\000\000\035\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\007\000\003\000\004\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\040\000\010\000\009\000\034\000\036\000\037\000\000\000\
\000\000\000\000\000\000\000\000\000\000\030\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\025\000\026\000\027\000\028\000\029\000\
\018\000\019\000\000\000\000\000\000\000\000\000\000\000\014\000\
\015\000\016\000\017\000\000\000\000\000\000\000\000\000\000\000\
\000\000\038\000\020\000\021\000\022\000\023\000\024\000"

let yydgoto = "\002\000\
\032\000\033\000\034\000\092\000\093\000\040\000"

let yysindex = "\255\255\
\001\000\000\000\254\254\255\254\026\255\000\255\000\000\002\255\
\002\255\002\255\002\255\002\255\002\255\002\255\002\255\002\255\
\002\255\002\255\002\255\002\255\002\255\002\255\002\255\002\255\
\002\255\002\255\002\255\002\255\002\255\000\000\005\255\141\255\
\000\000\000\000\000\000\007\255\000\000\000\000\000\000\000\000\
\000\000\000\000\008\255\000\000\009\255\010\255\011\255\012\255\
\013\255\014\255\015\255\016\255\017\255\018\255\019\255\020\255\
\021\255\023\255\024\255\025\255\027\255\028\255\031\255\032\255\
\000\000\000\000\000\000\030\255\253\254\041\255\042\255\048\255\
\253\254\253\254\253\254\253\254\253\254\002\255\026\255\026\255\
\002\255\002\255\002\255\002\255\002\255\253\254\253\254\253\254\
\253\254\000\000\000\000\000\000\000\000\000\000\000\000\034\255\
\051\255\052\255\053\255\054\255\055\255\000\000\061\255\062\255\
\073\255\074\255\075\255\076\255\077\255\078\255\079\255\080\255\
\081\255\026\255\253\254\253\254\253\254\253\254\253\254\026\255\
\026\255\026\255\026\255\026\255\026\255\026\255\253\254\253\254\
\253\254\253\254\082\255\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\083\255\084\255\085\255\086\255\087\255\000\000\
\000\000\000\000\000\000\026\255\026\255\026\255\026\255\026\255\
\026\255\000\000\000\000\000\000\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\033\000\056\000\
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
\000\000\000\000\000\000\000\000\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\086\000\020\000\250\255\013\000\201\255"

let yytablesize = 323
let yytable = "\001\000\
\030\000\043\000\044\000\045\000\046\000\047\000\048\000\049\000\
\050\000\051\000\052\000\053\000\054\000\055\000\056\000\057\000\
\058\000\059\000\060\000\061\000\062\000\063\000\064\000\103\000\
\104\000\041\000\037\000\038\000\091\000\042\000\035\000\036\000\
\006\000\031\000\042\000\065\000\068\000\069\000\070\000\071\000\
\072\000\073\000\074\000\075\000\076\000\077\000\078\000\079\000\
\080\000\081\000\082\000\067\000\083\000\084\000\085\000\041\000\
\086\000\087\000\131\000\039\000\088\000\089\000\090\000\114\000\
\137\000\138\000\139\000\140\000\141\000\142\000\143\000\102\000\
\094\000\095\000\105\000\106\000\107\000\108\000\109\000\096\000\
\115\000\116\000\117\000\118\000\119\000\097\000\098\000\099\000\
\100\000\101\000\120\000\121\000\154\000\155\000\156\000\157\000\
\158\000\159\000\110\000\111\000\112\000\113\000\122\000\123\000\
\124\000\125\000\126\000\127\000\128\000\129\000\130\000\148\000\
\149\000\150\000\151\000\152\000\153\000\066\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\132\000\
\133\000\134\000\135\000\136\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\144\000\145\000\146\000\147\000\003\000\
\004\000\005\000\006\000\007\000\008\000\009\000\010\000\011\000\
\012\000\013\000\014\000\015\000\016\000\017\000\018\000\019\000\
\020\000\021\000\022\000\023\000\024\000\025\000\026\000\027\000\
\028\000\029\000\000\000\000\000\000\000\000\000\031\000\000\000\
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
\000\000\000\000\000\000\003\000\004\000\005\000\006\000\007\000\
\008\000\009\000\010\000\011\000\012\000\013\000\014\000\015\000\
\016\000\017\000\018\000\019\000\020\000\021\000\022\000\023\000\
\024\000\025\000\026\000\027\000\028\000\029\000\000\000\000\000\
\000\000\000\000\031\000\006\000\006\000\006\000\006\000\006\000\
\006\000\006\000\006\000\006\000\006\000\006\000\006\000\006\000\
\006\000\006\000\006\000\006\000\006\000\006\000\006\000\006\000\
\006\000\006\000\006\000\006\000\006\000\006\000\000\000\000\000\
\000\000\000\000\006\000"

let yycheck = "\001\000\
\000\000\008\000\009\000\010\000\011\000\012\000\013\000\014\000\
\015\000\016\000\017\000\018\000\019\000\020\000\021\000\022\000\
\023\000\024\000\025\000\026\000\027\000\028\000\029\000\079\000\
\080\000\006\000\001\001\002\001\032\001\033\001\033\001\033\001\
\000\000\034\001\033\001\031\001\030\001\030\001\030\001\030\001\
\030\001\030\001\030\001\030\001\030\001\030\001\030\001\030\001\
\030\001\030\001\030\001\032\000\030\001\030\001\030\001\000\000\
\030\001\030\001\114\000\034\001\030\001\030\001\033\001\030\001\
\120\000\121\000\122\000\123\000\124\000\125\000\126\000\078\000\
\032\001\032\001\081\000\082\000\083\000\084\000\085\000\032\001\
\030\001\030\001\030\001\030\001\030\001\073\000\074\000\075\000\
\076\000\077\000\030\001\030\001\148\000\149\000\150\000\151\000\
\152\000\153\000\086\000\087\000\088\000\089\000\030\001\030\001\
\030\001\030\001\030\001\030\001\030\001\030\001\030\001\030\001\
\030\001\030\001\030\001\030\001\030\001\032\000\255\255\255\255\
\255\255\255\255\255\255\255\255\255\255\255\255\255\255\115\000\
\116\000\117\000\118\000\119\000\255\255\255\255\255\255\255\255\
\255\255\255\255\255\255\127\000\128\000\129\000\130\000\003\001\
\004\001\005\001\006\001\007\001\008\001\009\001\010\001\011\001\
\012\001\013\001\014\001\015\001\016\001\017\001\018\001\019\001\
\020\001\021\001\022\001\023\001\024\001\025\001\026\001\027\001\
\028\001\029\001\255\255\255\255\255\255\255\255\034\001\255\255\
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
\255\255\255\255\255\255\003\001\004\001\005\001\006\001\007\001\
\008\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\017\001\018\001\019\001\020\001\021\001\022\001\023\001\
\024\001\025\001\026\001\027\001\028\001\029\001\255\255\255\255\
\255\255\255\255\034\001\003\001\004\001\005\001\006\001\007\001\
\008\001\009\001\010\001\011\001\012\001\013\001\014\001\015\001\
\016\001\017\001\018\001\019\001\020\001\021\001\022\001\023\001\
\024\001\025\001\026\001\027\001\028\001\029\001\255\255\255\255\
\255\255\255\255\034\001"

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
  LABEL\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'instruction) in
    Obj.repr(
# 22 "parser.mly"
                  ( )
# 309 "parser.ml"
               : unit))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'label) in
    Obj.repr(
# 23 "parser.mly"
            ( )
# 316 "parser.ml"
               : unit))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : unit) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'instruction) in
    Obj.repr(
# 24 "parser.mly"
                              ( )
# 324 "parser.ml"
               : unit))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : unit) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'label) in
    Obj.repr(
# 25 "parser.mly"
                        ( )
# 332 "parser.ml"
               : unit))
; (fun __caml_parser_env ->
    Obj.repr(
# 26 "parser.mly"
          ()
# 338 "parser.ml"
               : unit))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 30 "parser.mly"
         ()
# 345 "parser.ml"
               : 'label))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    Obj.repr(
# 31 "parser.mly"
               ()
# 352 "parser.ml"
               : 'label))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 35 "parser.mly"
            ()
# 359 "parser.ml"
               : 'register))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'register) in
    Obj.repr(
# 39 "parser.mly"
            ( (* TODO: getValue *) )
# 366 "parser.ml"
               : 'value))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 40 "parser.mly"
           ()
# 373 "parser.ml"
               : 'value))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 44 "parser.mly"
         ()
# 380 "parser.ml"
               : 'label_branches))
; (fun __caml_parser_env ->
    Obj.repr(
# 45 "parser.mly"
              ()
# 386 "parser.ml"
               : 'label_branches))
; (fun __caml_parser_env ->
    Obj.repr(
# 46 "parser.mly"
             ()
# 392 "parser.ml"
               : 'label_branches))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'value) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'value) in
    Obj.repr(
# 50 "parser.mly"
                                              ( )
# 401 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'value) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'value) in
    Obj.repr(
# 51 "parser.mly"
                                              ( )
# 410 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'value) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'value) in
    Obj.repr(
# 52 "parser.mly"
                                              ( )
# 419 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'value) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'value) in
    Obj.repr(
# 53 "parser.mly"
                                              ( )
# 428 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'label_branches) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'label_branches) in
    Obj.repr(
# 54 "parser.mly"
                                                                 ( )
# 437 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'label_branches) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'label_branches) in
    Obj.repr(
# 55 "parser.mly"
                                                                 ( )
# 446 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 6 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : 'register) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'label_branches) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : 'label_branches) in
    Obj.repr(
# 56 "parser.mly"
                                                                                ( )
# 456 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 6 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : 'register) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'label_branches) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : 'label_branches) in
    Obj.repr(
# 57 "parser.mly"
                                                                                ( )
# 466 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 6 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : 'register) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'label_branches) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : 'label_branches) in
    Obj.repr(
# 58 "parser.mly"
                                                                                 ( )
# 476 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 6 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : 'register) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'label_branches) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : 'label_branches) in
    Obj.repr(
# 59 "parser.mly"
                                                                                ( )
# 486 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 6 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : 'register) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'label_branches) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : 'label_branches) in
    Obj.repr(
# 60 "parser.mly"
                                                                                  ( )
# 496 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'value) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'value) in
    Obj.repr(
# 61 "parser.mly"
                                              ( )
# 505 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'value) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'value) in
    Obj.repr(
# 62 "parser.mly"
                                             ( )
# 514 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'value) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'value) in
    Obj.repr(
# 63 "parser.mly"
                                              ( )
# 523 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'value) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'value) in
    Obj.repr(
# 64 "parser.mly"
                                              ( )
# 532 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 4 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 2 : 'value) in
    let _6 = (Parsing.peek_val __caml_parser_env 0 : 'value) in
    Obj.repr(
# 65 "parser.mly"
                                               ( )
# 541 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'register) in
    Obj.repr(
# 66 "parser.mly"
                                     ( )
# 549 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'label_branches) in
    Obj.repr(
# 67 "parser.mly"
                            ( )
# 556 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'label) in
    Obj.repr(
# 68 "parser.mly"
                    ( )
# 563 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    Obj.repr(
# 69 "parser.mly"
             ()
# 569 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : 'value) in
    Obj.repr(
# 70 "parser.mly"
                                  ()
# 577 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'register) in
    Obj.repr(
# 71 "parser.mly"
                      ()
# 584 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 72 "parser.mly"
                                   ()
# 592 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 73 "parser.mly"
                                   ()
# 600 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 6 : 'register) in
    let _4 = (Parsing.peek_val __caml_parser_env 4 : int) in
    let _6 = (Parsing.peek_val __caml_parser_env 2 : 'label_branches) in
    let _8 = (Parsing.peek_val __caml_parser_env 0 : 'label_branches) in
    Obj.repr(
# 74 "parser.mly"
                                                                             ()
# 610 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 75 "parser.mly"
                        ()
# 617 "parser.ml"
               : 'instruction))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _4 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 76 "parser.mly"
                                         ()
# 625 "parser.ml"
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
