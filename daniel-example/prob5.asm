;Fibonacci
;Take a sequence a1 a2 a3 a4 a5 . . . and output the sequence
;a1 a1 + a2 2a1 + a2 + a3 3a1 + 2a2 + a3 + a4 5a1 + 3a2 + 2a3 + a4 . . .
;where the coefficients of each input term in the sums follows the Fibonacci series 1 1 2 3 5 8 . . .
;from when it first appears. Recall that the Fibonacci series starts with two 1s and then the
;subsequent terms are always the sum of the previous two.

; Only generates an infinite Fibonacci sequence.

MOV r1, 1
MOV r2, 1
OUT r1
OUT r2

main:
	MOV r3, r2
	ADD r3, r1
	MOV r1, r2
	MOV r3, r2
	OUT r2
	JMP main