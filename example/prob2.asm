;Copying
;Take a sequence a1 a2 a3 a4 a5 . . . as an input and output two copies of it per line

	MOV o0, 2

main:
	NXT i, stdin		;Read stdin and store in r1
	TSTZ i0, @END, @NEXT	;Terminate if end of stream
	MOV o1, i1
	MOV o2, i1
	NXT stdout, o
	JMP main 		
