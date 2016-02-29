exception LookupError ;;
exception TypeError ;;
exception UnboundVariableError;;
exception Terminated ;;
exception StuckTerm ;;
exception NonBaseTypeResult;;

open Printf;;

(* Types of the language *)
type toyType =  ToyInt | ToyBool | ToyFun of toyType * toyType

(* Grammar of the language *)
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

let rec isValue e = match e with 
  | TmNum(n) -> true
  | TmBool(b) -> true 
  | TmAbs(x,tT,e') -> true 
  | _ -> false 
;;

(* Type of Environments *)

type 'a context = Env of (string * 'a) list 
type typeContext = toyType context 
type valContext = toyTerm context

(* Function to look up the type of a string name variable in a type environment *)
let rec lookup env str = match env with 
   Env [] -> raise LookupError  
  |Env ((name,thing) :: gs) -> 
        ( 
          match (name = str) with 
            true -> thing
           |false -> lookup (Env (gs)) str 
	)
;;

(* Function to add an extra entry in to an environment *)
let addBinding env str thing = match env with 
      Env(gs) -> Env ( (str, thing) :: gs ) ;;


(* The type checking function itself *) 
let rec typeOf env e = match e with 
   TmNum (n) -> ToyInt

  |TmBool (b) -> ToyBool

  |TmLessThan (e1,e2) -> 
    ( match (typeOf env e1) , (typeOf env e2) with 
        ToyInt, ToyInt -> ToyBool
      | _ -> raise TypeError
    )

  |TmPlus(e1,e2) -> 
    (
     match (typeOf env e1) , (typeOf env e2) with 
             ToyInt, ToyInt -> ToyInt 
                    |_ -> raise TypeError
    )

  |TmVar (x) ->  (try lookup env x with LookupError -> raise TypeError)

  |TmIf (e1,e2,e3) -> (
    let ty1 = typeOf env e1 in 
      match ty1 with 
         ToyBool -> (
                  let ty1 = typeOf env e2 in 
		  let ty2 = typeOf env e3 in 
		   (match (ty1=ty2) with 
		      true -> ty1 
		     |false -> raise TypeError 
		   )
	)
       |_ -> raise TypeError 
  )

  |TmLet (x, tT, e1, e2) -> 
    (
      let ty1 = typeOf env e1 in
      let ty2 = typeOf (addBinding env x tT) e2 in 
         (match (ty1 = tT) with 
            true -> ty2
	         |false -> raise TypeError
	 )
    )

  |TmApp (e1,e2) -> 
    ( let ty1 = typeOf env e1 in 
      let ty2 = typeOf env e2 in 
       ( 
        match ty1 with 
         ToyFun(tT,tU) ->  
            (
	     match tT = ty2 with
             true -> tT 
            |false -> raise TypeError
	    )
	| _ -> raise TypeError 
       )
    )

  |TmAbs (x,tT,e) ->  ToyFun(tT, typeOf (addBinding env x tT) e) 

let typeProg e = typeOf (Env []) e ;;


