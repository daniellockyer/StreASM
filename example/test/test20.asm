	MOV r1, 1

main:
	MUL r2, r1, r1
	MOV o1, r2
	NXT stdout, o
	INCR r1
	TSTLE r1, 12, main, @END
