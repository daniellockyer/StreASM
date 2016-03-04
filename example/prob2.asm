;Copying
;Take a sequence a1 a2 a3 a4 a5 . . . as an input and output two copies of it per line

main:
	NXT i, stdin
	TSTZ i0, @END, @NEXT
	MOV o1, i1
	MOV o2, i1
	NXT stdout, o
	JMP main