let rec eval1M env e = match e with
  | (TmVar x) -> (try ((lookup env x) , env) with LookupError -> raise UnboundVariableError)
  | (TmNum n) -> raise Terminated 
  | (TmBool b) -> raise Terminated 
  | (TmAbs(x,tT,e')) -> raise Terminated

  | (TmLessThan(TmNum(n),TmNum(m))) -> (TmBool( n < m ) , env)
  | (TmLessThan(TmNum(n), e2))      -> let (e2',env') = (eval1M env e2) in (TmLessThan(TmNum(n),e2'),env')
  | (TmLessThan(e1, e2))            -> let (e1',env') = (eval1M env e1) in (TmLessThan(e1',e2),env')

  | (TmPlus(TmNum(n),TmNum(m))) -> (TmNum( n + m ) , env) 
  | (TmPlus(TmNum(n), e2))      -> let (e2',env') = (eval1M env e2) in (TmPlus(TmNum(n),e2'),env')
  | (TmPlus(e1, e2))            -> let (e1',env') = (eval1M env e1) in (TmPlus(e1', e2) ,env')

  | (TmIf(TmBool(true),e1,e2))    -> (e1, env)
  | (TmIf(TmBool(false),e1,e2))   -> (e2, env)
  | (TmIf(b,e1,e2))               -> let (b',env') = (eval1M env b) in (TmIf(b',e1,e2), env')

  | (TmLet(x,tT,e1,e2)) when (isValue(e1)) ->  (e2, addBinding env x e1) 
  | (TmLet(x,tT,e1,e2))                    -> let (e1',env') = (eval1M env e1) in (TmLet(x,tT,e1',e2), env')

  | (TmApp(TmAbs(x,tT,e), e2)) when (isValue(e2)) -> (e, addBinding env x e2)
  | (TmApp(TmAbs(x,tT,e), e2))                    -> let (e2',env') = (eval1M env e2) in (TmApp( TmAbs(x,tT,e) , e2') , env')
  | (TmApp(e1,e2))                                -> let (e1',env') = (eval1M env e1) in (TmApp(e1',e2), env')

  | _ -> raise Terminated ;;


let rec evalloop env e = try (let (e',env') = (eval1M env e) in (evalloop env' e')) with Terminated -> if (isValue e) then e else raise StuckTerm  ;;
let evalProg e = evalloop (Env []) e ;;


let rec free e x = match e with 
   TmVar(y) -> (x=y) 
  |TmNum(n) -> false
  |TmBool(b) -> false
  |TmIf(t1,t2,t3) -> (free t1 x) || (free t2 x) || (free t3 x)
  |TmLessThan(e1,e2) -> (free e1 x) || (free e2 x) 
  |TmPlus(e1,e2) -> (free e1 x) || (free e2 x) 
  |TmApp(e1,e2) -> (free e1 x) || (free e2 x)
  |TmAbs(y,tT,e1) when (x=y) -> false 
  |TmAbs(y,tT,e1)            -> (free e1 x)
  |TmLet(y,tT,e1,e2) when (x=y) -> (free e1 x) 
  |TmLet(y,tT,e1,e2)            -> (free e1 x) || (free e2 x)
;;

let rename (s:string) = s^"'";;

let rec subst e1 x e2 = match e2 with 
    TmVar(y) when (x=y) -> e1 
  | TmVar(y)            -> TmVar(y)
  | TmNum(n) -> TmNum(n)
  | TmBool(b) -> TmBool(b)
  | TmIf(b,e21,e22) -> TmIf( (subst e1 x b) , (subst e1 x e21) , (subst e1 x e22) )
  | TmLessThan (e21, e22) -> TmLessThan( (subst e1 x e21) , (subst e1 x e22) )
  | TmPlus(e21, e22) -> TmPlus( (subst e1 x e21) , (subst e1 x e22) )
  | TmApp(e21, e22) -> TmApp( (subst e1 x e21) , (subst e1 x e22) )
  | TmAbs(y,tT,e21) when (x=y) -> TmAbs(y,tT,e21)
  | TmAbs(y,tT,e21) when (not (free e1 y)) -> TmAbs(y,tT,subst e1 x e21)
  | TmAbs(y,tT,e21) when (free e1 y) -> let yy = rename y in subst e1 x (TmAbs(yy,tT, (subst (TmVar(yy)) y e21)))
  | TmLet(y,tT,e21,e22) when (x=y) -> TmLet(y,tT,e21,e22)
  | TmLet(y,tT,e21,e22) when (not(free e1 y)) -> TmLet(y,tT, subst e1 x e21 , subst e1 x e22)
  | TmLet(y,tT,e21,e22) when ((free e1 y)) -> let yy = rename y in subst e1 x ( TmLet(yy, tT, subst (TmVar(yy)) y e21 , subst (TmVar(yy)) y e22) )
 ;;

let rec eval1S e = match e with
  | (TmVar x) -> raise Terminated
  | (TmNum n) -> raise Terminated 
  | (TmBool b) -> raise Terminated 
  | (TmAbs(x,tT,e')) -> raise Terminated

  | (TmLessThan(TmNum(n),TmNum(m))) -> TmBool( n < m )
  | (TmLessThan(TmNum(n), e2))      -> let e2' = (eval1S e2) in TmLessThan(TmNum(n),e2')
  | (TmLessThan(e1, e2))            -> let e1' = (eval1S e1) in TmLessThan(e1',e2)

  | (TmPlus(TmNum(n),TmNum(m))) -> TmNum( n + m )
  | (TmPlus(TmNum(n), e2))      -> let e2' = (eval1S e2) in TmPlus(TmNum(n),e2')
  | (TmPlus(e1, e2))            -> let e1' = (eval1S e1) in TmPlus(e1', e2)

  | (TmIf(TmBool(true),e1,e2))    -> e1
  | (TmIf(TmBool(false),e1,e2))   -> e2
  | (TmIf(b,e1,e2))               -> let b' = (eval1S b) in TmIf(b',e1,e2)

  | (TmLet(x,tT,e1,e2)) when (isValue(e1)) ->  subst e1 x e2
  | (TmLet(x,tT,e1,e2))                    -> let e1' = (eval1S e1) in TmLet(x,tT,e1',e2)

  | (TmApp(TmAbs(x,tT,e), e2)) when (isValue(e2)) -> subst e2 x e
  | (TmApp(TmAbs(x,tT,e), e2))                    -> let e2' = (eval1S e2) in TmApp( TmAbs(x,tT,e) , e2')
  | (TmApp(e1,e2))                                -> let e1' = (eval1S e1) in TmApp(e1',e2)

  | _ -> raise Terminated ;;


let rec evalloopS e = try ( let e' = eval1S e in evalloopS e') with Terminated -> if (isValue e) then e else raise StuckTerm ;;
let evalProgS e = evalloopS e ;;


let rec bigEval e = match e with 
  |  (TmVar x) -> raise StuckTerm 
  |  e when (isValue(e)) -> e
  |  TmLessThan(e1,e2) -> let v1 = bigEval e1 in 
                          let v2 = bigEval e2 in
                            (match (v1,v2) with (TmNum(n), TmNum(m)) -> TmBool(n < m) | _ -> raise StuckTerm)
  |  TmPlus(e1,e2) -> let v1 = bigEval e1 in 
                      let v2 = bigEval e2 in
                            (match (v1,v2) with (TmNum(n), TmNum(m)) -> TmNum(n + m) | _ -> raise StuckTerm)
  |  TmIf(b,e1,e2) -> let bv = bigEval b in (match bv with 
                                           |  (TmBool(true)) -> bigEval e1 
                                           |  (TmBool(false)) -> bigEval e2 
                                           | _ -> raise StuckTerm 
                                            )
  |   TmLet(x,tT,e1,e2) -> let v = bigEval e1 in (bigEval (subst v x e2))
  |   TmApp(TmAbs(x,tT,e1), e2) -> let v = bigEval e2 in (bigEval (subst v x e1))
;;


let rec type_to_string tT = match tT with 
  | ToyInt -> "Int"
  | ToyBool -> "Bool"
  | ToyFun(tT1,tT2) -> "( "^type_to_string(tT1)^" -> "^type_to_string(tT2)^" )"
;;

let print_res res = match res with
    | (TmNum i) -> print_int i ; print_string " : Int" 
    | (TmBool b) -> print_string (if b then "true" else "false") ; print_string " : Bool"
    | (TmAbs(x,tT,e)) -> print_string("Function : "^type_to_string( typeProg (res) ))
    | _ -> raise NonBaseTypeResult
