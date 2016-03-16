	MOV r1, 0

main:
	INCR r1
	MOV o1, r1
	NXT stdout, o
	TSTE r1, 10, @END, main