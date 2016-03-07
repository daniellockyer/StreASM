;Prefixing
;Take a sequence a1 a2 a3 a4 a5 ..., as an input and output the sequence 0 a1 a2 a3 ..., that is,
;the sequence that is the same as the input sequence, but starting with an additional single 0 character.

	MOV o0, 1
	MOV o1, 0		;This is the value to prepend
	NXT stdout, o 	;We act like we did a previous cycle with value 0

main:
	NXT o, stdin		;Get the input
	MOV o0, 1
	NXT stdout, o
	JMP main		;Loop