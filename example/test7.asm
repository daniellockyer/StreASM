	NXT i, stdin
	MOV o0, 1
	TSTE i0, 1, main, nmain
main	MOV o1, 1
	NXT stdout, o
	JMP @END
nmain	MOV o1, 0
	NXT stdout, o
