; Take a sequence a1 a2 a3 a4 a5 . . . and output the sequence
;	1a1
;	1a1 + 1a2
;	2a1 + a2 + a3
;	3a1 + 2a2 + a3 + a4
;	5a1 + 3a2 + 2a3 + a4 + a5
; where the coefficients of each input term in the sums follows the Fibonacci series 1 1 2 3 5 8 . . . from when it first appears. Recall that the Fibonacci series starts with two 1s and then the subsequent terms are always the sum of the previous two

;c0 is which cycle we are on
;f1+ is the fib numbers f1 = 1, f2 = 1, f3 = 2, etc
;c1+ are the values we have stored, stored c1 before c2, etc
;r is the working array

;initialise some stuff
	MOV f-1, 1			;The -1th Fib Num can be seen to be 1
	MOV f0, 0			;and the 0th can be seen to be 0.
	MOV c0, 0			;Initialise c0

main:
	INCR c0				;Increment to be on the next cycle
	NXT i, stdin			;Get the next input
	TSTZ i0, @END, @NEXT
	MOV c[c0], i1
	SUB r0, c0, 2			;Create the next Fib number
	SUB r1, c0, 1
	ADD f[c0], f[r0], f[r1]		;Put it in the f register for this cycle.

	MOV r2, 0			;r2 is an accumulator to be put on the output
	MOV r0, 1			;r0 is the index for stored values
	MOV r3, c0			;r3 is the index for Fib numbers
out:
	TSTG r0, c0, output, @NEXT
	MUL r1, f[r3], c[r0]		;ex: acc += fib[count + 1 - iter] * stored[count]
	ADD r2, r2, r1
	INCR r0				;Increment/Decrement the two indexes to look at
	DECR r3				;the next values
	JMP out
output:
	MOV o1, r2			;Put our stuff on the outputs
	NXT stdout,o
	JMP main
