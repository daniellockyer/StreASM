;Prefixing
;Take a sequence a1 a2 a3 a4 a5 . . . as an input and output the sequence 0 a1 a2 a3 . . ., that is,
;the sequence that is the same as the input sequence, but starting with a single 0 character.

MOV r2, 0 	;First output variable to be 0. r2 is 0 anyway but nice to make it explicit.

main:
	MOV r1, stdin		;Store the value for next iteration
	MOV stdout, r2		;Output the variable for this iteration.	 
	TSTSNN r1		;Terminate if end of stream
	JMP @END		
	MOV r2, r1		;Update the variable to print on the next iteration.
	NXT stdin		;Increase stdin to the next value
	JMP main
	
