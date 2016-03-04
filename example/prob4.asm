; Take a sequence a1 a2 a3 a4 and output the sequence
; a1
; a1+a2
; a1+a2+a3
; a1+a2+a3+a4
; where each term of the output is the sum of all the input terms up to that point.

	MOV r1, 0		;r0 is an accumulator, we add everything here

main:
	NXT i, stdin		;Get the input
	TSTZ i0, @END, @NEXT
	ADD r1, i1, r1		;Add it to the accumulator
	MOV o1, r1		;Output it
	NXT stdout, o
	JMP main		;Loop
