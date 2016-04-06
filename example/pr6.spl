;Copying + Prefix
;Take a sequence a1 a2 a3 a4 a5 ..., as an input 
;and output two copies of it, the second prefixed with 0

	MOV r1, 0		;This is the value to prepend
main:
	NXT i, stdin	;Get the input
	TSTZ i0, @END, @NEXT
	MOV o1, i1
	MOV o2, r1
	NXT stdout, o
	MOV r1, i1      ;Update the value in the buffer
	JMP main		;Loop

