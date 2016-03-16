; Take a sequence a1 a2 a3 a4 a5 . . . and output the sequence
;	1a1
;	1a1 + 1a2
;	2a1 + a2 + a3
;	3a1 + 2a2 + a3 + a4
;	5a1 + 3a2 + 2a3 + a4 + a5
; where the coefficients of each input term in the sums follows the Fibonacci series 1 1 2 3 5 8 . . . from when it first appears. Recall that the Fibonacci series starts with two 1s and then the subsequent terms are always the sum of the previous two

	MOV r0, 0				; n-2 term
	MOV r1, 0				; n-1 term

main:
	NXT i, stdin			; Get the next input
	TSTZ i0, @END, @NEXT 	; Check we actually got a value
	MOV r2, i1				; The new value we just entered
	ADD r3, r1, r0			; Sum of the two previous terms
	ADD r3, r2, r3			; Add on the number from this cycle
	MOV o1, r3				; Put our result to the outputs
	NXT stdout, o
	MOV r0, r1				; Update n-2 term
	MOV r1, r3				; Update n-1 term
	JMP main				; Loop
