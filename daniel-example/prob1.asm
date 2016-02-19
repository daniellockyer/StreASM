;Prefixing
;Take a sequence a1 a2 a3 a4 a5 . . . as an input and output the sequence 0 a1 a2 a3 . . ., that is,
;the sequence that is the same as the input sequence, but starting with a single 0 character.

MOV r2, 0 ;First output variable to be 0. r2 is 0 anyway but nice to make it explicit.

main:
	READ r1, stdin ;Read input from stdin
	CMPNULL r1, @END ;Jump to end if null
	OUT r2 ;Output the variable we need to.
	MOV r2, r1 ;Update the variable to print on the next iteration.
	JMP main