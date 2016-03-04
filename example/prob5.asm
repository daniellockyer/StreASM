; Take a sequence a1 a2 a3 a4 a5 . . . and output the sequence
;	1a1 
;	1a1 + 1a2 
;	2a1 + a2 + a3 
;	3a1 + 2a2 + a3 + a4 
;	5a1 + 3a2 + 2a3 + a4 . . .
; where the coefficients of each input term in the sums follows the Fibonacci series 1 1 2 3 5 8 . . . from when it first appears. Recall that the Fibonacci series starts with two 1s and then the subsequent terms are always the sum of the previous two
; c[c0] * f[count]

;c0 is which cycle we are on
;f1+ is the fib numbers f1 = 1, f2 = 1, f3 = 2, etc
;c1+ are the values we have stored, stored c1 before c2, etc
;r is the working array
;initialise some stuff
;do the first cycle
	MOV f0, 0
	MOV f1, 1
	NXT i, stdin
	TSTZ i0, @END, @NEXT
	MOV c1, i1
	MOV o1, c1
	MOV o0, 1
	NXT stdout, o
	MOV c0, 1

main:
	INCR c0
	NXT i, stdin
	TSTZ i0, @END, @NEXT
	MOV c[c0], i1
	SUB r0, c0, 2
	SUB r1, c0, 1
	ADD f[c0], f[r0], f[r1]

	MOV r2, 0
	MOV r0, 1
	SUB r3, c0, 1
out	TSTE r0, c0, output, @NEXT
	MUL r1, f[r0], c[r3]
	ADD r2, r2, r1
	INCR r0
	DECR r3
	JMP out
output	MOV o0, 1
	MOV o1, r2
	NXT stdout,o
	JMP main
