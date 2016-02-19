;Prefixing
;Take a sequence a1 a2 a3 a4 a5 . . . as an input and output the sequence 0 a1 a2 a3 . . ., that is,
;the sequence that is the same as the input sequence, but starting with a single 0 character.

MOV r2, 0 	;First output variable to be 0. r2 is 0 anyway but nice to make it explicit.

main:
	MOV r1, stdin		;Store the value for next iteration
	;NOTE: The output line must be before the CMPNULL - see below
	MOV stdout, r2		;Output the variable for this iteration.	 
	CMPNULL r1, @END	;Jump to end if null
	MOV r2, r1		;Update the variable to print on the next iteration.
	NXT stdin		;Increase stdin to the next value
	JMP main
	

;r2 - 0

;r1 - 1
;cmp
;output r2 - 0
;r2 - 1
;jmp

;r1 - 2
;cmp
;output r2 - 1
;r2 - 2
;jmp

;r1 - 3
;cmp
;output r2 - 2
;r2 - 3
;jmp

;r1 - 4
;cmp
;output r2 - 3
;r2 - 4
;jmp

;r1 - null
;cmp
;output r2 - 4
;r2 - null
;jmp
