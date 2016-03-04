	MOV a1, 0
	CALL func
	MOV o1, 5678
	NXT stdout, o
	JMP @END
func:
	MOV o1, 1234
	NXT stdout, o
	RET
	MOV o1, -999999
	NXT stdout, o
