(* File lexer.mll *)
{
open Parser        (* The type token is defined in parser.mli *)
}
rule lexer_main = parse
      [' ' '\t' '\n']     { lexer_main lexbuf }     (* skip blanks *)
    | ['0'-'9']+ as lxm { INT(int_of_string lxm) }
    | "Bool"   { BTYPE }
    | "Int"    { ITYPE }
    | "->"     { FUNTYPE }
    | "let"    { LET }
    | "in"     { IN }
    | "if"     { IF }
    | "then"   { THEN }
    | "else"   { ELSE }
    | "true"   { TRUE }
    | "false"  { FALSE }
    | ['a'-'z']+ as lxm { IDENT(lxm) }
    | '+'      { PLUS }
    | '<'      { LESSTHAN }
    | ':'      { COLON }
    | '('      { LPAREN }
    | ')'      { RPAREN }
    | ':'      { COLON }
    | '='      { EQUALS }
    | "\\l"     { LAMBDA }
    | eof      { EOF }
