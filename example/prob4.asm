; Take a sequence a1 a2 a3 a4 . . . and output the sequence a1 a1+a2 a1+a2+a3 a1+a2+a3+a4 . . . where each term of the output is the sum of all the input terms up to that point.

	MOV r1, 0
	MOV o0, 1

main:
	NXT i, stdin
	TSTZ i0, @END, @NEXT
	ADD r1, i1, r1
	MOV o1, r1
	NXT stdout, o
	JMP main