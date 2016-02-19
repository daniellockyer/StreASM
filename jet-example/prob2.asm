;Copying
;Take a sequence a1 a2 a3 a4 a5 . . . as an input and output two copies of it

main:
	MOV r1, stdin		;Read stdin and store in r1
	CMPNULL r1, @END 	;Jump to end if null
	MOV stdout, r1		;Output r1 twice
	MOV stdout, r1
	NXT stdin		;Increase stdin to the next value
	JMP main 		
