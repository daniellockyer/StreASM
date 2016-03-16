;Stream arithmetic
;Take two sequences a1 a2 a3 a4
;               and b1 b2 b3 b4
; and produce the single sequence
; a1 + 3b1
; a2 + 3b2
; a3 + 3b3
; a4 + 3b4

main:
	NXT i, stdin		;Get the two streams
	TSTE i0, 2, @NEXT, @END	;Check we had two streams
	MUL r2, i2, 3		;Multiply the second stream value by 3
	ADD r3, i1, r2		;Add the first stream value and the multiplied value
	MOV o1, r3		;Output the calculated value
	NXT stdout, o
	JMP main		;Loop
