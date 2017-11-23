;Copying
;Take a sequence a1 a2 a3 a4 a5 as an input
; and output two copies of it per line;
; a1 a1
; a2 a2
; a3 a3

main:
	NXT i, stdin		;Get the inputs
	TSTZ i0, @END, @NEXT
	MOV o1, i1		;Move the input value to the two output registers
	MOV o2, i1
	NXT stdout, o		;and output them
	JMP main		;Loop
