;Prefixing
;Take a sequence a1 a2 a3 a4 a5 ..., as an input and output the sequence 0 a1 a2 a3 ..., that is,
;the sequence that is the same as the input sequence, but starting with an additional single 0 character.

	MOV r2, 0		;This is the value to prepend
				;We act like we did a previous cycle with value 0

main:
	NXT i, stdin		;Get the input
	TSTZ i0, @END, @NEXT
	MOV o1, r2		;Move last cycles value to output
	NXT stdout, o
	MOV r2, i1		;Move the input to the buffer for next cycle
	JMP main		;Loop
