; Take a sequence a1 a2 a3 a4 a5 . . . and output the sequence
;	a1 
;	a1 + a2 
;	2a1 + a2 + a3 
;	3a1 + 2a2 + a3 + a4 
;	5a1 + 3a2 + 2a3 + a4 . . .
; where the coefficients of each input term in the sums follows the Fibonacci series 1 1 2 3 5 8 . . . from when it first appears. Recall that the Fibonacci series starts with two 1s and then the subsequent terms are always the sum of the previous two


main:
	NXT i, stdin
	TSTZ i0, @END, @NEXT