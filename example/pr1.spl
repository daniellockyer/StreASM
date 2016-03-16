;Prefixing
;Take a sequence a1 a2 a3 a4 a5 ..., as an input and output the sequence 0 a1 a2 a3 ..., that is,
;the sequence that is the same as the input sequence, but starting with an additional single 0 character.

	MOV r1, 0		;This is the value to prepend

main:
	NXT i, stdin		;Get the input
	TSTZ i0, final, @NEXT
	MOV o1, r1
	NXT stdout, o
	MOV r1, i1
	JMP main		;Loop

final:
	MOV o1, r1
	NXT stdout, o