	MOV o1, 0
	NXT stdout, o
	CALL func
	MOV o1, 4
	NXT stdout, o
	RET		;Return stack empty; equiv to JMP @END

func:
	MOV o1, 1
	NXT stdout, o
	CALL funcy
	MOV o1, 3
	NXT stdout, o
	RET

funcy:
	MOV o1, 2
	NXT stdout, o
	RET
