	MOV r1, 0

main:
	MOV o1, r1
	NXT stdout, o
	INCR r1
	TSTLE r1, 10, main, @END
