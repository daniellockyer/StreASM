;Copying
;Take a sequence a1 a2 a3 a4 a5 . . . as an input and output two copies of it per line

main:
	MOV r1, stdin		;Read stdin and store in r1
	CMPNULL r1, @END 	;Jump to end if null
	MERGE r2, r1, r1	;Make r2 = r1 r1
	MOV stdout, r2		;Output r2
	NXT stdin		;Increase stdin to the next value
	JMP main 		
