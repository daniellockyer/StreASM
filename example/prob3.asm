;Stream arithmetic
;Take two sequences a1 a2 a3 a4 ... and b1 b2 b3 b4 ..., and produce the sequence
;	a1 + 3b1 a2 + 3b2 a3 + 3b3 a4 + 3b4 ...

	MOV o0, 1

main:
	NXT i, stdin
	TSTE i0, 2, @NEXT, @END
	MOV r1, i1
	MUL r2, i2, 3
	ADD r3, r1, r2
	MOV o1, r3
	NXT stdout, o
	JMP main