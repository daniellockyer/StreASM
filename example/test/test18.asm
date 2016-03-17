	MOV r1, 10

main:
	MOV o1, r1
	NXT stdout, o
	DECR r1
	TSTG r1, 0, main, @END