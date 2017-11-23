;Delayed Feedback
;Take a sequence a1 a2 a3 a4 a5 ... as an input
;and output
;a1
;a2
;a3 + (a1)
;a4 + (a2)
;a5 + (a3 + a1)
;a6 + (a4 + a2)
;that is, the first two outputs are the same as the first two inputs.
;Then, to produce the output at time n > 2, the current input a(n)
;is added to the value which was previously output at time n - 2.

	MOV n-1, 0		;This is n - 1
	MOV n-2, 0		;This is n - 2
main:
	NXT i, stdin	;Get the input
	TSTZ i0, @END, @NEXT
	ADD o1, i1, n-2	;Output the input + n-2
	MOV n-2, n-1	;Increase the indexes (n-1 -> n-2)
	MOV n-1, o1		;			(n -> n-1)
	NXT stdout, o	;Output n
	JMP main		;Loop

