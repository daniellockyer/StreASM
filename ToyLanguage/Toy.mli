type toyType = ToyInt | ToyBool | ToyFun of toyType * toyType

type toyTerm = 
    TmNum of int
    | TmBool of bool
    | TmLessThan of toyTerm * toyTerm
    | TmPlus of toyTerm * toyTerm 
    | TmVar of string
    | TmIf of toyTerm * toyTerm * toyTerm
    | TmLet of string * toyType * toyTerm * toyTerm 
    | TmAbs of string * toyType * toyTerm
    | TmApp of toyTerm * toyTerm 

val typeProg : toyTerm -> toyType 
val evalProg :  toyTerm -> toyTerm
val evalProgS :  toyTerm -> toyTerm 
val bigEval : toyTerm -> toyTerm

val print_res : toyTerm -> unit
