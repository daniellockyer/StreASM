;Copying + Prefix + Stream Arithmetic
;Take a sequence a1 a2 a3 a4 a5 ... as an input
;and output a1 + 0, a2 + a1, a3 + a2, a4 + a3, a5 + a4, ...

	MOV r1, 0		;This is the value to add
main:
	NXT i, stdin	;Get the input
	TSTZ i0, @END, @NEXT
	ADD o1, i1, r1	;Input + Stored
	NXT stdout, o
	MOV r1, i1      ;Update the value in the buffer
	JMP main		;Loop

